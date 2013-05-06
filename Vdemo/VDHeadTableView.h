//
//  VDHeadTableView.h
//  Vdemo
//
//  Created by Vic Zhou on 5/6/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VDHeadTableView;

@protocol VDHeadTableViewDelegate <NSObject>

- (UIView*)VDHeadTableViewHeaderView;

- (UIView*)VDHeadTableViewSectionView;

@end

@interface VDHeadTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <VDHeadTableViewDelegate> delegateHeader;

@end

/*
 table header view
 */

@interface tableHeaderView : UIView

@property (nonatomic, strong) UITableView *contentTableView;

@end