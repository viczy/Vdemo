//
//  VDMediaControlView.h
//  Vdemo
//  Media playControl View (need custom sub controlview:rect,image,text,textfont,textcolor,sliderimage,sliderball,...)
//  Created by Vic Zhou on 3/6/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VDMediaControlViewDelegate <NSObject>

@optional

- (void)mediaProgressChanged:(CGFloat)progress;

- (void)mediaStop;

- (void)mediaPreSource;

- (void)mediaBackward;

- (void)mediaPlay;

- (void)mediaPause;

- (void)mediaForward;

- (void)mediaNextSource;

@end


@interface VDMediaControlView : UIView
//ui
@property (nonatomic, strong) UIImageView *imageviewBackground;
@property (nonatomic, strong) UILabel *labelCurrent;
@property (nonatomic, strong) UISlider *sliderProgress;
@property (nonatomic, strong) UILabel *labelCount;
@property (nonatomic, strong) UIButton *btnStop;
@property (nonatomic, strong) UIButton *btnPreMedia;
@property (nonatomic, strong) UIButton *btnBackward;
@property (nonatomic, strong) UIButton *btnPlayAndPause;//need set normal and selected
@property (nonatomic, strong) UIButton *btnForward;
@property (nonatomic, strong) UIButton *btnNextMedia;

//foundation
@property (nonatomic, weak) id <VDMediaControlViewDelegate> delegateMediaControl;


@end
