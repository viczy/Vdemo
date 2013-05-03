//
//  VDRefreshTableView.h
//  Vdemo
//
//  Created by Vic Zhou on 4/1/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "VDRefreshTableFooterView.h"
@class VDRefreshTableView;

//tableview Mode
typedef enum {
    VDRefreshTableViewModeNormal = 0,//load latest, load last
    VDRefreshTableViewModeJustLatest,//just load latest
    VDRefreshTableViewModeJustLast,//just load last
}VDRefreshTableViewMode;

//table State
typedef enum {
    VDRefreshTableViewStateNormal = 0,//get origin data success
    VDRefreshTableViewStateError,//get origin data fail
}VDRefreshTableViewState;

//load state
typedef enum {
    VDRefreshTableViewLoadedStateLatest = 0,
    VDRefreshTableViewLoadedStateLastEnable,
    VDRefreshTableViewLoadedStateLastDisable,
}VDRefreshTableViewLoadedState;

@protocol VDRefreshTableViewDelegate <NSObject>

@required
- (void)VDRefreshTableViewWillBeginLoadingLatest;

@required
- (void)VDRefreshTableViewWillBeginLoadingLast;

@optional
- (UIView*)VDRefreshTableViewErrorView;

@end

@interface VDRefreshTableView : UITableView <EGORefreshTableHeaderDelegate,
    VDRefreshTableFooterViewDelegate, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <VDRefreshTableViewDelegate> delegateRefresh;
@property (nonatomic, assign) VDRefreshTableViewState tableState;
@property (nonatomic, assign) VDRefreshTableViewMode tableMode;
@property (nonatomic, assign) VDRefreshTableViewLoadedState loadOverState;

- (void)VDScrollViewDidScroll:(UIScrollView *)scrollView;

- (void)VDScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end
