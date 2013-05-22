//
//  WaterFallCell.m
//  WaterFlow_edition_01
//
//  Created by dev fndsoft on 5/20/13.
//  Copyright (c) 2013 marginChang. All rights reserved.
//

#import "WaterFallCell.h"

@interface WaterFallCell ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, copy) NSString *reuseIdentifier;

@end


@implementation WaterFallCell

const static CGFloat defaultMargin = 1.0f;

@synthesize imageView, reuseIdentifier;

#pragma mark - View lifecycle

- (id)initWithReuseIdentifier:(NSString *)aReuseIdentifier
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setReuseIdentifier:aReuseIdentifier];
        [self addSubview:[self imageView]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [[self imageView] setFrame:CGRectInset([self bounds], defaultMargin, defaultMargin)];
}

#pragma mark - Setter and getter

- (UIImageView *)imageView
{
    if (imageView == nil) {
        [self setImageView:[[[UIImageView alloc] initWithFrame:CGRectZero] autorelease]];
        [imageView setContentMode:UIViewContentModeScaleAspectFill];
        [imageView setClipsToBounds:YES];
        [imageView setOpaque:NO];
        [imageView setBackgroundColor:[UIColor clearColor]];
    }
    return imageView;
}


#pragma mark - Custom methods

- (void)prepareToReuse
{
    [[self imageView] setImage:nil];
}

#pragma mark - Memory management

- (void)dealloc
{
    [self setImageView:nil];
    [self setReuseIdentifier:nil];
    [super dealloc];
}

@end
