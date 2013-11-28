//
//  VDPageRefreshView.h
//  Vdemo
//  这是一个翻页阅读的翻页view，从开始的两页开始后保持存在的界面页数为3页，
//  当翻页结束的时候会根据需要，加载新的一页，同时移走旧的一页
//
//  Created by Vic Zhou on 2/5/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

@class VDPageRefreshView;

@protocol VDPageRefreshViewDataSource <NSObject>

- (NSUInteger)numberOfPages;

- (UIView*)pageView:(VDPageRefreshView*)pageView viewForPageAtIndex:(NSUInteger)index;

@end

@protocol VDPageRefreshViewDelegate <NSObject>

- (void)pageView:(VDPageRefreshView*)pageView viewLoadOverAtIndex:(NSUInteger)index;

@end

@interface VDPageRefreshView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, assign) id <VDPageRefreshViewDataSource> dataSource;
@property (nonatomic, assign) id <VDPageRefreshViewDelegate> delegatePage;

- (void)reload;

- (void)scrollToPageAtIndex:(NSUInteger)index;

- (void)turnToPageAtIndex:(NSUInteger)index;

@end
