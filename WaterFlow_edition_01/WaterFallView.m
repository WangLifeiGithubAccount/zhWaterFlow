//
//  WaterFallView.m
//  WaterFlow_edition_01
//
//  Created by dev fndsoft on 5/20/13.
//  Copyright (c) 2013 marginChang. All rights reserved.
//


#import "WaterFallView.h"
#import "WaterFallCell.h"
#import "CellInfo.h"
#import "PathInfo.h"
#import <QuartzCore/QuartzCore.h>

@interface WaterFallView ()

@property (nonatomic, assign) NSUInteger numberOfPaths;
@property (nonatomic, retain) NSMutableArray *visibleCells;
@property (nonatomic, retain) NSMutableArray *pathInfos;
@property (nonatomic, retain) NSMutableDictionary *reusableCells;

@end


@implementation WaterFallView

const static NSUInteger defaultColumn = 3;
const static CGFloat defaultCellGap = 5.0f;
const static CGFloat defaultRightMargin = 5.0f;

static NSString *rowKey = @"rowKey";


@synthesize waterFallDataSource, visibleCells, backgroundView, cellGap, headerHeight;
@synthesize numberOfPaths, pathInfos, reusableCells, rightMargin;

#pragma mark - static methods

+ (void)reverseArray:(NSMutableArray *)array
{
    for (NSInteger i = 0, j = [array count] - 1; i < j; i++, j--) {
        id tmp = [array objectAtIndex:i];
        [array replaceObjectAtIndex:i withObject:[array objectAtIndex:j]];
        [array replaceObjectAtIndex:j withObject:tmp];
    }
}

#pragma mark - View Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCellGap:defaultCellGap];
        [self setRightMargin:defaultRightMargin];
        [self setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = [self bounds];
    CGFloat minY = CGRectGetMinY(bounds);
    CGFloat maxY = CGRectGetMaxY(bounds);
    
    [backgroundView setFrame:bounds];
    
    [[self pathInfos] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self tileCellsOnPath:(PathInfo *)obj minimumY:minY maximumY:maxY];
    }];
    
    CGSize contentSize = [self contentSize];
    
    if (contentSize.height <= [self bounds].size.height) {
        contentSize.height = [self bounds].size.height + 1.0f;
        [self setContentSize:contentSize];
    }
}

#pragma mark - Setter and getter

- (void)setBackgroundView:(UIView *)aBackgroundView
{
    if (backgroundView != aBackgroundView) {
        if ([backgroundView superview] == self) {
            [backgroundView removeFromSuperview];
        }
    }
    backgroundView = aBackgroundView;
    [backgroundView setFrame:[self bounds]];
    [self addSubview:backgroundView];
}

- (void)setWaterFallDataSource:(id<WaterFallViewDataSource>)aWaterFallDataSource
{
    if (waterFallDataSource != aWaterFallDataSource) {
        waterFallDataSource = aWaterFallDataSource;
    }
}

- (NSMutableDictionary *)reusableCells
{
    if (reusableCells == nil) {
        [self setReusableCells:[NSMutableDictionary dictionaryWithCapacity:0]];
    }
    return reusableCells;
}

#pragma mark - Custom methods


- (PathInfo *)shortestPathInPathInfos
{
    __block PathInfo *shortestPath = nil;
    __block CGFloat minHeight = 0.0f;
    
    [[self pathInfos] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PathInfo *pathInfo = (PathInfo *)obj;
        if (shortestPath == nil || [pathInfo height] < minHeight) {
            shortestPath = pathInfo;
            minHeight = [pathInfo height];
        }
    }];
    
    return shortestPath;
}

- (PathInfo *)longestPathInPathInfos
{
    __block PathInfo *longestPathInfo = nil;
    __block CGFloat maxHeight = 0.0f;
    
    [[self pathInfos] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PathInfo *pathInfo = (PathInfo *)obj;
        if (longestPathInfo == nil || [pathInfo height] > maxHeight) {
            longestPathInfo = pathInfo;
            maxHeight = [pathInfo height];
        }
    }];
    
    return longestPathInfo;
}


