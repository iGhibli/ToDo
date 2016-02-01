//
//  LibraryVC.m
//  ToDo
//
//  Created by qingyun on 16/2/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LibraryVC.h"
#import "DataBaseEngine.h"
#import "LibraryCell.h"

@interface LibraryVC ()<UITableViewDataSource ,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *sortTableView;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (nonatomic, strong) NSArray *sortSource;
@property (nonatomic, strong) NSArray *detailSource;
@end

@implementation LibraryVC
static NSString *oneCellID = @"OneCellID";
static NSString *twoCellID = @"TwoCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.sortTableView.delegate = self;
    self.sortTableView.dataSource = self;
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    self.sortSource = @[@"行前事项" ,@"文件/备份" ,@"资金" ,@"服装", @"个护/化妆" ,@"医疗/健康" ,@"电子/数码" ,@"潜水装备" ,@"杂项" ,@"旅途备忘" ,@"自定义"];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.sortTableView) {
        return self.sortSource.count;
    }else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.sortTableView) {
        return 40;
    }else {
        return 40;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.sortTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oneCellID];
        }
        cell.contentView.backgroundColor = [UIColor grayColor];
        cell.textLabel.text = self.sortSource[indexPath.row];
        return cell;
    }else {
        LibraryCell *cell = [tableView dequeueReusableCellWithIdentifier:twoCellID];
        return cell;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
