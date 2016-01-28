//
//  SettingVC.m
//  ToDo
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SettingVC.h"
#import "Common.h"

@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    UIImageView *bgImage = [[UIImageView alloc]initWithFrame:kScreenB];
    bgImage.image = [UIImage imageNamed:@"6"];
    [self.view addSubview:bgImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
