//
//  ListCell.m
//  ToDo
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ListCell.h"
#import "ListModel.h"

@interface ListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end

@implementation ListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)bandingListCellWithListModel:(ListModel *)model
{
    self.model = model;
    self.icon.layer.cornerRadius = 25;
    self.icon.clipsToBounds = YES;
    self.icon.image = [UIImage imageWithData:(NSData *)model.image];
    self.mainTitle.text = model.name;
    self.progressLabel.text = @"100%";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
