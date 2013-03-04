//
//  VDLoadImageViewController.h
//  Vdemo
//
//  Created by Vic Zhou on 3/1/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VDPopImageView.h"

@interface VDLoadImageViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, assign) VDPopImageType imagetype;
@property (nonatomic, strong) NSString *sourcepath;

@end
