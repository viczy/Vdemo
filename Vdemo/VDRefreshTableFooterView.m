//
//  VDRefreshTableFooterView.m
//  Vdemo
//
//  Created by Vic Zhou on 5/2/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDRefreshTableFooterView.h"

@interface VDRefreshTableFooterView ()

@property (nonatomic, strong) UIButton *buttonLoadMore;
@property (nonatomic, strong) UIView *viewLoading;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@property (nonatomic, strong) UILabel *labelLoadEnd;

@end

@implementation VDRefreshTableFooterView

- (UIButton*)buttonLoadMore {
    if (!_buttonLoadMore) {
        _buttonLoadMore = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _buttonLoadMore.frame = CGRectMake((self.frame.size.width-240.f)/2, (self.frame.size.height-30.f)/2, 240.f, 30.f);
        [_buttonLoadMore setTitle:@"获取更多" forState:UIControlStateNormal];
        [_buttonLoadMore setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_buttonLoadMore addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonLoadMore;
}

- (UIView*)viewLoading {
    if (!_viewLoading) {
        _viewLoading = [[UIView alloc] initWithFrame:self.frame];
        _viewLoading = [[UIView alloc] init];
        _viewLoading.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self.activityView startAnimating];
        [_viewLoading addSubview:self.activityView];
        
        UILabel *labelLoading = [[UILabel alloc] init];
        labelLoading.font = [UIFont systemFontOfSize:17.0f];
        labelLoading.backgroundColor = [UIColor clearColor];
        labelLoading.textColor = [UIColor grayColor];
        labelLoading.text = @"获取中....";
        [_viewLoading addSubview:labelLoading];
        
        CGSize viewSize = self.frame.size;
        CGSize activitySize = [self.activityView bounds].size;
        CGSize textSize = [labelLoading.text sizeWithFont:labelLoading.font];
        float bothWidth = activitySize.width + textSize.width + 5.0f;
        
        CGRect viewRect = {CGPointMake(floorf((viewSize.width / 2) - (bothWidth / 2)), floorf((viewSize.height / 2) - (activitySize.height / 2))),
            CGSizeMake(bothWidth, activitySize.height)};
        CGRect textRect = {CGPointMake(activitySize.width + 5.0f, floorf((activitySize.height / 2) - (textSize.height / 2))),
            textSize};
        CGRect activityRect = {CGPointZero, activitySize};
        
        _viewLoading.frame = viewRect;
        self.activityView.frame = activityRect;
        labelLoading.frame = textRect;
    }
    return _viewLoading;
}

- (UILabel*)labelLoadEnd {
    if (!_labelLoadEnd) {
        _labelLoadEnd = [[UILabel alloc] initWithFrame:self.frame];
        _labelLoadEnd.textAlignment = UITextAlignmentCenter;
        _labelLoadEnd.font = [UIFont systemFontOfSize:17.0f];
        _labelLoadEnd.backgroundColor = [UIColor clearColor];
        _labelLoadEnd.textColor = [UIColor grayColor];
        _labelLoadEnd.text = @"没有更多数据";
    }
    return _labelLoadEnd;
}

-(void)setState:(VDRefreshTableFooterViewState)state {
    _state = state;
    switch (state) {
        case VDRefreshTableFooterViewStateNormal: {
            self.buttonLoadMore.hidden = NO;
            self.viewLoading.hidden = YES;
            [self.activityView stopAnimating];
            self.labelLoadEnd.hidden = YES;
        }
            break;
            
        case VDRefreshTableFooterViewStateLoading: {
            self.buttonLoadMore.hidden = YES;
            self.viewLoading.hidden = NO;
            [self.activityView startAnimating];
            self.labelLoadEnd.hidden = YES;
        }
            break;
            
        case VDRefreshTableFooterViewStateEnd: {
            self.buttonLoadMore.hidden = YES;
            self.viewLoading.hidden = YES;
            [self.activityView stopAnimating];
            self.labelLoadEnd.hidden = NO;
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
        [self addSubview:self.labelLoadEnd];
        [self addSubview:self.viewLoading];
        [self addSubview:self.buttonLoadMore];
        self.state = VDRefreshTableFooterViewStateNormal;
    }
    return self;
}

#pragma mark - Actions Private

- (void)buttonAction {
    [self.delegate footerViewButtonAction];
}

@end
