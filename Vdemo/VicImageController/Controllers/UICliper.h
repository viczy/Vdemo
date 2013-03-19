//
//  UICliper.h
//  image
//
//  Created by 岩 邢 on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICliper : UIView
{
    UIImageView *imgView;
    CGRect cliprect;
    CGColorRef grayAlpha;
    CGPoint touchPoint;
}

- (id)initWithImageView:(UIImageView*)iv;

- (void)ChangeclipEDGE:(float)x1 x2:(float)x2 y1:(float)y1 y2:(float)y2;

- (void)setclipEDGE:(CGRect)rect;

- (CGRect)getclipRect;

-(void)setClipRect:(CGRect)rect;

-(UIImage*)getClipImageRect:(CGRect)rect;

@end
