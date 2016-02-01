//
//  HomeVC.m
//  ToDo
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HomeVC.h"
#import "YRSideViewController.h"
#import "AppDelegate.h"
#import "DetailVC.h"
#import "DataBaseEngine.h"
#import "ListModel.h"
#import "ListCell.h"
#import "AddVC.h"

@interface HomeVC ()
@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, strong) NSDictionary *addDict;
@property (nonatomic, strong) ListModel *currentModel;
@end

@implementation HomeVC
static NSString *homeCellID = @"homeCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    _sourceArray = [NSMutableArray array];
    _sourceArray = [DataBaseEngine getListModelsFromDBTable];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellID forIndexPath:indexPath];
    [cell bandingListCellWithListModel:self.sourceArray[indexPath.row]];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ListModel *model = self.sourceArray[indexPath.row];
    self.currentModel = model;
    return indexPath;
}

#pragma mark - 编辑tableView
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        ListModel *model = self.sourceArray[indexPath.row];
        [self.sourceArray removeObjectAtIndex:indexPath.row];
        [DataBaseEngine deleteTravelListFromTravelListTableWithSort:[model.sort integerValue]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual: @"detailSegue"]) {
        [segue.destinationViewController setValue:self.currentModel.sort forKey:@"sort"];
    }else if ([segue.identifier isEqual: @"addSegue"]) {
        ListModel *model = self.sourceArray.lastObject;
        [segue.destinationViewController setValue:model.sort forKey:@"sort"];
    }
}

@end
