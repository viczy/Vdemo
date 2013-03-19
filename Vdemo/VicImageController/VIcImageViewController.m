//
//  VIcImageViewController.m
//  VicImage
//
//  Created by Vic Zhou on 12-8-29.
//  Copyright (c) 2012年 Cdel. All rights reserved.
//

#import "VIcImageViewController.h"
#import "MCSegmentedControl.h"
#define NAVHEIGHT       44.0
#define CUSTOMNAVHEIGHT 0.0
#define TABHEIGHT       44.0
#define ORIENTATION     0
#define CROP            1
#define DRAW            2

@interface VIcImageViewController ()

@property (nonatomic, retain) UIView *currentVIew;
           
@end

@implementation VIcImageViewController

@synthesize delegate;
@synthesize orientationView = _orientationView;
//@synthesize cropView = _cropView;
@synthesize drawView = _drawView;
@synthesize drawChildView = _drawChildView;
@synthesize segmentImg = _segmentImg;
@synthesize editImage = _editImage;
@synthesize currentVIew = _currentVIew;
@synthesize cliper = _cliper;
@synthesize needSave = _needSave;
@synthesize originImage = _originImage;

- (void)dealloc {
    self.orientationView = nil;
//    self.cropView = nil;
    self.drawView = nil;
    self.drawChildView = nil;
    self.segmentImg = nil;
    self.editImage = nil;
    self.cliper = nil;
    self.originImage = nil;
    [super dealloc];
}

- (id)initWithSegmentImages:(NSArray *)imageArray {
    self = [super init];
    if (self) {
        self.segmentImg = imageArray;
        self.needSave = NO;
    }
    return self;
}

