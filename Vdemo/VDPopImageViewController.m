//
//  VDPopImageViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 3/1/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDPopImageViewController.h"
#import "VDPopImageView.h"

@interface VDPopImageViewController ()

@property (nonatomic, strong) VDPopImageView *popImageView;

@end

@implementation VDPopImageViewController

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
    self.popImageView = [[VDPopImageView alloc] initWithBaseViewController:self withJumpPath:@"" mode:VDPopImageTypeLocal];
    self.popImageView.frame = CGRectMake(100, 100, 100, 100);
    //need to change
    self.popImageView.image = nil;
    [self.view addSubview:self.popImageView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
