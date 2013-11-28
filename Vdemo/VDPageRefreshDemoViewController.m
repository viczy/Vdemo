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

#pragma mark - NSObject

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        CGRect rect = CGRectMake(0.0, 0.0, 320.0, 480.0);
        self.pageRefreshView = [[VDPageRefreshView alloc] initWithFrame:rect];
        self.pageRefreshView.backgroundColor = [UIColor whiteColor];
        self.pageRefreshView.dataSource = self;
        self.pageRefreshView.delegatePage = self;
        [self.view addSubview:self.pageRefreshView];
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(jumpAction)];
    [super viewDidLoad];
}


#pragma mark - Actions Private

- (void)jumpAction {
    NSInteger index = (NSUInteger)arc4random()%6;
    [self.pageRefreshView scrollToPageAtIndex:index];
}

#pragma mark - VDPageRefreshView delegate

//pages
- (NSUInteger)numberOfPages {
    return 6;
}

//翻页的更新页
- (UIView*)pageView:(VDPageRefreshView *)pageView viewForPageAtIndex:(NSUInteger)index {
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
