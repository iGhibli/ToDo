//
//  DetailModel.h
//  ToDo
//
//  Created by qingyun on 16/1/29.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject
@property (nonatomic, strong) NSString *listid;
@property (nonatomic, strong) NSString *fenleiname;
@property (nonatomic, strong) NSString *detailfenleiid;
@property (nonatomic, strong) NSString *detailfenleiname;
@property (nonatomic, strong) NSString *ischeck;
@property (nonatomic, strong) NSString *itermsort;

- (instancetype)initDetailModelWithDict:(NSDictionary *)dict;

@end
