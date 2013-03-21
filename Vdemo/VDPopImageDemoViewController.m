//
//  VDPopImageViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 3/1/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDPopImageDemoViewController.h"
#import "UIImageView+Clipped.h"

@interface VDPopImageDemoViewController ()


@end

@implementation VDPopImageDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//test data
NSString *path = [[NSBundle mainBundle] pathForResource:@"images" ofType:@"png"];//local
//NSString *path = @"http://222.66.33.210:8002/res/data/icon/3_1361954916257.jpg";//net
    self.popImageView = [[VDPopImageView alloc] initWithBaseViewController:self withJumpPath:path mode:VDPopImageTypeLocal];
    self.popImageView.baseVC = self;
    self.popImageView.frame = CGRectMake(100, 100, 100, 100);
    //need to change
    self.popImageView.image = [UIImage imageNamed:@"PAV.bundle/PAV.bundle/dj.png"];
    [self.popImageView resetImageClipped];
    [self.view addSubview:self.popImageView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
