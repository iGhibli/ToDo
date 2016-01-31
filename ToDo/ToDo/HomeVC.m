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
@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, strong) NSDictionary *addDict;
@end

@implementation HomeVC
static NSString *homeCellID = @"homeCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil] forCellReuseIdentifier:homeCellID];
}

- (NSArray *)sourceArray {
    if (_sourceArray == nil) {
        _sourceArray = [NSArray array];
        _sourceArray = [DataBaseEngine getListModelsFromDBTable];
    }
    return _sourceArray;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListModel *model = self.sourceArray[indexPath.row];
    DetailVC *VC = [[DetailVC alloc]init];
    [VC setValue:model.sort forKey:@"listID"];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)editListInfoWithInfoDict:(NSMutableDictionary *)dict
{
    AddVC *VC = [[AddVC alloc]init];
    VC.infoDict = dict;
    
    //对changeSignVC视图控制器的changeLabelValue属性进行赋值
    [VC getPassInfoDict:^(NSDictionary *infoDict) {
        self.addDict = infoDict;
    }];
        
    [self.navigationController pushViewController:VC animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
