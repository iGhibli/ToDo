//
//  DetailCell.h
//  ToDo
//
//  Created by qingyun on 16/1/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailModel;
@interface DetailCell : UITableViewCell
@property (nonatomic, strong) DetailModel *model;

- (void)bandingDetailCellWithModel:(DetailModel *)model;

@end
