//
//  VDCommon.m
//  Vdemo
//
//  Created by Vic Zhou on 2/5/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDCommon.h"

@implementation VDCommon

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

@end
