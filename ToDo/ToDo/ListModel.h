//
//  ListModel.h
//  ToDo
//
//  Created by qingyun on 16/1/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ListModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *relatedpoi;

- (instancetype)initListModelWithDict:(NSDictionary *)dict;

@end