- (void)prepareNeededParametersBeforeLayout
{
    //获取瀑布流列数，默认为3列
    if ([[self waterFallDataSource] respondsToSelector:@selector(numberOfColumnsForWaterFallView:)]) {
        [self setNumberOfPaths:[[self waterFallDataSource] numberOfColumnsForWaterFallView:self]];
    } else {
        [self setNumberOfPaths:defaultColumn];
    }
    
    //如果dataSource返回列数为0，直接return
    if ([self numberOfPaths] == 0) {
        return;
    }
    
    [self setPathInfos:nil];
    
    //空白宽度
    CGFloat spaceWidth = [self numberOfPaths] * [self cellGap] + [self rightMargin];
    
    //预设宽度，当未实现waterFallView:widthOfCellAtColumn:方法时，宽度由列数和边距等决定
    //实现上述协议后宽度取协议指定宽度
    CGFloat fixedCellWidth = -1.0f;
    
    //目前阶段只处理所有cell宽度相等的情况，不等宽度另行处理
    if ([[self waterFallDataSource] respondsToSelector:@selector(waterFallView:widthOfPathOnColumn:)] == NO) {
        //cell宽度
        fixedCellWidth = ([self bounds].size.width - spaceWidth) / [self numberOfPaths];
        if (fixedCellWidth < 0.0f) {
            fixedCellWidth = 0.0f;
        }
    } else {
        // do something 
    }
    
    CGFloat startX = [self cellGap];
    
    NSMutableArray *_visibleCells = [NSMutableArray arrayWithCapacity:[self numberOfPaths]];
    NSMutableArray *_pathInfos = [NSMutableArray arrayWithCapacity:[self numberOfPaths]];
    
    for (NSUInteger column = 0; column < [self numberOfPaths]; column++) {
        [_visibleCells addObject:[NSMutableArray arrayWithCapacity:0]];
        
        CGFloat cellWidth = 0.0f;
        if (fixedCellWidth < 0.0f) {
            cellWidth = [waterFallDataSource waterFallView:self widthOfPathOnColumn:column];
        } else {
            cellWidth = fixedCellWidth;
        }
        
        PathInfo *pathInfo = [[PathInfo alloc] init];
        [pathInfo setColumn:column];
        [pathInfo setHeaderHeight:[self headerHeight]];
        [pathInfo setX:startX];
        [pathInfo setWidth:cellWidth];
        [_pathInfos addObject:pathInfo];
        startX += cellWidth + [self cellGap];
        [pathInfo release];
    }
    
    [self setVisibleCells:_visibleCells];
    [self setPathInfos:_pathInfos];
}

- (void)resetContentSizeByAppendingCells
{
    if ([self numberOfPaths] == 0) {
        [self setContentSize:[self bounds].size];
        return;
    }
    
    CGFloat spaceWidth = [self numberOfPaths] * [self cellGap] + [self rightMargin];
    
    __block CGRect contentFrame = CGRectMake(0, 0, spaceWidth, 0);
    __block NSUInteger fromIndex = 0;
    
    //计算content宽度
    [[self pathInfos] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        PathInfo *pathInfo = (PathInfo *)obj;
        contentFrame.size.width += [pathInfo width];
        fromIndex += [pathInfo numberOfCells];
    }];
    
    //计算content高度
    NSUInteger numberOfCells = [[self waterFallDataSource] numberOfCellsForWaterFallView:self];
    
    for (NSUInteger index = fromIndex; index < numberOfCells; index++) {
        PathInfo *pathInfo = [self shortestPathInPathInfos];
        CGFloat x = [pathInfo x];
        CGFloat y = [pathInfo height] + [self cellGap];
        CGFloat width = [pathInfo width];
        CGFloat height = [waterFallDataSource waterFallView:self heightOfCellAtIndex:index];
        CGFloat aHeight = height * width;
        
        CellInfo *cellInfo = [[CellInfo alloc] init];
        [cellInfo setIndex:index];
        [cellInfo setRow:[pathInfo numberOfCells]];
        [cellInfo setFrame:CGRectMake(x, y, width, aHeight)];
        [pathInfo addCellInfo:cellInfo];
        [cellInfo release];
    }
    
    contentFrame.size.height = [[self longestPathInPathInfos] height] + [self cellGap];
    
    contentFrame = CGRectIntegral(contentFrame);

    [self setContentSize:contentFrame.size];
}

- (void)tileCellsOnPath:(PathInfo *)pathInfo minimumY:(CGFloat)minY maximumY:(CGFloat)maxY
{
    NSMutableArray *cellsOnPath = [[self visibleCells] objectAtIndex:[pathInfo column]];
    
    //回收超出上边界cell
    [[self class] reverseArray:cellsOnPath];
    
    while ([cellsOnPath count] > 0) {
        WaterFallCell* cell = [cellsOnPath lastObject];
        NSInteger row = [[[cell layer] valueForKey:rowKey] integerValue];
        CGRect cellFrame = [[pathInfo cellInfoForRow:row] frame];
        
        if (CGRectGetMaxY(cellFrame) > minY) {
            break;
        }
        
        [self addToReusablePool:cell];
        
        [cell removeFromSuperview];
        [cellsOnPath removeLastObject];
    }
    
    
    //回收超出下边界cell
    [[self class] reverseArray:cellsOnPath];
    
    while ([cellsOnPath count] > 0) {
        WaterFallCell* cell = [cellsOnPath lastObject];
        NSInteger row = [[[cell layer] valueForKey:rowKey] integerValue];
        CGRect cellFrame = [[pathInfo cellInfoForRow:row] frame];
        
        if (CGRectGetMinY(cellFrame) < maxY) {
            break;
        }
        
        [self addToReusablePool:cell];
        
        [cell removeFromSuperview];
        [cellsOnPath removeLastObject];
        
    }
    
    if ([cellsOnPath count] == 0) {
        [self reloadCellsOnPath:pathInfo cellList:cellsOnPath minimumY:minY maximumY:maxY];
    } else {
        
        [[self class] reverseArray:cellsOnPath];
        
        NSInteger firstRow = [[[[cellsOnPath lastObject] layer] valueForKey:rowKey] integerValue];
        
        for (firstRow--; firstRow >= 0; --firstRow) {
            CellInfo *cellInfo = [pathInfo cellInfoForRow:firstRow];
            CGRect cellFrame = [cellInfo frame];
            
            if (CGRectGetMaxY(cellFrame) <= minY) {
                break;
            }
            
            [self tileCellWithCellInfo:cellInfo cellList:cellsOnPath];
        }
        
        
        [[self class] reverseArray:cellsOnPath];
        
        NSInteger lastRow = [[[[cellsOnPath lastObject] layer] valueForKey:rowKey] integerValue];
        
        for (lastRow++; lastRow < [pathInfo numberOfCells]; ++lastRow) {
            CellInfo *cellInfo = [pathInfo cellInfoForRow:lastRow];
            CGRect cellFrame = [cellInfo frame];
            
            if (CGRectGetMinY(cellFrame) >= maxY) {
                break;
            }
            
            [self tileCellWithCellInfo:cellInfo cellList:cellsOnPath];
        }
    }
}

