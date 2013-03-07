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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    _currentIndex = 0;
    self.pagingEnabled = YES;
    self.pages = [self.delegateVDPageRefresh numberOfPages];
    self.contentSize = CGSizeMake(self.frame.size.width*self.pages, self.frame.size.height);
    //初始化一页或者两页
    if (self.pages >= 2) {
        UIView *view0 = [self.delegateVDPageRefresh viewForOrigin:0];
        view0.tag = 0+TAGADD;
        view0.frame = CGRectMake(self.frame.size.width*0, 0.0, self.frame.size.width, self.frame.size.height);
        [self addSubview:view0];
        
        UIView *view1 = [self.delegateVDPageRefresh viewForOrigin:1];
        view1.tag = 1+TAGADD;
        view1.frame = CGRectMake(self.frame.size.width*1, 0.0, self.frame.size.width, self.frame.size.height);
        [self addSubview:view1];
    }
    else {
        if (self.pages > 0) {
            UIView *view0 = [self.delegateVDPageRefresh viewForOrigin:0];
            view0.tag = 0+TAGADD;
            view0.frame = CGRectMake(self.frame.size.width*0, 0.0, self.frame.size.width, self.frame.size.height);
            [self addSubview:view0];
        }
    }
}

#pragma mark -
#pragma mark self set

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (_currentIndex == self.pages -1) {
        _currentIndex = currentIndex;
        return;
    }
    //向后翻页的事件处理
    if (_currentIndex < currentIndex) {
        if (currentIndex == self.pages-1) {
            _currentIndex = currentIndex;
            return;
        }
        else {
            UIView *viewNew = [self.delegateVDPageRefresh pageChanged:currentIndex+1];
            viewNew.tag = currentIndex+1+TAGADD;
            viewNew.frame = CGRectMake(self.frame.size.width*(currentIndex+1), 0.0, self.frame.size.width, self.frame.size.height);
            [self addSubview:viewNew];
            
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
            return;
        }
        else {
            UIView *viewNew = [self.delegateVDPageRefresh pageChanged:currentIndex-1];
            viewNew.tag = currentIndex-1+TAGADD;
            viewNew.frame = CGRectMake(self.frame.size.width*(currentIndex-1), 0.0, self.frame.size.width, self.frame.size.height);
            [self addSubview:viewNew];
            
            UIView *viewOld = [self viewWithTag:currentIndex+2+TAGADD];
            [viewOld removeFromSuperview];
        }
    }
    _currentIndex = currentIndex;
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
