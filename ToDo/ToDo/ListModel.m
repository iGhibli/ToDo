//
//  ListModel.m
//  ToDo
//
//  Created by qingyun on 16/1/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ListModel.h"
#import "Common.h"

@implementation ListModel

- (instancetype)initListModelWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.name = dict[kName];
        self.image = dict[kImage];
        self.sort = dict[kSort];
        self.relatedpoi = dict[kRelatedpoi];
    }
    return self;
}

@end
