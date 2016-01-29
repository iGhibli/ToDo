//
//  DetailModel.m
//  ToDo
//
//  Created by qingyun on 16/1/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DetailModel.h"
#import "Common.h"

@implementation DetailModel

- (instancetype)initDetailModelWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.listid = dict[kListid];
        self.fenleiname = dict[kFenleiname];
        self.detailfenleiid = dict[kDetailfenleiid];
        self.detailfenleiname = dict[kDetailfenleiname];
        self.ischeck = dict[kIscheck];
        self.itermsort = dict[kItermsort];
    }
    return self;
}

@end
