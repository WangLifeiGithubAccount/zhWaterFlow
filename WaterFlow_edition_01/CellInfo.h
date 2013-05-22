//
//  CellInfo.h
//  WaterFlow_edition_01
//
//  Created by dev fndsoft on 5/20/13.
//  Copyright (c) 2013 marginChang. All rights reserved.
//

#import <Foundation/Foundation.h>


/*CellInfo对象用来存储每个cell的index，row，frame等属性*/


@interface CellInfo : NSObject

@property (nonatomic, assign) NSUInteger index;
@property (nonatomic, assign) NSUInteger row;
@property (nonatomic, assign) CGRect frame;

@end
