//
//  VDRefreshTableView.h
//  Vdemo
//
//  Created by Vic Zhou on 4/1/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface VDRefreshTableView : UITableView <EGORefreshTableHeaderDelegate, UIScrollViewDelegate>

@end
