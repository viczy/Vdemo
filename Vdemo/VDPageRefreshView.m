//
//  VDPageRefreshView.m
//  Vdemo
//
//  Created by Vic Zhou on 2/5/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDPageRefreshView.h"

#define TAGADD      10  //tag基数

@interface VDPageRefreshView ()

@property (nonatomic, assign) BOOL isScrolling;
@property (nonatomic, assign) NSUInteger pages;

@end


@implementation VDPageRefreshView

- (void)setCurrentIndex:(NSInteger)currentIndex {
    //向后翻页的事件处理
    if (_currentIndex < currentIndex) {
        if (currentIndex == self.pages-1) {
            _currentIndex = currentIndex;
            UIView *viewOld = [self viewWithTag:currentIndex-2+TAGADD];
            if (viewOld) {
                [viewOld removeFromSuperview];
            }
            return;
        }
        else {
            if ([self.delegateVDPageRefresh respondsToSelector:@selector(pageViewWithIndex:)]) {
                UIView *viewNew = [self.delegateVDPageRefresh pageViewWithIndex:currentIndex+1];
                viewNew.tag = currentIndex+1+TAGADD;
                viewNew.frame = CGRectMake(self.frame.size.width*(currentIndex+1), 0.0, self.frame.size.width, self.frame.size.height);
                [self addSubview:viewNew];
            }
            
            UIView *viewOld = [self viewWithTag:currentIndex-2+TAGADD];
            if (viewOld) {
                [viewOld removeFromSuperview];
            }
        }
        
    }
    //向前翻页的事件处理
    else if (_currentIndex > currentIndex) {
        if (currentIndex == 0) {
            _currentIndex = currentIndex;
            UIView *viewOld = [self viewWithTag:currentIndex+2+TAGADD];
            if (viewOld) {
                [viewOld removeFromSuperview];
            }
            return;
        }
        else {
            if ([self.delegateVDPageRefresh respondsToSelector:@selector(pageViewWithIndex:)]) {
                UIView *viewNew = [self.delegateVDPageRefresh pageViewWithIndex:currentIndex-1];
                viewNew.tag = currentIndex-1+TAGADD;
                viewNew.frame = CGRectMake(self.frame.size.width*(currentIndex-1), 0.0, self.frame.size.width, self.frame.size.height);
                [self addSubview:viewNew];
            }
            
            UIView *viewOld = [self viewWithTag:currentIndex+2+TAGADD];
            if (viewOld) {
                [viewOld removeFromSuperview];
            }
        }
    }
    _currentIndex = currentIndex;
}


#pragma mark - NSObject

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

#pragma mark - UIView

- (void)drawRect:(CGRect)rect {
    _currentIndex = 0;
    self.pagingEnabled = YES;
    self.pages = [self.delegateVDPageRefresh numberOfPages];
    self.contentSize = CGSizeMake(self.frame.size.width*self.pages, self.frame.size.height);
    //初始化一页或者两页
    if (self.pages >= 2) {
        if ([self.delegateVDPageRefresh respondsToSelector:@selector(pageViewWithIndex:)]) {
            UIView *view0 = [self.delegateVDPageRefresh pageViewWithIndex:0];
            view0.tag = 0+TAGADD;
            view0.frame = CGRectMake(self.frame.size.width*0, 0.0, self.frame.size.width, self.frame.size.height);
            [self addSubview:view0];
            
            UIView *view1 = [self.delegateVDPageRefresh pageViewWithIndex:1];
            view1.tag = 1+TAGADD;
            view1.frame = CGRectMake(self.frame.size.width*1, 0.0, self.frame.size.width, self.frame.size.height);
            [self addSubview:view1];
        }
    }
    else {
        if (self.pages > 0) {
            if ([self.delegateVDPageRefresh respondsToSelector:@selector(pageViewWithIndex:)]) {
                UIView *view0 = [self.delegateVDPageRefresh pageViewWithIndex:0];
                view0.tag = 0+TAGADD;
                view0.frame = CGRectMake(self.frame.size.width*0, 0.0, self.frame.size.width, self.frame.size.height);
                [self addSubview:view0];
            }
        }
    }
}

#pragma mark - Actions Private

