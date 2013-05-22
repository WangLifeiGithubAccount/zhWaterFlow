//
//  WaterFallView.h
//  WaterFlow_edition_01
//
//  Created by dev fndsoft on 5/20/13.
//  Copyright (c) 2013 marginChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFallCell;

@protocol WaterFallViewDataSource;


@interface WaterFallView : UIScrollView

@property (nonatomic, assign) id<WaterFallViewDataSource> waterFallDataSource;
@property (nonatomic, retain, readonly) NSMutableArray *visibleCells;
@property (nonatomic, retain) UIView *backgroundView;

@property (nonatomic, assign) CGFloat rightMargin;
@property (nonatomic, assign) CGFloat cellGap;
@property (nonatomic, assign) CGFloat headerHeight;

- (WaterFallCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (void)reloadData;
- (void)appendData;

@end





@protocol WaterFallViewDataSource <NSObject>

@required

/**
	获取瀑布流初始时总cell个数
	@param waterFall 瀑布流对象
	@returns cell个数
 */
- (NSUInteger)numberOfCellsForWaterFallView:(WaterFallView *)waterFall;

/**
	根据index和瀑布流对象创建每一个cell
	@param waterFallView 瀑布流对象
	@param index cell的index
	@returns 瀑布流cell
 */
- (WaterFallCell *)waterFallView:(WaterFallView *)waterFallView cellForRowAtIndex:(NSUInteger)index;


/**
	指定每个index对应cell的高度，每个cell的index都不相同
    类似于tag，用以识别不同的cell，
    所以该瀑布流中需要创建多少个cell，就需要传递多少个高度
	@param waterFallView 瀑布流对象
	@param index cell的index
	@returns cell高度
 */
- (CGFloat)waterFallView:(WaterFallView *)waterFallView heightOfCellAtIndex:(NSUInteger)index;

@optional
/**
	瀑布流列数
	@param waterFallView 瀑布流对象
	@returns 瀑布流列数
 */
- (NSUInteger)numberOfColumnsForWaterFallView:(WaterFallView *)waterFallView;


/**
	根据上述方法指定的列数来确定路径宽度，默认为3列，3条路径，
    指定不同宽度，路径宽度也将相应调整
	@param waterFallView 瀑布流对象
	@param column 当前列数
	@returns 路径宽度
 */
- (CGFloat)waterFallView:(WaterFallView *)waterFallView widthOfPathOnColumn:(NSUInteger)column;


@end
