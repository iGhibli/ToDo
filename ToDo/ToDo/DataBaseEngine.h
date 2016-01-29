//
//  DataBaseEngine.h
//  SJMicroBlog
//
//  Created by qingyun on 15/12/28.
//  Copyright © 2015年 iGhibli. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ListModel;
@interface DataBaseEngine : NSObject

+ (void)saveTravelListToTraveListTable:(ListModel *)model;

+ (NSMutableArray *)getListModelsFromDBTable;

+ (NSMutableArray *)getDetailModelsFromDBTableWithListID:(int)listID;

@end
