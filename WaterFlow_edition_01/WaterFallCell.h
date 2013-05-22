//
//  WaterFallCell.h
//  WaterFlow_edition_01
//
//  Created by dev fndsoft on 5/20/13.
//  Copyright (c) 2013 marginChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFallCell : UIView

@property (nonatomic, retain, readonly) UIImageView *imageView;
@property (nonatomic, copy, readonly) NSString *reuseIdentifier;



/**
	利用重用标识符创建cell实例对象
	@param aReuseIdentifier 重用标识符
	@returns cell实例对象
 */
- (id)initWithReuseIdentifier:(NSString *)aReuseIdentifier;


/**
	cell准备重用之前调用，用于清空imageView的image等其他属性
 */
- (void)prepareToReuse;

@end
