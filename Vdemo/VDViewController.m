//
//  VDViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 2/5/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDViewController.h"
#import "VDPageRefreshDemoViewController.h"

@interface VDViewController ()

@property (nonatomic, strong) UITableView *rootTableView;
@property (nonatomic, strong) NSArray *source;

@end

@implementation VDViewController

- (void)dealloc
{
    //dealloc.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"VDemo";
    
    NSString *sourcePath = [VDCommon getBundlePathWithFileName:MenuName];
    self.source = [NSArray arrayWithContentsOfFile:sourcePath];
    
	self.rootTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.rootTableView.dataSource = self;
    self.rootTableView.delegate = self;
    [self.view addSubview:self.rootTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark tableview datasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.source count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    static NSString *Indentifier = @"RootCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
    }
    if ([self.source count] > row) {
        NSDictionary *sourceDic = [self.source objectAtIndex:row];
        cell.textLabel.text = [sourceDic objectForKey:@"name"];
    }
    
    return cell;
}

#pragma mark -
#pragma mark tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch ([indexPath row]) {
        case 0: {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            VDPageRefreshDemoViewController *vdPageRefreshDemoViewController = [[VDPageRefreshDemoViewController alloc] init];
            [self.navigationController pushViewController:vdPageRefreshDemoViewController animated:YES];
            break;
        }
            
        default:
            break;
    }
}

@end
