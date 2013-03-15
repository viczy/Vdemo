//
//  VDScrollViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 3/13/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDScrollViewController.h"

@interface VDScrollViewController ()

@property (nonatomic, strong) UIScrollView *scrollviewBoom;
@property (nonatomic, strong) UIButton *buttonPro;
@property (nonatomic, strong) UITableView *tableviewList;

@end

@implementation VDScrollViewController

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
	self.scrollviewBoom = [[UIScrollView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.scrollviewBoom.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.scrollviewBoom];
    
    self.buttonPro = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.buttonPro.frame = CGRectMake(0.f, 0.f, 320.f, 100.f);
    [self.view addSubview:self.buttonPro];
    
    self.tableviewList = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 100.f, self.view.bounds.size.width, self.view.bounds.size.height-100.f)];
    self.tableviewList.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.tableviewList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
