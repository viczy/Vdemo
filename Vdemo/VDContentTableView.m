//
//  VDContentTableView.m
//  Vdemo
//  
//  Created by Vic Zhou on 5/8/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDContentTableView.h"
#import "VDHeadTableView.h"

@interface VDContentTableView ()

@property (nonatomic, strong) VDHeadTableView *containerView;

@end

@implementation VDContentTableView

- (id)initWithFrame:(CGRect)frame withContainerView:(UIView*)containerView
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.containerView = (VDHeadTableView*)containerView;
    }
    return self;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    [self.containerView VDScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    [self.containerView VDScrollViewDidEndDecelerating:scrollView];
}

@end
