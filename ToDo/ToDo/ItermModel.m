//
//  ItermModel.m
//  ToDo
//
//  Created by qingyun on 16/2/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ItermModel.h"
#import "Common.h"

@implementation ItermModel

- (instancetype)initItermModelWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.fenleiname = dict[kFenleiname];
        self.detailfenleiid = dict[kDetailfenleiid];
        self.detailfenleiname = dict[kDetailfenleiname];
        self.fenleiid = dict[kFenleiid];
        self.itermsort = dict[kItermsort];
        self.isuseradd = dict[kIsuseradd];
    }
    return self;
}
@end
