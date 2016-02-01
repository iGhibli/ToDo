//
//  LibraryCell.m
//  ToDo
//
//  Created by qingyun on 16/2/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "LibraryCell.h"

@interface LibraryCell ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
@implementation LibraryCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)addBtnAction:(UIButton *)sender {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
