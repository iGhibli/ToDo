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

+ (void)saveTravelListToTravelListTable:(NSDictionary *)dict;

+ (NSMutableArray *)getListModelsFromDBTable;

+ (NSMutableArray *)getDetailModelsFromDBTableWithListID:(int)listID;

+ (NSMutableArray *)getCityAndCountryFromDBTableWithName:(NSString *)name;

+ (void)deleteTravelListFromTravelListTableWithSort:(NSInteger)sort;

@end
