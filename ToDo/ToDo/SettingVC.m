//
//  SettingVC.m
//  ToDo
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SettingVC.h"
#import "Common.h"

@interface SettingVC ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation SettingVC
static NSString *setCellID = @"SettingCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor blueColor];
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenW, kScreenH) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    UIView *view = [[UIView alloc]init];
    UIImageView *headerView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 70, 70)];
    UIImage *image = [UIImage imageNamed:@"icon"];
    headerView.image = [image imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    [view addSubview:headerView];
    table.tableHeaderView = view;
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setCellID];
    cell.imageView.image = [UIImage imageNamed:@"add"];
    cell.textLabel.text = @"设置";
    return cell;
}
@end
