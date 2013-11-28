//
//  VDScrollViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 3/13/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDScrollDemoViewController.h"

@interface VDScrollDemoViewController ()

@property (nonatomic, strong) VDHeadTableView *headTableView;
@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation VDScrollDemoViewController

- (VDHeadTableView*)headTableView {
    if (!_headTableView) {
        _headTableView = [[VDHeadTableView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height)];
        _headTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _headTableView.dataSource = self;
        _headTableView.delegate = self;
        _headTableView.delegateHeader = self;
    }
    return _headTableView;
}


#pragma mark - NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        // Custom initialization
    }

    return self;
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.headTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.sourceArray = [[NSMutableArray alloc] initWithArray:@[@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic"]];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    [self.headTableView VDScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    [self.headTableView VDScrollViewDidEndDecelerating:scrollView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const TableViewCellIdentifier = @"TableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
    }
    cell.textLabel.text = self.sourceArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.f;
}

#pragma mark - VDHeadTableViewDelegate

- (UIView*)VDHeadTableViewHeaderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, 100.f)];
    view.backgroundColor = [UIColor blueColor];
    return view;
}

- (UIView*)VDHeadTableViewSectionView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, 30.f)];
    view.backgroundColor = [UIColor redColor];
    return view;
}



@end
