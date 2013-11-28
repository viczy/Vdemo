//
//  VDPageRefreshView.m
//  Vdemo
//
//  Created by Vic Zhou on 2/5/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDPageRefreshView.h"

@interface VDPageRefreshView ()

@property (nonatomic, assign) NSUInteger pages;
@property (nonatomic, assign) NSInteger currentIndex;

@end


@implementation VDPageRefreshView

#pragma mark - NSObject

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        _currentIndex = 0;
    }

    return self;
}

#pragma mark - UIView Setter

- (void)setPages:(NSUInteger)pages {
    _pages = pages;
    self.contentSize = CGSizeMake(self.bounds.size.width * self.pages, self.bounds.size.height);
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    if (_currentIndex < currentIndex) { // 向后翻页的事件处理
        [self addSubviewAtIndex:currentIndex+1];
        [self removeSubviewAtIndex:currentIndex-2];
    }else if (_currentIndex > currentIndex) { // 向前翻页的事件处理
        [self addSubviewAtIndex:currentIndex-1];
        [self removeSubviewAtIndex:currentIndex+2];
    }
    _currentIndex = currentIndex;
    [self loadOverSubviewAtIndex:currentIndex];
}

#pragma mark - UIView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    self.delegate = self;
    self.pagingEnabled = YES;

    self.pages = [self.dataSource numberOfPages];
    [self addSubviewAtIndex:0];
    [self addSubviewAtIndex:1];
    [self loadOverSubviewAtIndex:0];
}

#pragma mark - Actions Public

- (void)reload {
    [self scrollToPageAtIndex:self.currentIndex];
}

- (void)scrollToPageAtIndex:(NSUInteger)index {
    _currentIndex = index;
    //clear all old view
    [self removeSubviewAtIndex:index-1];
    [self removeSubviewAtIndex:index];
    [self removeSubviewAtIndex:index+1];
    //add sub view
    [self addSubviewAtIndex:index-1];
    [self addSubviewAtIndex:index];
    [self addSubviewAtIndex:index+1];
    //scroll to page
    [self setContentOffset:CGPointMake(self.bounds.size.width*index, 0) animated:YES];
}

- (void)turnToPageAtIndex:(NSUInteger)index {
    //scroll to page
    [self setContentOffset:CGPointMake(self.bounds.size.width*index, 0) animated:YES];
}

#pragma mark - Actions Private

//add sub view
- (void)addSubviewAtIndex:(NSUInteger)index {
    if (index < self.pages ) {
        if ([self.dataSource respondsToSelector:@selector(pageView:viewForPageAtIndex:)]) {
            UIView *view = [self.dataSource pageView:self viewForPageAtIndex:index];
            view.tag = index+100;//tag+100
            view.frame = CGRectMake(self.bounds.size.width *index, 0.f, self.bounds.size.width, self.bounds.size.height);
            [self addSubview:view];}
    }
}

//remove sub view
- (void)removeSubviewAtIndex:(NSUInteger)index {
    UIView *view = [self viewWithTag:index+100];//tag+100
    if (view) {
        [view removeFromSuperview];
    }
}

//load over
- (void)loadOverSubviewAtIndex:(NSUInteger)index {
    if ([self.delegatePage respondsToSelector:@selector(pageView:viewLoadOverAtIndex:)]) {
        [self.delegatePage pageView:self viewLoadOverAtIndex:index];
    }
}

// scroll over
- (void)scrollingEnded
{
    NSInteger newIndex = floor(self.contentOffset.x / self.frame.size.width);

    newIndex = newIndex < 0 ? 0 : newIndex;

    if (newIndex != _currentIndex) {
         self.currentIndex = newIndex;
    }
}

#pragma mark -
#pragma mark scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self scrollingEnded];
}

@end
