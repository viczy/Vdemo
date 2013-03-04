//
//  VDLoadImageViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 3/1/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDLoadImageViewController.h"
#import "UIImageView+AFNetworking.h"

@interface VDLoadImageViewController ()

@property (nonatomic, strong) UIScrollView *scrollViewScale;
@property (nonatomic, strong) UIImageView *imageViewOrigin;
@property (nonatomic, strong) UIImage *imageOrigin;

@end

@implementation VDLoadImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set leftbuttonitem and rightbuttonitem
    self.view.backgroundColor = [UIColor blackColor];
    UIBarButtonItem *btnItemBack = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(btnItemBackEvent)];
    self.navigationItem.leftBarButtonItem = btnItemBack;
    
    if (self.imagetype == VDPopImageTypeNet) {
        UIBarButtonItem *btnItemSave = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(btnItemSaveEvent)];
        btnItemSave.enabled = NO;
        self.navigationItem.rightBarButtonItem = btnItemSave;
    }
    
    //add scale background view
    self.scrollViewScale = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height-44.f)];
    self.scrollViewScale.delegate = self;
    self.scrollViewScale.backgroundColor = [UIColor blackColor];
    self.scrollViewScale.maximumZoomScale = 3.0;
    [self.view addSubview:self.scrollViewScale];
    
    //add imageview or waiting view
    if (self.imagetype == VDPopImageTypeNet) {
        [self imageViewOriginInit];
        UIActivityIndicatorView *waitView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [waitView setCenter:CGPointMake(self.scrollViewScale.frame.size.width/2, self.scrollViewScale.frame.size.height/2)];
        waitView.color = [UIColor lightGrayColor];
        [self.view addSubview:waitView];
        [waitView startAnimating];
        [self.imageViewOrigin requestImageWithURL:[NSURL URLWithString:self.sourcepath] withDoneBlock:^(UIImage *img) {
            [waitView stopAnimating];
            if (img) {
                self.imageOrigin = img;
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
            else {
                self.imageOrigin = [UIImage imageNamed:@"net_image_default.png"];
            }
        }];
    }
    else if (self.imagetype == VDPopImageTypeLocal) {
        self.imageOrigin = [UIImage imageWithContentsOfFile:self.sourcepath];
    }
}

- (void)setImageOrigin:(UIImage *)imageOrigin {
    [self imageViewOriginInit];
    
    CGSize backgroundSize = self.scrollViewScale.frame.size;
    CGSize imageSize = imageOrigin.size;
    CGRect imageViewRect;
    if (imageSize.height/imageSize.width > backgroundSize.height/backgroundSize.width) {
        if (imageSize.height > backgroundSize.height) {
            CGFloat widthFit = imageSize.width*backgroundSize.height/imageSize.height;
            imageViewRect = CGRectMake((backgroundSize.width-widthFit)/2, 0.f, widthFit, backgroundSize.height);
        }
        else {
            imageViewRect = CGRectMake((backgroundSize.width-imageSize.width)/2, (backgroundSize.height-imageSize.height)/2, imageSize.width, imageSize.height);
        }
    }
    else {
        if (imageSize.width > backgroundSize.width) {
            CGFloat heightFit = imageSize.height*backgroundSize.width/imageSize.width;
            imageViewRect = CGRectMake(0.f, (backgroundSize.height-heightFit)/2, backgroundSize.width, heightFit);
        }
        else {
            imageViewRect = CGRectMake((backgroundSize.width-imageSize.width)/2, (backgroundSize.height-imageSize.height)/2, imageSize.width, imageSize.height);
        }
    }
    self.imageViewOrigin.frame = imageViewRect;
    
    self.imageViewOrigin.image = imageOrigin;
    _imageOrigin = imageOrigin;
}

- (void)imageViewOriginInit {
    if (!self.imageViewOrigin) {
        self.imageViewOrigin = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.scrollViewScale addSubview:self.imageViewOrigin];
    }
}

- (void)btnItemBackEvent {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnItemSaveEvent {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Zoom event stuff

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    self.imageViewOrigin.frame = CGRectMake(0.f, 0.f, self.imageViewOrigin.frame.size.width, self.imageViewOrigin.frame.size.height);
    return self.imageViewOrigin;
}


@end
