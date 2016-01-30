//
//  AddVC.h
//  ToDo
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^passInfoDict)(NSDictionary *infoDict);

@interface AddVC : UIViewController

@property (nonatomic, strong) NSMutableDictionary *infoDict;
@property (nonatomic, copy) passInfoDict pass;

@end


