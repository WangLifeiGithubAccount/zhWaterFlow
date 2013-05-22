//
//  PathInfo.m
//  WaterFlow_edition_01
//
//  Created by dev fndsoft on 5/21/13.
//  Copyright (c) 2013 marginChang. All rights reserved.
//

#import "PathInfo.h"

@interface PathInfo ()

@property (nonatomic, retain) NSMutableArray *pathInfos;

@end

@implementation PathInfo

@synthesize x, width, headerHeight, height, column, pathInfos;

#pragma mark - Setter and getter

- (CGFloat)height
{
    if ([[self pathInfos] count] == 0) {
        return [self headerHeight];
    } else {
        return CGRectGetMaxY([[[self pathInfos] lastObject] frame]);
    }
}

- (NSMutableArray *)pathInfos
{
    if (pathInfos == nil) {
        [self setPathInfos:[NSMutableArray arrayWithCapacity:0]];
    }
    return pathInfos;
}

#pragma mark - Custom methods

- (NSUInteger)numberOfCells
{
    return [[self pathInfos] count];
}

- (void)addCellInfo:(CellInfo *)cellInfo
{
    [[self pathInfos] addObject:cellInfo];
}

- (CellInfo *)cellInfoForRow:(NSUInteger)row
{
    if (row < [self numberOfCells]) {
        return [[self pathInfos] objectAtIndex:row];
    } else {
        return nil;
    }
}

#pragma mark - Memory management

- (void)dealloc
{
    [super dealloc];
}

@end
