//
//  VDScrollViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 3/13/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDScrollDemoViewController.h"

@interface VDScrollDemoViewController ()

@property (nonatomic, strong) UITableView *tableviewList;
@property (nonatomic, strong) UIView *viewHeader;
@property (nonatomic, strong) UIView *viewSegment;

@end

@implementation VDScrollDemoViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    
    CGFloat heightHeader = 100.f;
    CGFloat heightSegment = 40.f;
    
    self.viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, heightHeader)];
    self.viewHeader.backgroundColor = [UIColor purpleColor];
    
    self.viewSegment = [[UIView alloc] initWithFrame:CGRectMake(0.f, heightHeader-heightSegment, self.view.frame.size.width, heightSegment)];
    self.viewSegment.backgroundColor = [UIColor blueColor];
    [self.viewHeader addSubview:self.viewSegment];
    [self.view addSubview:self.viewHeader];
    
    self.tableviewList = [[UITableView alloc] initWithFrame:CGRectMake(0.f, heightHeader, self.view.bounds.size.width, self.view.bounds.size.height - 44.f)];
    self.tableviewList.dataSource = self;
    self.tableviewList.delegate = self;
    [self.view addSubview:self.tableviewList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark -
#pragma mark UIScorllView delegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIPanGestureRecognizer *panGesture = scrollView.panGestureRecognizer;
    CGPoint point = [panGesture translationInView:self.view];
}

@end
