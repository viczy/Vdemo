//
//  VDHeadTableView.m
//  Vdemo
//
//  Created by Vic Zhou on 5/6/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDHeadTableView.h"

static NSString *const keyPath = @"contentOffset";

@interface VDHeadTableView ()

@property (nonatomic, strong) tableHeaderView *tableHeader;
@property (nonatomic, strong) UIView *tableSection;
@property (nonatomic, strong) UITableView *tableviewContent;
@property (nonatomic, assign) CGFloat headerHeight;

@end

@implementation VDHeadTableView

#pragma mark Value

- (tableHeaderView*)tableHeader {
    if (!_tableHeader) {
        _tableHeader = [[tableHeaderView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.headerHeight)];
        _tableHeader.contentTableView = self.tableviewContent;
    }
    return _tableHeader;
}

- (UITableView*)tableviewContent {
    if (!_tableviewContent) {
        _tableviewContent = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableviewContent.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_tableviewContent addObserver:self forKeyPath:keyPath
                            options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                            context:NULL];
    }
    return _tableviewContent;
}

#pragma mark - Set Value

- (void)setDelegateHeader:(id<VDHeadTableViewDelegate>)delegateHeader {
    self.tableviewContent.dataSource = (id<UITableViewDataSource>)delegateHeader;
    self.tableviewContent.delegate = (id<UITableViewDelegate>)delegateHeader;
    _delegateHeader = delegateHeader;
}

#pragma mark - NSObject

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.headerHeight = 80.f;
    }
    return self;
}

- (void)dealloc {
    [self.tableviewContent removeObserver:self forKeyPath:keyPath];
}

#pragma mark - UIView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //set the header view 
    if ([self.delegateHeader respondsToSelector:@selector(VDHeadTableViewHeaderView)]) {
        UIView *view = [self.delegateHeader VDHeadTableViewHeaderView];
        self.headerHeight = view.frame.size.height;
        [self.tableHeader addSubview:view];
    }
    self.tableHeaderView = self.tableHeader;
    self.tableFooterView = self.tableviewContent;
    self.dataSource = self;
    self.delegate = self;
    self.scrollEnabled = NO;
}

#pragma mark - Actions Private

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context
{
    CGPoint newPoint = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
    
    if(self.contentOffset.y < self.headerHeight)
    {
        if(newPoint.y > 0)
        {
            if(self.tableviewContent.contentOffset.y != 0)
                [self.tableviewContent setContentOffset:CGPointMake(0, 0)];
            
            if(self.contentOffset.y+newPoint.y < self.headerHeight)
                [self setContentOffset:CGPointMake(0, self.contentOffset.y+newPoint.y)];
            else
                [self setContentOffset:CGPointMake(0, self.headerHeight)];
        }
    }
    
    if(self.contentOffset.y <= self.headerHeight && self.tableviewContent.contentOffset.y < 0)
    {
        if(self.contentOffset.y > 0)
        {
            if(self.tableviewContent.contentOffset.y != 0)
                [self.tableviewContent setContentOffset:CGPointMake(0, 0)];
            
            if(self.contentOffset.y+newPoint.y > 0)
                [self setContentOffset:CGPointMake(0, self.contentOffset.y+newPoint.y)];
            else
                [self setContentOffset:CGPointMake(0, 0)];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.tableSection;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat sectionHeight = 40.f;
    if ([self.delegateHeader respondsToSelector:@selector(VDHeadTableViewSectionView)]) {
        self.tableSection = [self.delegateHeader VDHeadTableViewSectionView];
        sectionHeight = self.tableSection.frame.size.height;
        self.tableviewContent.frame = CGRectMake(0.f, 0.f, self.bounds.size.width, self.bounds.size.height-sectionHeight);
    }
    return sectionHeight;
}

@end

/*
 table header view
 */

@implementation tableHeaderView

- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    return [self.contentTableView hitTest:point withEvent:event];
}

@end
