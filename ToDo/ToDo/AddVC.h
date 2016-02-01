//
//  AddVC.h
//  ToDo
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassInfoDictDelegate.h"

@interface AddVC : UIViewController

@property (nonatomic, assign) int sort;
@property (nonatomic, assign) id<PassInfoDictDelegate> delegate;


@end


