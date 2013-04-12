//
//  VDVideoPlayerDemoViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 3/22/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDVideoPlayerDemoViewController.h"
#import "VDMediaControlView.h"
#import <MediaPlayer/MediaPlayer.h>

@interface VDVideoPlayerDemoViewController ()

@property (nonatomic, strong) UIView *videoView;
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;
@property (nonatomic, strong) VDMediaControlView *mediaControlView;

@end

@implementation VDVideoPlayerDemoViewController

- (UIView*)videoView {
    if (!_videoView) {
        MPMoviePlayerViewController *moviePlayerViewController = [[MPMoviePlayerViewController alloc] init];
        self.moviePlayer = moviePlayerViewController.moviePlayer;
        self.moviePlayer.controlStyle = MPMovieControlStyleNone;
        _videoView = moviePlayerViewController.view;
    }
    return _videoView;
}

- (VDMediaControlView*)mediaControlView {
    if (!_mediaControlView) {
        _mediaControlView = [[VDMediaControlView alloc] initWithFrame:CGRectMake(0.f, self.view.bounds.size.height-80.f, self.view.bounds.size.width, self.view.bounds.size.height)];
        
    }
    return _mediaControlView;
}

#pragma mark - NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.view addSubview:self.videoView];
	self.videoView.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+44.f, self.view.frame.size.width, self.view.frame.size.height-44.f);
//    [self.view addSubview:self.mediaControlView];
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"animal" ofType:@"mp4" inDirectory:@"PAV.bundle"];
    self.moviePlayer.contentURL = [NSURL fileURLWithPath:videoPath];
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
}

- (void)viewWillAppear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft animated:YES];
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:YES];
    [super viewDidDisappear:animated];
}


#pragma mark - Orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL autorotate = UIDeviceOrientationIsLandscape(interfaceOrientation);
    return autorotate;
}

@end
