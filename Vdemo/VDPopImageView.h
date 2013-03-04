//
//  VDPopImageView.h
//  Vdemo
//  need to add afnetwork framework
//  Created by Vic Zhou on 3/1/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    VDPopImageTypeLocal = 1,    //local image
    VDPopImageTypeNet,          //net image
}VDPopImageType;

@interface VDPopImageView : UIImageView

@property (nonatomic, strong) UIViewController *baseVC; //required ,presentvc's rootvc

- (id)initWithBaseViewController:(UIViewController*)viewcontroller withJumpPath:(NSString*)path mode:(VDPopImageType)imagetype;

@end
