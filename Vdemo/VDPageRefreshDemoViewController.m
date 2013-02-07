//
//  VDPageRefreshDemoViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 2/5/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDPageRefreshDemoViewController.h"

@interface VDPageRefreshDemoViewController ()

@property (nonatomic, strong) VDPageRefreshView *pageRefreshView;

@end

@implementation VDPageRefreshDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0.0, 0.0, 320.0, 480.0);
        self.pageRefreshView = [[VDPageRefreshView alloc] initWithFrame:rect];
        self.pageRefreshView.backgroundColor = [UIColor whiteColor];
        self.pageRefreshView.delegateVDPageRefresh = self;
        [self.view addSubview:self.pageRefreshView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark VDPageRefreshView delegate

//pages
- (NSUInteger)numberOfPages {
    return 6;
}

//开始的前两页，不足两页则仅画一页
- (UIView*)viewForOrigin:(NSInteger)index {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    switch (index) {
        case 0:
            view.backgroundColor = [UIColor redColor];
            break;
            
        case 1:
            view.backgroundColor = [UIColor yellowColor];
            break;
            
        default:
            break;
    }
    return view;
}

//翻页的更新页
- (UIView*)pageChanged:(NSInteger)index {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    switch (index) {
        case 0:
            view.backgroundColor = [UIColor redColor];
            break;
            
        case 1:
            view.backgroundColor = [UIColor yellowColor];
            break;
            
        case 2:
            view.backgroundColor = [UIColor blueColor];
            break;
            
        case 3:
            view.backgroundColor = [UIColor brownColor];
            break;
            
        case 4:
            view.backgroundColor = [UIColor magentaColor];
            break;
            
        case 5:
            view.backgroundColor = [UIColor grayColor];
            break;
            
        default:
            break;
    }
    return view;
}

@end
