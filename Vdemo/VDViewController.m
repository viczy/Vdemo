//
//  VDViewController.m
//  Vdemo
//
//  Created by Vic Zhou on 2/5/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDViewController.h"
#import "VDPageRefreshDemoViewController.h"
#import "VDPopImageDemoViewController.h"
#import "VDShareKitDemoViewController.h"
#import "VDScrollViewController.h"

@interface VDViewController ()

@property (nonatomic, strong) NSArray *source;

@end

@implementation VDViewController

- (void)dealloc
{
    //dealloc.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.navigationItem.title = @"VDemo";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *sourcePath = [VDCommon getBundlePathWithFileName:MenuName];
    self.source = [NSArray arrayWithContentsOfFile:sourcePath];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark tableview datasourse

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.source count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    static NSString *Indentifier = @"RootCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if ([self.source count] > row) {
        NSDictionary *sourceDic = [self.source objectAtIndex:row];
        cell.textLabel.text = [sourceDic objectForKey:@"name"];
    }
    
    return cell;
}

#pragma mark -
#pragma mark tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch ([indexPath row]) {
        case 0: {
            VDPageRefreshDemoViewController *vdPageRefreshDemoVC = [[VDPageRefreshDemoViewController alloc] init];
            [self.navigationController pushViewController:vdPageRefreshDemoVC animated:YES];
            break;
        }
            
        case 1: {
            VDPopImageDemoViewController *vdPopImageDemoVC = [[VDPopImageDemoViewController alloc] init];
            [self.navigationController pushViewController:vdPopImageDemoVC animated:YES];
            break;
        }
            
        case 2: {
            VDShareKitDemoViewController *vdShareDemoVC = [[VDShareKitDemoViewController alloc] init];
            [self.navigationController pushViewController:vdShareDemoVC animated:YES];
            break;
        }
            
        case 3: {
            VDShareKitDemoViewController *vdShareDemoVC = [[VDShareKitDemoViewController alloc] init];
            [self.navigationController pushViewController:vdShareDemoVC animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //do something for move
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //do something for delete
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

@end
