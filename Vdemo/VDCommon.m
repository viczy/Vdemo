//
//  VDCommon.m
//  Vdemo
//
//  Created by Vic Zhou on 2/5/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDCommon.h"

@implementation VDCommon

#pragma mark -
#pragma mark file path
//bundle's file
+ (NSString*)getBundlePathWithFileName:(NSString*)filename {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
    return filePath;
}

//documents's file
+ (NSString*)getDocumentsPathWithFileName:(NSString*)filename {
    NSArray *filePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsPath = [filePaths objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingString:filename];
    return filePath;
}


#pragma mark -
#pragma mark date string
//date str with format
+ (NSString*)getDateStringByFormat:(NSString*)format withDate:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *returnStr = [formatter stringFromDate:date];
    return returnStr;
}

@end
