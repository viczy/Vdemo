//
//  UIImageView+Clipped.m
//  Vdemo
//
//  Created by Vic Zhou on 3/19/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "UIImageView+Clipped.h"

@implementation UIImageView (Clipped)

- (void)resetImageClipped {
    UIImage *image = self.image;
    if (!image) {//no image
        return;
    }else {
        CGSize imageSize = image.size;
        CGSize imageviewSize = self.frame.size;
        CGRect clipRect;
        if (imageSize.width <= imageviewSize.width) {//width longer
            if (imageSize.height <= imageviewSize.height) {//height longer
                return;
            }else {
                clipRect = CGRectMake(0.f, (imageSize.height-imageviewSize.height)/2, imageviewSize.width, imageviewSize.height);
            }
        }else {
            if (imageSize.height <= imageviewSize.height) {
                clipRect = CGRectMake((imageSize.width-imageviewSize.width)/2, 0.f, imageviewSize.width, imageviewSize.height);
            }else {
                clipRect = CGRectMake((imageSize.width-imageviewSize.width)/2, (imageSize.height-imageviewSize.height)/2, imageviewSize.width, imageviewSize.height);
            }
        }
        float scale = 2;
        CGImageRef imageRef = self.image.CGImage;
        CGImageRef imgrefout = CGImageCreateWithImageInRect(imageRef, CGRectMake(clipRect.origin.x*scale, clipRect.origin.y*scale, clipRect.size.width*scale, clipRect.size.height*scale));
        UIImage *newImage = [[UIImage alloc]initWithCGImage:imgrefout];
        self.image = newImage;
    }
}

@end