- (void)initNav {
    if (0 == CUSTOMNAVHEIGHT) {
        if (nil != self.navigationController) {
            self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
            UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBtnEvent)];
            self.navigationItem.leftBarButtonItem = leftBtnItem;
            UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithTitle:@"功能" style:UIBarButtonItemStylePlain target:self action:@selector(funBtnEvent)];
            self.navigationItem.rightBarButtonItem = rightBtnItem;
        }
    }
    else {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        backBtn.showsTouchWhenHighlighted = YES;
        backBtn.frame = CGRectMake(5.0, 0.0, 60.0, CUSTOMNAVHEIGHT);
        [backBtn addTarget:self action:@selector(backBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        UIButton *funBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [funBtn setTitle:@"功能" forState:UIControlStateNormal];
        funBtn.showsTouchWhenHighlighted = YES;
        funBtn.frame = CGRectMake(self.view.frame.size.width-65.0, 0.0, 60.0, CUSTOMNAVHEIGHT);
        [funBtn addTarget:self action:@selector(funBtnEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];
        [self.view addSubview:funBtn];
    }
}

- (void)backBtnEvent {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)funBtnEvent {
    UIActionSheet *funSheet = [[UIActionSheet alloc] initWithTitle:nil 
                                                          delegate:self 
                                                 cancelButtonTitle:@"取消"
                                            destructiveButtonTitle:nil 
                                                 otherButtonTitles:@"保存图片", @"使用图片", nil];
    [funSheet showInView:self.view];
    [funSheet release];
}

- (void)switchOrientationView {
    CGRect oldImgViewFrame = CGRectMake(0.0, CUSTOMNAVHEIGHT, self.view.frame.size.width, self.view.frame.size.height-CUSTOMNAVHEIGHT-TABHEIGHT-NAVHEIGHT);
    UIImage *bgImg = self.editImage;
    CGRect newImgViewFrame;
    if (bgImg.size.width > oldImgViewFrame.size.width) {
        CGFloat height = (bgImg.size.height/bgImg.size.width)*oldImgViewFrame.size.width;
        if (height > oldImgViewFrame.size.height) {
            CGFloat width = (bgImg.size.width/bgImg.size.height)*oldImgViewFrame.size.height;
            newImgViewFrame = CGRectMake((oldImgViewFrame.size.width-width)/2, 0.0, width, oldImgViewFrame.size.height);
        }
        else {
            newImgViewFrame = CGRectMake(0.0, (oldImgViewFrame.size.height-height)/2, oldImgViewFrame.size.width, height);
        }
    }
    else if (bgImg.size.height > oldImgViewFrame.size.height) {
        CGFloat width = (bgImg.size.width/bgImg.size.height)*oldImgViewFrame.size.height;
        newImgViewFrame = CGRectMake((oldImgViewFrame.size.width-width)/2, 0.0, width, oldImgViewFrame.size.height);
    }
    else {
        newImgViewFrame = CGRectMake((oldImgViewFrame.size.width-bgImg.size.width)/2, (oldImgViewFrame.size.height-bgImg.size.height)/2, bgImg.size.width, bgImg.size.height);
    }
    UIView *baseView = [[UIView alloc] initWithFrame:oldImgViewFrame];
    AGSimpleImageEditorView *myImgView = [[AGSimpleImageEditorView alloc] initWithFrame:newImgViewFrame];
    myImgView.image = self.editImage;
    [baseView addSubview:myImgView];
    self.orientationView = myImgView;
    [myImgView release];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.showsTouchWhenHighlighted = YES;
    rightBtn.showsTouchWhenHighlighted = YES;
    leftBtn.frame = CGRectMake(oldImgViewFrame.origin.x, 0.0, 60.0, 44.0);
    rightBtn.frame = CGRectMake(oldImgViewFrame.size.width - 60.0, 0.0, 60.0, 44.0);
    [leftBtn setImage:[UIImage imageNamed:@"rotate_left.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"rotate_right.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(rotateLeft) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(rotateRight) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:leftBtn];
    [baseView addSubview:rightBtn];
    [self.view addSubview:baseView];
    self.currentVIew = baseView;
    [baseView release];
}

- (void)rotateLeft {
    [self.orientationView rotateLeft];
}

- (void)rotateRight {
    [self.orientationView rotateRight];
}

- (void)saveOrientationImage
{
    self.orientationView.mode = AGModeOrientation;
    self.editImage = self.orientationView.output;
//    NSData *data = UIImageJPEGRepresentation(self.orientationView.output, 1);
//    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	NSString* documentsDirectory = [paths objectAtIndex:0];
//	NSString* imgPath = [documentsDirectory stringByAppendingPathComponent: @"/image.jpg"];
//    [data writeToFile:imgPath atomically:YES];
}

- (void)switchCropView {
    CGRect oldImgViewFrame = CGRectMake(0.0, CUSTOMNAVHEIGHT, self.view.frame.size.width, self.view.frame.size.height-NAVHEIGHT-TABHEIGHT-CUSTOMNAVHEIGHT);
    UIImage *bgImg = self.editImage;
    CGRect newImgViewFrame;
    if (bgImg.size.width > oldImgViewFrame.size.width) {
        CGFloat height = (bgImg.size.height/bgImg.size.width)*oldImgViewFrame.size.width;
        if (height > oldImgViewFrame.size.height) {
            CGFloat width = (bgImg.size.width/bgImg.size.height)*oldImgViewFrame.size.height;
            newImgViewFrame = CGRectMake((oldImgViewFrame.size.width-width)/2, 0.0, width, oldImgViewFrame.size.height);
        }
        else {
            newImgViewFrame = CGRectMake(0.0, (oldImgViewFrame.size.height-height)/2, oldImgViewFrame.size.width, height);
        }
    }
    else if (bgImg.size.height > oldImgViewFrame.size.height) {
        CGFloat width = (bgImg.size.width/bgImg.size.height)*oldImgViewFrame.size.height;
        newImgViewFrame = CGRectMake((oldImgViewFrame.size.width-width)/2, 0.0, width, oldImgViewFrame.size.height);
    }
    else {
        newImgViewFrame = CGRectMake((oldImgViewFrame.size.width-bgImg.size.width)/2, (oldImgViewFrame.size.height-bgImg.size.height)/2, bgImg.size.width, bgImg.size.height);
    }
    UIView *baseView = [[UIView alloc] initWithFrame:oldImgViewFrame];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:newImgViewFrame];
    bgImgView.image = bgImg;
    UICliper *myCliper = [[UICliper alloc]initWithImageView:bgImgView];
    self.cliper = myCliper;
    [myCliper release];
    [baseView addSubview:bgImgView];
    [bgImgView release];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(oldImgViewFrame.origin.x, 0.0, 60.0, 44.0);
    rightBtn.frame = CGRectMake(oldImgViewFrame.size.width - 60.0, 0.0, 60.0, 44.0);
    leftBtn.showsTouchWhenHighlighted = YES;
    rightBtn.showsTouchWhenHighlighted = YES;
    [leftBtn setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"edit_sure.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(cropCancel) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(cropSure) forControlEvents:UIControlEventTouchUpInside];
    if (_cancelEnabled) {
        leftBtn.enabled = YES;
    }
    else {
        leftBtn.enabled = NO;
    }
    [baseView addSubview:leftBtn];
    [baseView addSubview:rightBtn];
    [self.view addSubview:baseView];
    self.currentVIew = baseView;
    [baseView release];
}

- (void)cropCancel {
    if (_cancelEnabled) {
        _cancelEnabled = NO;
    }
    self.editImage = self.originImage;
    [self updateView];
}

- (void)cropSure {
    if (!_cancelEnabled) {
        _cancelEnabled = YES;
    }
    [self updateEditeImg];
    [self updateView];
}

- (void)saveCropImage {
//    self.editImage = [self.cropView getCroppedImage];
    CGRect cropRect = [self.cliper getclipRect];
    self.editImage = [self.cliper getClipImageRect:cropRect];
}

- (void)switchDrawView {
    CGRect oldImgViewFrame = CGRectMake(0.0, CUSTOMNAVHEIGHT, self.view.frame.size.width, self.view.frame.size.height-NAVHEIGHT-TABHEIGHT-CUSTOMNAVHEIGHT);
    UIImage *bgImg = self.editImage;
    CGRect newImgViewFrame;
    if (bgImg.size.width > oldImgViewFrame.size.width) {
        CGFloat height = (bgImg.size.height/bgImg.size.width)*oldImgViewFrame.size.width;
        if (height > oldImgViewFrame.size.height) {
            CGFloat width = (bgImg.size.width/bgImg.size.height)*oldImgViewFrame.size.height;
            newImgViewFrame = CGRectMake((oldImgViewFrame.size.width-width)/2, 0.0, width, oldImgViewFrame.size.height);
        }
        else {
            newImgViewFrame = CGRectMake(0.0, (oldImgViewFrame.size.height-height)/2, oldImgViewFrame.size.width, height);
        }
    }
    else if (bgImg.size.height > oldImgViewFrame.size.height) {
        CGFloat width = (bgImg.size.width/bgImg.size.height)*oldImgViewFrame.size.height;
        newImgViewFrame = CGRectMake((oldImgViewFrame.size.width-width)/2, 0.0, width, oldImgViewFrame.size.height);
    }
    else {
        newImgViewFrame = CGRectMake((oldImgViewFrame.size.width-bgImg.size.width)/2, (oldImgViewFrame.size.height-bgImg.size.height)/2, bgImg.size.width, bgImg.size.height);
    }
    UIView *baseView = [[UIView alloc] initWithFrame:oldImgViewFrame];
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:newImgViewFrame];
    bgImgView.image = bgImg; 
    JBSignatureView *myImgView = [[JBSignatureView alloc] initWithFrame:bgImgView.frame withImage:bgImg];
    myImgView.lineWidth = 1.0;
    myImgView.foreColor = [UIColor orangeColor];
    self.drawChildView = myImgView;
    [baseView addSubview:bgImgView];
    [bgImgView release];
    [baseView addSubview:myImgView];
    self.drawView = myImgView;
    [myImgView release];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.showsTouchWhenHighlighted = YES;
    rightBtn.showsTouchWhenHighlighted = YES;
    leftBtn.frame = CGRectMake(oldImgViewFrame.origin.x, 0.0, 60.0, 44.0);
    rightBtn.frame = CGRectMake(oldImgViewFrame.size.width - 60.0, 0.0, 60.0, 44.0);
    [leftBtn setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"edit_sure.png"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(drawCancel) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(drawSure) forControlEvents:UIControlEventTouchUpInside];
    if (_cancelEnabled) {
        leftBtn.enabled = YES;
    }
    else {
        leftBtn.enabled = NO;
    }
    [baseView addSubview:leftBtn];
    [baseView addSubview:rightBtn];
    [self.view addSubview:baseView];
    self.currentVIew = baseView;
    [baseView release];
}

- (void)drawCancel {
    if (_cancelEnabled) {
        _cancelEnabled = NO;
    }
    self.editImage = self.originImage;
    [self updateView];
}

- (void)drawSure {
    if (!_cancelEnabled) {
        _cancelEnabled = YES;
    }
    [self updateEditeImg];
    [self updateView];
}

- (void)saveDrawImage {
    self.editImage = [self.drawChildView getSignatureImage];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self initNav];
	NSArray *items = [NSArray arrayWithObjects:
					  [UIImage imageNamed:@"orientation.png"],
					  [UIImage imageNamed:@"crop.png"],
					  [UIImage imageNamed:@"draw.png"],
					  nil];
	MCSegmentedControl *segmentedControl = [[MCSegmentedControl alloc] initWithItems:items];
    segmentedControl.frame = CGRectMake((self.view.frame.size.width-300.0)/2, self.view.frame.size.height - TABHEIGHT -44.0, 300.0f, TABHEIGHT);
	[segmentedControl addTarget:self action:@selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.selectedSegmentIndex = 0;
    _currentIndex = 0;
	// Set a tint color
	segmentedControl.tintColor = [UIColor colorWithRed:.0 green:.6 blue:.0 alpha:1.0];
	// Customize font and items color
	segmentedControl.selectedItemColor   = [UIColor whiteColor];
	segmentedControl.unselectedItemColor = [UIColor darkGrayColor];
    
	[self.view addSubview:segmentedControl];
	[segmentedControl release];
    if (nil == self.editImage) {
        self.editImage = [UIImage imageNamed:@"Default.jpg"];
    }
    self.originImage = self.editImage;
    [self switchOrientationView];
}


- (void)segmentedControlDidChange:(MCSegmentedControl *)sender  {
    NSInteger selectedIndex = sender.selectedSegmentIndex;
    if (_currentIndex == selectedIndex) {
        return;
    }
    if (_currentIndex == ORIENTATION) {
        [self updateEditeImg];
    }
    switch (selectedIndex) {
        case ORIENTATION: {
            [self.currentVIew removeFromSuperview];
            _cancelEnabled = NO;
            [self switchOrientationView];
            _currentIndex = selectedIndex;
            self.originImage = self.editImage;
            break;
        }
        case CROP: {
            [self.currentVIew removeFromSuperview];
            _cancelEnabled = NO;
            [self switchCropView];
            _currentIndex = selectedIndex;
            self.originImage = self.editImage;
            break;
        }
            
        case DRAW: {
            [self.currentVIew removeFromSuperview];
            _cancelEnabled = NO;
            [self switchDrawView];
            _currentIndex = selectedIndex;
            self.originImage = self.editImage;
            break;
        }
            
        default:
            break;
    }
}

- (void) updateEditeImg {
    switch (_currentIndex) {
        case ORIENTATION: {
            [self saveOrientationImage];
            break;
        }
            
        case CROP: {
            [self saveCropImage];
            break;
        }
            
        case DRAW: {
            [self saveDrawImage];
            break;
        }
            
        default:
            break;
    }

}

- (void)updateView {
    switch (_currentIndex) {
        case ORIENTATION: {
            break;
        }
            
        case CROP: {
            [self.currentVIew removeFromSuperview];
            [self switchCropView];
            break;
        }
            
        case DRAW: {
            [self.currentVIew removeFromSuperview];
            [self switchDrawView];
            break;
        }
            
        default:
            break;
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

#pragma mark -
#pragma mark Actionsheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            self.needSave = YES;
            [delegate VIcImageViewControllerFinished:self];
            [self backBtnEvent];
            break;
        }
            
        case 1: {
            [self updateEditeImg];
            [delegate VIcImageViewControllerFinished:self];
            [self backBtnEvent];
            break;
        }
         
        case 2: {
            break;
        }
            
        default:
            break;
    }
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
