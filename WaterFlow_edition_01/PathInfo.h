//
//  PathInfo.h
//  WaterFlow_edition_01
//
//  Created by dev fndsoft on 5/21/13.
//  Copyright (c) 2013 marginChang. All rights reserved.
//

#import "CellInfo.h"

@interface PathInfo : NSObject

@property (nonatomic, assign) NSUInteger column;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign, readonly) CGFloat height;

/**
	路径中包含的cell个数
	@returns cell个数
 */
- (NSUInteger)numberOfCells;



/**
	根据row返回cellInfo对象
	@param row 行号
	@returns cellInfo对象
 */
- (CellInfo *)cellInfoForRow:(NSUInteger)row;


/**
	将cell加入路径
	@param cellInfo 包含cell信息的的cellInfo对象
 */
- (void)addCellInfo:(CellInfo *)cellInfo;


@end
