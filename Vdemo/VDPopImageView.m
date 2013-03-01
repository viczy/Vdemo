//
//  VDPopImageView.m
//  Vdemo
//
//  Created by Vic Zhou on 3/1/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDPopImageView.h"
#import "VDLoadImageViewController.h"

@interface VDPopImageView ()

@property (nonatomic, strong) UIViewController *baseVC;
@property (nonatomic, assign) VDPopImageType imagetype;
@property (nonatomic, strong) VDLoadImageViewController *jumpVC;

@end

@implementation VDPopImageView

- (id)initWithBaseViewController:(UIViewController*)baseviewcontroller withJumpPath:(NSString*)path mode:(VDPopImageType)imagetype
{
    if (self) {
        self.baseVC = baseviewcontroller;
        self.imagetype = imagetype;
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.jumpVC = [[VDLoadImageViewController alloc] init];
    UINavigationController *navJumpVC = [[UINavigationController alloc] initWithRootViewController:self.jumpVC];
    [self.baseVC presentViewController:navJumpVC animated:YES completion:^ {
        if (self.imagetype == VDPopImageTypeLocal) {
            self.jumpVC.navigationItem.rightBarButtonItem = nil;
        }
        else if (self.imagetype == VDPopImageTypeNet) {
            //do nothing
        }
        else {
            //do nothing
        }
    }];
}

@end
