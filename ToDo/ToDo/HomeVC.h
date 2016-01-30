//
//  HomeVC.h
//  ToDo
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChangeItem)(UIImage *);

@interface HomeVC : UITableViewController

@property (nonatomic, copy) ChangeItem changeItem;

- (void)changeItemImage;

@end