- (void)tileCellWithCellInfo:(CellInfo *)cellInfo cellList:(NSMutableArray *)list
{
    WaterFallCell *cell = [[self waterFallDataSource] waterFallView:self cellForRowAtIndex:[cellInfo index]];
    
    [[cell layer] setValue:[NSNumber numberWithInteger:[cellInfo row]] forKey:rowKey];
    [cell setFrame:CGRectIntegral([cellInfo frame])];
    [list addObject:cell];
    
    NSInteger count = [[self subviews] count];
    
    if (count == 0) {
        [self addSubview:cell];
    } else {
        [self insertSubview:cell atIndex:(count - 1)];
    }
}

- (void)reloadCellsOnPath:(PathInfo *)pathInfo cellList:(NSMutableArray *)list minimumY:(CGFloat)minY maximumY:(CGFloat)maxY
{
    NSInteger row = [self firstRowBelowY:minY inPath:pathInfo];
    
    for (; row < [pathInfo numberOfCells]; row++) {
        CellInfo *cellInfo = [pathInfo cellInfoForRow:row];
        CGRect cellFrame = [cellInfo frame];
        
        if (CGRectGetMinY(cellFrame) >= maxY) {
            break;
        }
        [self tileCellWithCellInfo:cellInfo cellList:list];
    }
}

- (NSInteger)firstRowBelowY:(CGFloat)y inPath:(PathInfo *)pathInfo
{
    NSInteger row = [pathInfo numberOfCells];
    NSInteger left = 0;
    NSInteger right = [pathInfo numberOfCells] - 1;
    
    while (left <= right) {
        NSInteger mid = (left + right) / 2;
        
        if (CGRectGetMaxY([[pathInfo cellInfoForRow:mid] frame]) < y) {
            left = mid + 1;
        } else {
            right = mid - 1;
            row = MIN(row, mid);
        }
    }
    return row;
}

- (void)reloadData
{
    [self removeAllVisibleCells];
    [self setReusableCells:nil];
    [self prepareNeededParametersBeforeLayout];
    [self resetContentSizeByAppendingCells];
    [self scrollsToTop];
    [self setNeedsLayout];
}

- (void)appendData
{
    [self resetContentSizeByAppendingCells];
    [self setNeedsLayout];
}

//移除所有可见cell
- (void)removeAllVisibleCells
{
    [[self visibleCells] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [(NSArray *)obj enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [(WaterFallCell *)obj removeFromSuperview];
        }];
    }];
    [self setVisibleCells:nil];
}

#pragma mark - Reuse mechanism

//在重用池中查询可用cell，并调用prepareToReuse方法清除cell中一些UI控件的内容(text,image等等)
- (WaterFallCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    WaterFallCell *waterFallCell = [self queryReusableCellWithIdentifier:identifier];
    [waterFallCell prepareToReuse];
    return waterFallCell;
}

//将cell添加到重用池
- (void)addToReusablePool:(WaterFallCell *)cell
{
    if ([[cell reuseIdentifier] length] == 0 || [cell reuseIdentifier] == nil) {
        return;
    }
    
    NSMutableArray *fetchedCells = [[self reusableCells] objectForKey:[cell reuseIdentifier]];
    
    if (fetchedCells == nil) {
        fetchedCells = [NSMutableArray arrayWithObject:cell];
        [[self reusableCells] setObject:fetchedCells forKey:[cell reuseIdentifier]];
    } else {
        [fetchedCells addObject:cell];
    }
}

//通过identifier在重用池中查询可用cell
- (WaterFallCell *)queryReusableCellWithIdentifier:(NSString *)identifier
{
    if ([identifier length] == 0 || identifier == nil) {
        return nil;
    }
    
    NSMutableArray *fetchedCells = [[self reusableCells] objectForKey:identifier];
    
    if ([fetchedCells count] == 0) {
        return nil;
    } else {
        WaterFallCell *cell = [[fetchedCells lastObject] retain];
        [fetchedCells removeLastObject];
        return [cell autorelease];
    }
}

#pragma mark - Memory management


- (void)dealloc
{
    [super dealloc];
}

@end
