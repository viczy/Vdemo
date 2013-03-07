//
//  VDMediaControlView.m
//  Vdemo
//  
//  Created by Vic Zhou on 3/6/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDMediaControlView.h"

@implementation VDMediaControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self viewInit];
    }
    return self;
}

#pragma mark -
#pragma mark View Init
- (void)viewInit {
    
    self.imageviewBackground = [[UIImageView alloc] initWithFrame:self.frame];
    self.imageviewBackground.userInteractionEnabled = YES;
    [self addSubview:self.imageviewBackground];
    
    self.labelCurrent = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.labelCurrent];
    
    self.sliderProgress = [[UISlider alloc] initWithFrame:CGRectZero];
    [self.sliderProgress addTarget:self action:@selector(sliderProgressAction) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.sliderProgress];
    
    self.labelCount = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:self.labelCount];
    
    self.btnStop = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnStop addTarget:self action:@selector(btnStopAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnStop];
    
    self.btnPreMedia = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnPreMedia addTarget:self action:@selector(btnPreMediaAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnPreMedia];
    
    self.btnBackward = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnBackward addTarget:self action:@selector(btnBackwardAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnBackward];

    self.btnPlayAndPause = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnPlayAndPause addTarget:self action:@selector(btnPlayAndPauseAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnPlayAndPause];
    
    self.btnForward = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnForward addTarget:self action:@selector(btnForwardAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnForward];
    
    self.btnNextMedia = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnNextMedia addTarget:self action:@selector(btnNextMediaAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnNextMedia];
    
    //set all subview backgroundcolor clearcolor
    for (UIView *subview in self.subviews) {
        subview.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark -
#pragma mark Controllers Action

- (void)sliderProgressAction {
    [self.delegateMediaControl mediaProgressChanged:self.sliderProgress.value];
}

- (void)btnStopAction {
    [self.delegateMediaControl mediaStop];
}

- (void)btnPreMediaAction {
    [self.delegateMediaControl mediaPreSource];
}

- (void)btnBackwardAction {
    [self.delegateMediaControl mediaBackward];
}

- (void)btnPlayAndPauseAction:(id)sender {
    UIButton *buttonPlayAndPause = (UIButton*)sender;
    BOOL playing = buttonPlayAndPause.selected;
    if (playing) {
        [self.delegateMediaControl mediaPause];
    }
    else {
        [self.delegateMediaControl mediaPlay];
    }
}

- (void)btnForwardAction {
    [self.delegateMediaControl mediaForward];
}

- (void)btnNextMediaAction {
    [self.delegateMediaControl mediaNextSource];
}


@end
