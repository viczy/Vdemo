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
        // Custom initialization
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.videoView];
	
    [self.view addSubview:self.mediaControlView];
    
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"400_3815_12_1358485896006" ofType:@"mp4" inDirectory:@"PAV.bundle"];
    self.moviePlayer.contentURL = [NSURL URLWithString:videoPath];
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer play];
    
    MPMoviePlayerViewController *moviePlayerViewController = [[MPMoviePlayerViewController alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"400_3815_12_1358485896006.mp4" ofType:nil];
    moviePlayerViewController.moviePlayer.contentURL = [NSURL URLWithString:path];
    [moviePlayerViewController.moviePlayer play];
    [self.view addSubview:moviePlayerViewController.view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
