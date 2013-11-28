//
//  VDRefreshTableFooterView.h
//  Vdemo
//
//  Created by Vic Zhou on 5/2/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VDRefreshTableFooterView;

//load more view State
typedef enum {
    VDRefreshTableFooterViewStateNormal = 0,//load more normal
    VDRefreshTableFooterViewStateLoading,//loading
    VDRefreshTableFooterViewStateEnd,//load more all
}VDRefreshTableFooterViewState;

@protocol VDRefreshTableFooterViewDelegate <NSObject>

- (void)footerViewButtonAction;

@end


@interface VDRefreshTableFooterView : UIView

@property (nonatomic, weak) id <VDRefreshTableFooterViewDelegate> delegate;
@property (nonatomic, assign) VDRefreshTableFooterViewState state;

@end
