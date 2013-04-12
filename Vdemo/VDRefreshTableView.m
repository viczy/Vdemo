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
@property (nonatomic, assign) BOOL isLoading;

@end


@implementation VDRefreshTableView

- (EGORefreshTableHeaderView*)pullRefreshView {
    if (!_pullRefreshView) {
        _pullRefreshView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
        _pullRefreshView.delegate = self;
    }
    return _pullRefreshView;
}

#pragma mark - NSObject

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.pullRefreshView];
        [self.pullRefreshView refreshLastUpdatedDate];
    }
    return self;
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[self.pullRefreshView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[self.pullRefreshView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark - EGORefreshTableHeaderDelegate Methods

// 开始刷新时回调
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    self.isLoading = YES;
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
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

@end
