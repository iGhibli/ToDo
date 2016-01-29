//
//  ListCell.h
//  ToDo
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListModel;
@interface ListCell : UITableViewCell
@property (nonatomic, strong) ListModel *model;

- (void)bandingListCellWithListModel:(ListModel *)model;

@end
