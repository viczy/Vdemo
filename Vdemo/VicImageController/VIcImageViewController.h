//
//  VIcImageViewController.h
//  VicImage
//
//  Created by Vic Zhou on 12-8-29.
//  Copyright (c) 2012年 Cdel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGSimpleImageEditorView.h"
#import "BJImageCropper.h"
#import "JBSignatureView.h"
#import "UICliper.h"

@class VIcImageViewController;

@protocol VIcImageViewControllerDelegate <NSObject>

- (void)VIcImageViewControllerFinished:(VIcImageViewController *)vicImageViewController;

@end

@interface VIcImageViewController : UIViewController <UIActionSheetDelegate> {
    IBOutlet id<VIcImageViewControllerDelegate> delegate;
    AGSimpleImageEditorView *_orientationView;
//    BJImageCropper *_cropView;
    UIView *_drawView;
    JBSignatureView *_drawChildView;
    NSArray *_segmentImg;
    UIImage *_editImage;
    UIImage *_originImage;
    NSInteger _currentIndex;
    UIView *_currentVIew;
    UICliper *_cliper;
    BOOL _needSave;
    BOOL _cancelEnabled;
}

@property (nonatomic, assign) IBOutlet id<VIcImageViewControllerDelegate> delegate;
@property (nonatomic, retain) AGSimpleImageEditorView *orientationView;
//@property (nonatomic, retain) BJImageCropper *cropView;
@property (nonatomic, retain) UIView *drawView;
@property (nonatomic, retain) JBSignatureView *drawChildView;
@property (nonatomic, retain) NSArray *segmentImg;
@property (nonatomic, retain) UIImage *editImage;
@property (nonatomic, retain) UIImage *originImage;
@property (nonatomic, retain) UICliper *cliper;
@property (nonatomic, assign) BOOL needSave;

- (id)initWithSegmentImages:(NSArray *)imageArray; 


@end
