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
@property (nonatomic, strong) UIView *viewTableHeader;
@property (nonatomic, strong) UIView *viewTableFooter;
@property (nonatomic, strong) UIView *viewSectionHeader;

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

    self.tableviewList = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height - 44.f)];
    self.tableviewList.dataSource = self;
    self.tableviewList.delegate = self;
    self.tableviewList.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableviewList];
    [self tableviewRefresh];
}

- (void)tableviewRefresh {
    [self tableviewHeader];
    [self tableviewFooter];
}


- (void)tableviewHeader {
    if (!self.viewTableHeader) {
        self.viewTableHeader = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.tableviewList.frame.size.width, 60.f)];
        self.viewTableHeader.backgroundColor = [UIColor blueColor];
    }
    self.tableviewList.tableHeaderView = self.viewTableHeader;
}

- (void)tableviewFooter {
    if (!self.viewTableFooter) {
        self.viewTableFooter = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.tableviewList.frame.size.width, self.view.frame.size.height-44.f-20.f)];
        self.viewTableFooter.backgroundColor = [UIColor redColor];
    }
    self.tableviewList.tableFooterView = self.viewTableFooter;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!self.viewSectionHeader) {
        self.viewSectionHeader = [[UIView alloc] initWithFrame:CGRectMake (0.f, 0.f, tableView.frame.size.width, 40.f)];
        self.viewSectionHeader.backgroundColor = [UIColor purpleColor];
    }
    return self.viewSectionHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

//just test


@end
