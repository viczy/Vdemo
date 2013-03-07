//
//  VDCommon.h
//  Vdemo
//
//  Created by Vic Zhou on 2/5/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VDCommon : NSObject

////path

//bundle's file
+ (NSString*)getBundlePathWithFileName:(NSString*)filename;
//documents's file
+ (NSString*)getDocumentsPathWithFileName:(NSString*)filename;


////date string

//date with format
+ (NSString*)getDateStringByFormat:(NSString*)format withDate:(NSDate*)date;


//

@end