- (void)removeOldViews {
    if (self.currentIndex == 0) {//remove 0 and 1
        UIView *view0Old = [self viewWithTag:self.currentIndex+TAGADD];
        if (view0Old) {
            [view0Old removeFromSuperview];
        }
        UIView *view1Old = [self viewWithTag:self.currentIndex+1+TAGADD];
        if (view1Old) {
            [view1Old removeFromSuperview];
        }
    }else if (self.currentIndex == self.pages-1) {//remove pages-1 and pages-2
        UIView *viewNOld = [self viewWithTag:self.currentIndex+TAGADD];
        if (viewNOld) {
            [viewNOld removeFromSuperview];
        }
        UIView *viewNPreOld = [self viewWithTag:self.currentIndex-1+TAGADD];
        if (viewNPreOld) {
            [viewNPreOld removeFromSuperview];
        }
    }else {//remove middle-1, middle, middle+1
        UIView *viewMOld = [self viewWithTag:self.currentIndex+TAGADD];
        if (viewMOld) {
            [viewMOld removeFromSuperview];
        }
        UIView *viewMPreOld = [self viewWithTag:self.currentIndex-1+TAGADD];
        if (viewMPreOld) {
            [viewMPreOld removeFromSuperview];
        }
        UIView *viewMNexOld = [self viewWithTag:self.currentIndex+1+TAGADD];
        if (viewMNexOld) {
            [viewMNexOld removeFromSuperview];
        }
    }
}

- (void)refreshPageViewWithIndex:(NSInteger)index {
    if(index == 0){
        //current
        UIView *viewM = [self.delegateVDPageRefresh pageViewWithIndex:index];
        viewM.tag = index+TAGADD;
        viewM.frame = CGRectMake(self.frame.size.width*index, 0.0, self.frame.size.width, self.frame.size.height);
        [self addSubview:viewM];
        //next
        UIView *viewNex = [self.delegateVDPageRefresh pageViewWithIndex:index+1];
        viewNex.tag = index+1+TAGADD;
        viewNex.frame = CGRectMake(self.frame.size.width*(index+1), 0.0, self.frame.size.width, self.frame.size.height);
        [self addSubview:viewNex];
        
    }else if (index == self.pages-1) {
        //current
        UIView *viewM = [self.delegateVDPageRefresh pageViewWithIndex:index];
        viewM.tag = index+TAGADD;
        viewM.frame = CGRectMake(self.frame.size.width*index, 0.0, self.frame.size.width, self.frame.size.height);
        [self addSubview:viewM];
        //pre
        UIView *viewPre = [self.delegateVDPageRefresh pageViewWithIndex:index-1];
        viewPre.tag = index-1+TAGADD;
        viewPre.frame = CGRectMake(self.frame.size.width*(index-1), 0.0, self.frame.size.width, self.frame.size.height);
        [self addSubview:viewPre];
    }else {
        //current
        UIView *viewM = [self.delegateVDPageRefresh pageViewWithIndex:index];
        viewM.tag = index+TAGADD;
        viewM.frame = CGRectMake(self.frame.size.width*index, 0.0, self.frame.size.width, self.frame.size.height);
        [self addSubview:viewM];
        //pre
        UIView *viewPre = [self.delegateVDPageRefresh pageViewWithIndex:index-1];
        viewPre.tag = index-1+TAGADD;
        viewPre.frame = CGRectMake(self.frame.size.width*(index-1), 0.0, self.frame.size.width, self.frame.size.height);
        [self addSubview:viewPre];
        //next
        UIView *viewNex = [self.delegateVDPageRefresh pageViewWithIndex:index+1];
        viewNex.tag = index+1+TAGADD;
        viewNex.frame = CGRectMake(self.frame.size.width*(index+1), 0.0, self.frame.size.width, self.frame.size.height);
        [self addSubview:viewNex];
    }
}

#pragma mark - Actions Public

- (void)resetCurrentIndex:(NSInteger)index {
    if (self.currentIndex == index || index >= self.pages) {//page out
        return;
    }else {
        if (self.pages > 2) {// >2 pages
            [self removeOldViews];
            [self refreshPageViewWithIndex:index];
            [self setContentOffset:CGPointMake(self.frame.size.width*index, 0) animated:YES];
        }else if (self.pages > 1) {//only two pages
            self.currentIndex = index;
            [self setContentOffset:CGPointMake(self.frame.size.width*index, 0) animated:YES];
        }else{//only one page
            return;
        }
    }
}

#pragma mark -
#pragma mark scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.isScrolling = YES;
    [self scrollingEnded];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [self scrollingEnded];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)theScrollView {
//    [self scrollingEnded];
}

#pragma mark scrollview delegate action

//翻页结束的事件处理
- (void)scrollingEnded
{
//    self.isScrolling = NO;
    NSUInteger newIndex = floor(self.contentOffset.x / self.frame.size.width);
    
    if (newIndex == self.currentIndex) {
        return;
    }
    else {
        self.currentIndex = newIndex;
    }
}


@end
