//
//  VDRefreshTableView.m
//  Vdemo
//
//  Created by Vic Zhou on 4/1/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDRefreshTableView.h"

@interface VDRefreshTableView ()

@property (nonatomic, strong) EGORefreshTableHeaderView *pullRefreshView;
@property (nonatomic, strong) VDRefreshTableFooterView *loadMoreView;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) UIView *viewError;

@end


@implementation VDRefreshTableView

- (EGORefreshTableHeaderView*)pullRefreshView {
    if (!_pullRefreshView) {
        _pullRefreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        _pullRefreshView.delegate = self;
    }
    return _pullRefreshView;
}

- (VDRefreshTableFooterView*)loadMoreView {
    if (!_loadMoreView) {
        _loadMoreView = [[VDRefreshTableFooterView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.bounds.size.width, 44.f)];
        _loadMoreView.delegate = self;
    }
    return _loadMoreView;
}

- (void)setTableMode:(VDRefreshTableViewMode)tableMode {
    switch (tableMode) {
        case VDRefreshTableViewModeNormal: {
            [self addSubview:self.pullRefreshView];
            [self.pullRefreshView refreshLastUpdatedDate];
            self.tableFooterView = self.loadMoreView;
        }
            break;
            
        case VDRefreshTableViewModeJustLatest: {
            [self addSubview:self.pullRefreshView];
            [self.pullRefreshView refreshLastUpdatedDate];
            self.tableFooterView = nil;
        }
            break;
            
        case VDRefreshTableViewModeJustLast: {
            [self.pullRefreshView removeFromSuperview];
            self.tableFooterView = self.loadMoreView;
        }
            break;
            
        default:
            break;
    }
}

- (void)setTableState:(VDRefreshTableViewState)tableState {
    switch (tableState) {
        case VDRefreshTableViewStateNormal: {
            [self.viewError removeFromSuperview];
            self.scrollEnabled = YES;
        }
            break;
            
        case VDRefreshTableViewStateError: {
            [self addSubview:self.viewError];
            self.scrollEnabled = NO;
        }
            break;
            
        default:
            break;
    }
}

- (void)setLoadOverState:(VDRefreshTableViewLoadedState)loadOverState {
    switch (loadOverState) {
        case VDRefreshTableViewLoadedStateLatest: {
            [self doneLoadingTableViewData];
        }
            break;
            
        case VDRefreshTableViewLoadedStateLastEnable: {
            [self loadMoreOver];
            self.loadMoreView.state = VDRefreshTableViewStateNormal;
        }
            break;
            
        case VDRefreshTableViewLoadedStateLastDisable: {
            [self loadMoreOver];
            self.loadMoreView.state = VDRefreshTableFooterViewStateEnd;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - NSObject

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableMode = VDRefreshTableViewModeNormal;
    }
    return self;
}

#pragma mark - UIView
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if ([self.delegateRefresh respondsToSelector:@selector(VDRefreshTableViewErrorView)]) {
        self.viewError = [self.delegateRefresh VDRefreshTableViewErrorView];
    }
}

#pragma mark - Actions Public

- (void)VDScrollViewDidScroll:(UIScrollView *)scrollView {
	[self.pullRefreshView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)VDScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	[self.pullRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
    if(scrollView.contentOffset.y-60.f > ((scrollView.contentSize.height - scrollView.frame.size.height)))
    {
        if (self.loadMoreView.state != VDRefreshTableFooterViewStateEnd) {
            [self loadMore];
        }
    }
}

- (void)showLoadingLatest {
    [self setContentOffset:CGPointMake(0.f, -65.f) animated:NO];
    [self.pullRefreshView egoRefreshScrollViewDidEndDragging:self];
}

- (void)showLoadingLast {
    [self loadMore];
}

- (void)showLoadingOrigin {
    if (!self.isLoading) {
        if ([self.delegateRefresh respondsToSelector:@selector(VDRefreshTableViewWillBeginLoadingOrigin)]) {
            [self.delegateRefresh VDRefreshTableViewWillBeginLoadingOrigin];
        }
        self.isLoading = YES;
        self.loadMoreView.state = VDRefreshTableFooterViewStateLoading;
    }
}

#pragma mark - Actions Private

- (void)loadMore {
    if (!self.isLoading) {
        if ([self.delegateRefresh respondsToSelector:@selector(VDRefreshTableViewWillBeginLoadingLast)]) {
            [self.delegateRefresh VDRefreshTableViewWillBeginLoadingLast];
        }
        self.isLoading = YES;
        self.loadMoreView.state = VDRefreshTableFooterViewStateLoading;
    }
}

- (void)loadMoreOver {
    self.isLoading = NO;
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	self.isLoading = YES;
    if ([self.delegateRefresh respondsToSelector:@selector(VDRefreshTableViewWillBeginLoadingLatest)]) {
        [self.delegateRefresh VDRefreshTableViewWillBeginLoadingLatest];
    }
}

- (void)doneLoadingTableViewData{
	self.isLoading = NO;
	[self.pullRefreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods

// 开始刷新时回调
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
}

// 下拉时回调
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return self.isLoading;
}

// 请求上次更新时间时调用
- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date]; 
}

#pragma mark - VDRefreshTableFooterViewDelegate

- (void)footerViewButtonAction {
    [self loadMore];
}

@end
