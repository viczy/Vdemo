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

@property (nonatomic, strong) NSString *sourcepath;
@property (nonatomic, assign) VDPopImageType imagetype;
@property (nonatomic, strong) VDLoadImageViewController *jumpVC;

@end

@implementation VDPopImageView

- (id)initWithBaseViewController:(UIViewController*)baseviewcontroller withJumpPath:(NSString*)path mode:(VDPopImageType)imagetype
{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.sourcepath = path;
        self.baseVC = baseviewcontroller;
        self.imagetype = imagetype;
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.jumpVC = [[VDLoadImageViewController alloc] init];
    self.jumpVC.sourcepath = self.sourcepath;
    self.jumpVC.imagetype = self.imagetype;
    UINavigationController *navJumpVC = [[UINavigationController alloc] initWithRootViewController:self.jumpVC];
    [self.baseVC presentViewController:navJumpVC animated:YES completion:nil];
}

@end
