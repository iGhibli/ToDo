//
//  DetailVC.m
//  ToDo
//
//  Created by qingyun on 16/1/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DetailVC.h"
#import "DataBaseEngine.h"
#import "DetailModel.h"
#import "DetailCell.h"
#import "Common.h"
#import "AddVC.h"
#import "ChangeListInfoVC.h"

@interface DetailVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, strong) NSMutableArray *twoDimensionArray;
@end

@implementation DetailVC
static NSString *DetailCellID = @"detailCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)changeShowAction:(UIButton *)sender
{
    sender.selected = sender.selected ? NO : YES;
}

- (NSArray *)sourceArray {
    if (_sourceArray == nil) {
        _sourceArray = [NSArray array];
        _sourceArray = [DataBaseEngine getDetailModelsFromDBTableWithListID:self.sort];
    }
    return _sourceArray;
}

- (NSArray *)twoDimensionArray {
    if (_twoDimensionArray == nil) {
        _twoDimensionArray = [NSMutableArray array];
        //
        NSMutableArray *xingQianShiXiang = [NSMutableArray array];
        //
//        NSMutableArray *gouWuQingDan = [NSMutableArray array];
        //
        NSMutableArray *wenJian = [NSMutableArray array];
        //
        NSMutableArray *ziJin = [NSMutableArray array];
        //
        NSMutableArray *fuZhuang = [NSMutableArray array];
        //
        NSMutableArray *geHu = [NSMutableArray array];
        //
        NSMutableArray *yiLiao = [NSMutableArray array];
        //
        NSMutableArray *dianZi = [NSMutableArray array];
        //
        NSMutableArray *qianShuiSheBei = [NSMutableArray array];
        //
        NSMutableArray *zaXiang = [NSMutableArray array];
        //
        NSMutableArray *lvTuBeiWang = [NSMutableArray array];
        //
        NSMutableArray *ziDingYi = [NSMutableArray array];
        //便利数组分类存放
        [self.sourceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DetailModel *model = obj;
            if ([model.detailfenleiid intValue] <= 21) {
                [xingQianShiXiang addObject:model];
            }else if ([model.detailfenleiid intValue] <= 33) {
                [wenJian addObject:model];
            }else if ([model.detailfenleiid intValue] <= 36) {
                [ziJin addObject:model];
            }else if ([model.detailfenleiid intValue] <= 54) {
                [fuZhuang addObject:model];
            }else if ([model.detailfenleiid intValue] <= 72) {
                [geHu addObject:model];
            }else if ([model.detailfenleiid intValue] <= 83) {
                [yiLiao addObject:model];
            }else if ([model.detailfenleiid intValue] <= 101) {
                [dianZi addObject:model];
            }else if ([model.detailfenleiid intValue] <= 106) {
                [qianShuiSheBei addObject:model];
            }else if ([model.detailfenleiid intValue] <= 123) {
                [zaXiang addObject:model];
            }else if ([model.detailfenleiid intValue] <= 132) {
                [lvTuBeiWang addObject:model];
            }else {
                [ziDingYi addObject:model];
            }
        }];
        //将分类后的数组存入二维数组
        NSArray *tempArray = [[NSArray alloc]initWithObjects:xingQianShiXiang, wenJian, ziJin, fuZhuang, geHu, yiLiao, dianZi, qianShuiSheBei, zaXiang, lvTuBeiWang, ziDingYi, nil];
        [tempArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *array = obj;
            if (array.count != 0) {
                [_twoDimensionArray addObject:array];
            }
        }];
    }
    return _twoDimensionArray;
}

#pragma mark - ButtonAction
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sortShowAction:(UIButton *)sender {
    sender.selected = sender.selected ? NO:YES;
}

- (IBAction)addCustomAction:(UIButton *)sender {
    
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.twoDimensionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.twoDimensionArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailCellID forIndexPath:indexPath];
    DetailModel *model = self.twoDimensionArray[indexPath.section][indexPath.row];
    [cell bandingDetailCellWithModel:model];    
    return cell;
}

#pragma mark - SectionHeader
//section头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    DetailModel *model = self.twoDimensionArray[section][0];
    return model.fenleiname;
}

//section头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
//section头视图
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    //创建自定义的section的头视图
//    QYSectionHeaderView *headerView = [QYSectionHeaderView sectionHeaderViewForTableView:tableView];
//    QYFriendGroup *friendGroup = self.heros[section];
//    headerView.friendGroup = friendGroup;
//    
//    headerView.headerViewClick = ^{
//        
//        [tableView reloadData];
//    };
//    
//    return headerView;
//}


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



#pragma mark - PushSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"changeListInfoSegue"]) {
        [segue.destinationViewController setValue:@(self.sort) forKey:@"sort"];
    }else if ([segue.identifier isEqualToString:@"librarySegue"]) {
        [segue.destinationViewController setValue:@(self.sort) forKey:@"sort"];
    }
    
}

@end
