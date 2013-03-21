//
//  VDEditImageDemoViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 3/21/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDEditImageDemoViewController.h"
#import "VIcImageViewController.h"

@interface VDEditImageDemoViewController ()

@property (nonatomic, strong) UIImageView *imageviewEdit;

@end

@implementation VDEditImageDemoViewController

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(EditAction)];
    
	self.imageviewEdit = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height-44.0)];
    self.imageviewEdit.image = [UIImage imageNamed:@"PAV.bundle/dj.png"];
    [self.view addSubview:self.imageviewEdit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)EditAction {
    VIcImageViewController *editImageVC = [[VIcImageViewController alloc] init];
    [self.navigationController pushViewController:editImageVC animated:YES];
}

@end
