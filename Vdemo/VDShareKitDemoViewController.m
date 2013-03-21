//
//  VDShareKitDemoViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 3/13/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDShareKitDemoViewController.h"
#import "VDScrollDemoViewController.h"
#import "SHK.h"

@interface VDShareKitDemoViewController ()

@property (nonatomic, strong) UIImageView *imageviewShare;

@end

@implementation VDShareKitDemoViewController

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    
	self.imageviewShare = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height-44.0)];
    self.imageviewShare.image = [UIImage imageNamed:@"PAV.bundle/dj.png"];
    [self.view addSubview:self.imageviewShare];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareAction {
    SHKItem *item = [SHKItem image:self.imageviewShare.image title:@"vic demo share image"];
    
    /* optional examples
     item.tags = [NSArray arrayWithObjects:@"bay bridge", @"architecture", @"california", nil];
     
     //give a source rect in the coords of the view set with setRootViewController:
     item.popOverSourceRect = [self.navigationController.toolbar convertRect:self.navigationController.toolbar.bounds toView:self.view];
     */
    
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	[SHK setRootViewController:self];
	[actionSheet showFromToolbar:self.navigationController.toolbar];
    
//    UIActionSheet *shareSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Share", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Sina", nil), NSLocalizedString(@"QQ", nil), nil];
//    [shareSheet showInView:self.view];
}

#pragma mark -
#pragma mark UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

@end
