//
//  VDRefreshDemoViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 4/1/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDRefreshDemoViewController.h"
#import "VDRefreshTableView.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.refreshTableView = [[VDRefreshTableView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.refreshTableView.dataSource = self;
    self.refreshTableView.delegate = self;
    [self.view addSubview:self.refreshTableView];
    
    self.sourceArray = @[@"test",@"test",@"test",@"test",@"test",@"test",@"test",@"test",@"test",@"test"];
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




@end
