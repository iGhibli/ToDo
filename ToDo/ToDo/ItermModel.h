//
//  ItermModel.h
//  ToDo
//
//  Created by qingyun on 16/2/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItermModel : NSObject

@property (nonatomic, strong) NSString *fenleiname;
@property (nonatomic, strong) NSString *detailfenleiid;
@property (nonatomic, strong) NSString *detailfenleiname;
@property (nonatomic, strong) NSString *fenleiid;
@property (nonatomic, strong) NSString *itermsort;
@property (nonatomic, strong) NSString *isuseradd;

- (instancetype)initItermModelWithDict:(NSDictionary *)dict;

@end
