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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, kScreenW, kScreenH) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCellID" forIndexPath:indexPath];
//    if (cell == nil) {
//        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingCellID"];
//    }
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingCellID"];
    cell.imageView.image = [UIImage imageNamed:@"add"];
    cell.textLabel.text = @"设置";
    return cell;
}

@end
