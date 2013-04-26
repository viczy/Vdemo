//
//  VDScrollViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 3/13/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDScrollDemoViewController.h"

enum {
    tableContainer = 10,
    tableList,
};

static CGFloat const sectionHeight = 40.f;
static CGFloat const headerHeight = 80.f;
static CGFloat const threshold = 20.f;

static NSString *const keyPath = @"contentOffset";

@interface VDScrollDemoViewController ()

@property (nonatomic, strong) UITableView *tableviewContainer;
@property (nonatomic, strong) UITableView *tableviewList;
@property (nonatomic, strong) UIView *tableHeader;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, assign) BOOL direction;

@end

@implementation VDScrollDemoViewController

- (UIView*)tableHeader {
    if (!_tableHeader) {
        _tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frame.size.width, headerHeight)];
        _tableHeader.backgroundColor = [UIColor purpleColor];
    }
    return _tableHeader;
}

- (UITableView*)tableviewList {
    if (!_tableviewList) {
        _tableviewList = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, self.view.bounds.size.height-sectionHeight) style:UITableViewStylePlain];
        _tableviewList.tag = tableList;
        _tableviewList.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableviewList.dataSource = self;
        _tableviewList.delegate = self;
        [_tableviewList addObserver:self forKeyPath:keyPath
                             options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                             context:NULL];
    }
    return _tableviewList;
}

- (UIView *)sectionView {
    if (!_sectionView) {
        _sectionView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, sectionHeight)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, sectionHeight)];
        label.backgroundColor = [UIColor lightGrayColor];
        label.textAlignment = UITextAlignmentCenter;
        label.text = @"section";
        [_sectionView addSubview:label];
    }
    return _sectionView;
}

- (UITableView*)tableviewContainer {
    if (!_tableviewContainer) {
        _tableviewContainer = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableviewContainer.tag = tableContainer;
        _tableviewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableviewContainer.dataSource = self;
        _tableviewContainer.delegate = self;
        _tableviewContainer.scrollEnabled = NO;
    }
    return _tableviewContainer;
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

- (void)dealloc {
    [self.tableviewList removeObserver:self forKeyPath:keyPath];
}

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    [self.view addSubview:self.tableviewContainer];
    self.tableviewContainer.tableHeaderView = self.tableHeader;
    self.tableviewContainer.tableFooterView = self.tableviewList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.sourceArray = [[NSMutableArray alloc] initWithArray:@[@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic",@"vic", @"vic"]];
}


#pragma mark - Actions Private

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    CGPoint newPoint = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
    CGPoint oldPoint = [[change valueForKey:NSKeyValueChangeOldKey] CGPointValue];
    
    if(oldPoint.y > newPoint.y)
        self.direction = YES;
    else
        self.direction = NO;
    
    if(self.tableviewContainer.contentOffset.y < headerHeight)
    {
        if(newPoint.y > 0)
        {
            if(self.tableviewList.contentOffset.y != 0)
                [self.tableviewList setContentOffset:CGPointMake(0, 0)];
            
            if(self.tableviewContainer.contentOffset.y+newPoint.y < headerHeight)
                [self.tableviewContainer setContentOffset:CGPointMake(0, self.tableviewContainer.contentOffset.y+newPoint.y)];
            else
                [self.tableviewContainer setContentOffset:CGPointMake(0, headerHeight)];
        }
    }
    
    if(self.tableviewContainer.contentOffset.y <= headerHeight && self.tableviewList.contentOffset.y < 0)
    {
        if(self.tableviewContainer.contentOffset.y > 0)
        {
            if(self.tableviewList.contentOffset.y != 0)
                [self.tableviewList setContentOffset:CGPointMake(0, 0)];
            
            if(self.tableviewContainer.contentOffset.y+newPoint.y > 0)
                [self.tableviewContainer setContentOffset:CGPointMake(0, self.tableviewContainer.contentOffset.y+newPoint.y)];
            else
                [self.tableviewContainer setContentOffset:CGPointMake(0, 0)];
        }
    }
}



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sectionNum = 0;
    if (tableView.tag == tableContainer) {
        sectionNum = 1;
    }else if (tableView.tag == tableList) {
        sectionNum = 1;
    }
    return sectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowNum = 0;
    if (tableView.tag == tableList) {
        rowNum = self.sourceArray.count;
    }else if (tableView.tag == tableContainer) {
        //
    }
    return rowNum;
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
    if (tableView.tag == tableContainer) {
        return self.sectionView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == tableContainer) {
        return sectionHeight;
    }
    return 0.f;
}

#pragma mark -
#pragma mark UIScorllView delegate

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate)
    {
        if(self.tableviewContainer.contentOffset.y < threshold)
            [self.tableviewContainer setContentOffset:CGPointMake(0, 0) animated:YES];
        else if(self.tableviewContainer.contentOffset.y > headerHeight-threshold)
            [self.tableviewContainer setContentOffset:CGPointMake(0, headerHeight) animated:YES];
        else if(self.direction)
            [self.tableviewContainer setContentOffset:CGPointMake(0, headerHeight) animated:YES];
        else
            [self.tableviewContainer setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    if(self.direction || self.tableviewContainer.contentOffset.y == headerHeight)
        [self.tableviewContainer setContentOffset:CGPointMake(0, headerHeight) animated:YES];
    else
        [self.tableviewContainer setContentOffset:CGPointMake(0, 0) animated:YES];
}

@end
