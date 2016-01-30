//
//  AdressVC.m
//  ToDo
//
//  Created by qingyun on 16/1/30.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "AdressVC.h"
#import "DataBaseEngine.h"

@interface AdressVC ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *sourceArray;

@end

@implementation AdressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sourceArray = [NSMutableArray array];
    self.sourceArray = [DataBaseEngine getCityAndCountryFromDBTableWithName:@"河"];
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
