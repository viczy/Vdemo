//
//  VDRefreshDemoViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 4/1/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDRefreshDemoViewController.h"

@interface VDRefreshDemoViewController ()

@property (nonatomic, strong) VDRefreshTableView *refreshTableView;
@property (nonatomic, strong) NSArray *sourceArray;

@end

@implementation VDRefreshDemoViewController

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

-(void)loadView {
    [super loadView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refreshAction)];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.refreshTableView = [[VDRefreshTableView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.refreshTableView.delegateRefresh = self;
    self.refreshTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    self.refreshTableView.dataSource = self;
    self.refreshTableView.delegate = self;
    [self.view addSubview:self.refreshTableView];
    
    self.sourceArray = @[@"test",@"test",@"test",@"test",@"test",@"test",@"test",@"test",@"test",@"test"];
}

#pragma mark - Actions Private

- (void)refreshAction {
    [self.refreshTableView showLoadingLast];
//    [self.refreshTableView showLoadingLatest];
}

#pragma mark - UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const RefreshTableViewCellIdentifier = @"RefreshTableViewCell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:RefreshTableViewCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RefreshTableViewCellIdentifier];
    }
    cell.textLabel.text = [self.sourceArray objectAtIndex:[indexPath row]];
    return cell;
}

#pragma mark -
#pragma mark UITableViewDataSourceDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.sourceArray.count;
    }
    
    return 0;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.refreshTableView VDScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[self.refreshTableView VDScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

#pragma mark - VDRefreshTableViewDelegate

- (void)VDRefreshTableViewWillBeginLoadingLatest {
    //begin get latest data
    [self performSelector:@selector(loadLatestOver) withObject:nil afterDelay:3.0];
}

- (void)VDRefreshTableViewWillBeginLoadingLast {
    //begin get lates data
//    [self performSelector:@selector(loadLastEnable) withObject:nil afterDelay:3.0];
    self.refreshTableView.tableState = VDRefreshTableViewStateError;
    [self performSelector:@selector(loadLastDisable) withObject:nil afterDelay:3.0];
}

- (UIView*)VDRefreshTableViewErrorView {
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (void)loadLatestOver {
    [self.refreshTableView setLoadOverState:VDRefreshTableViewLoadedStateLatest];
}

- (void)loadLastEnable {
    [self.refreshTableView setLoadOverState:VDRefreshTableViewLoadedStateLastEnable];
}

- (void)loadLastDisable {
    [self.refreshTableView setLoadOverState:VDRefreshTableViewLoadedStateLastDisable];
}

@end
