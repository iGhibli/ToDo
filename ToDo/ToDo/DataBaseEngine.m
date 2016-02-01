//
//  DataBaseEngine.m
//  SJMicroBlog
//
//  Created by qingyun on 15/12/28.
//  Copyright © 2015年 iGhibli. All rights reserved.
//

#import "DataBaseEngine.h"
#import "FMDB.h"
#import "NSString+FilePath.h"
#import "ListModel.h"
#import "DetailModel.h"
#import "Common.h"

static NSArray *statusTableColumn;     //保存status表中的所有字段
@implementation DataBaseEngine

//类的初始化方法、第一次调用这个类的时候，使用之前就会被调用（只调用一次，不能调用super）
+ (void)initialize{
    if (self == [DataBaseEngine self]) {
        //将数据库拷贝到documents下
        [DataBaseEngine copyDatabaseFileToDocuments:kDBFileName];
//        //初始化表的存放所含字段的数据
//        statusTableColumn = [DataBaseEngine tableColumn:kTravelListTable];
    }
}
//拷贝数据库文件到Documents下
+ (void)copyDatabaseFileToDocuments:(NSString *)dbName{
    NSString *source = [[NSBundle mainBundle] pathForResource:dbName ofType:nil];
    NSString *toPath = [NSString filePathInDocumentsWithFileName:dbName];
    NSError *error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:toPath]) {
        //没有数据库文件才copy
        return;
    }
    [[NSFileManager defaultManager] copyItemAtPath:source toPath:toPath error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
}
//查询数组的所有字段
+ (NSArray *)tableColumn:(NSString *)tableName{
    //创建DB
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
    [db open];
    //执行查询表的结构的命令，返回查询结果
    FMResultSet *result = [db getTableSchema:tableName];
    NSMutableArray *columns = [NSMutableArray array];
    while ([result next]) {
        //name字段对应的表的column的名字
        NSString *column = [result objectForColumnName:@"name"];
        [columns addObject:column];
    }
    [db close];
    return columns;
}

+ (void)updataTraveListWithInfoDict:(NSDictionary *)dict
{
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
//    NSString *SQLStr = [NSString stringWithFormat:@"update travellist SET name=%@ ,image=%@ ,sort=%d ,relatedpoi=%@ where sort=%d;",dict[@"name"] ,dict[@"image"] ,[dict[@"sort"] intValue] ,dict[@"relatedpoi"] ,[dict[@"sort"] intValue]];
    //使用queue提供一个DB
    [queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"update travellist SET name=:name ,image=:image ,sort=:sort ,relatedpoi=:relatedpoi where sort=:sort;" withParameterDictionary:dict];
        NSLog(@"%d",result);
    }];
}

+ (void)saveTravelListToTravelListTable:(NSDictionary *)dict {
    //插入操作，首先创建db对象，写sql语句，执行操作
    //使用队列queue，创建DB
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
    //使用queue提供一个DB
    [queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"insert into travellist(name ,image ,sort ,relatedpoi) values(:name ,:image ,:sort ,:relatedpoi) " withParameterDictionary:dict];
        NSLog(@"%d",result);
    }];
}

//查询出两个数组中共有的方法（处理表的所有字段与有效字段的交集）
+(NSArray *)contenKeyWith:(NSArray *)key1 key2:(NSArray *)key2{
    NSMutableArray *result = [NSMutableArray array];
    
    [key1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *key = obj;
        //比较一个对象是否包含在另外的一个数组中
        if ([key2 containsObject:key]) {
            [result addObject:key];
        }
    }];
    return result;
}

//根据table和字典共有的key，拼接出sql语句
+(NSString *)sqlStringWithKeys:(NSArray *)keys{
    //创建字段的sql语句部分
    NSString *colume = [keys componentsJoinedByString:@", "];
    //占位部分sql语句部分
    NSString *values = [keys componentsJoinedByString:@", :"];
    values = [@":" stringByAppendingString:values];
    
    return [NSString stringWithFormat:@"insert into status(%@) values(%@)",colume,values];
}

+ (NSMutableArray *)getArrayFromTable {
    //创建数据库
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
    //打开数据库
    [db open];
    //查询语句
    NSString *sqlString = [NSString stringWithFormat:@"select * from %@ ;",kTravelList];
    //查询并输出结果
    FMResultSet *result = [db executeQuery:sqlString];
    NSMutableArray *dictArray = [NSMutableArray array];
    while ([result next]) {
        //将一条记录转化为一个字典
        NSDictionary *dict = [result resultDictionary];
//        NSMutableDictionary *muDict = [NSMutableDictionary dictionaryWithDictionary:dict];
//        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//            if ([obj isKindOfClass:[NSNull class]]) {
//                [muDict removeObjectForKey:key];
//            }
//        }];
        //将字典转化为模型
//        ListModel *listModel = [[ListModel alloc] initListModelWithDict:muDict];
        [dictArray addObject:dict];
    }
    //释放资源
    [db close];
    return dictArray;
}

+ (ListModel *)getListModelWithListSort:(int)sort {
    //创建数据库
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
    //打开数据库
    [db open];
    //查询语句
    NSString *sqlString = [NSString stringWithFormat:@"select * from %@ where sort = %d;",kTravelList ,sort];
    //查询并输出结果
    FMResultSet *result = [db executeQuery:sqlString];
    NSMutableArray *dictArray = [NSMutableArray array];
    while ([result next]) {
        //将一条记录转化为一个字典
        NSDictionary *dict = [result resultDictionary];
        ListModel *listModel = [[ListModel alloc] initListModelWithDict:dict];
        [dictArray addObject:listModel];
    }
    //释放资源
    [db close];
    return dictArray.firstObject;
}

+ (NSMutableArray *)getListModelsFromDBTable {
    NSMutableArray *dictArray = [DataBaseEngine getArrayFromTable];
    NSMutableArray *listModelArray = [NSMutableArray array];
    [dictArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //将字典转化为模型
        ListModel *listModel = [[ListModel alloc] initListModelWithDict:obj];
        [listModelArray addObject:listModel];
    }];
    return listModelArray;
}

+ (NSMutableArray *)getDetailModelsFromDBTableWithListID:(int)listID
{
    //创建数据库
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
    //打开数据库
    [db open];
    //查询语句
    NSString *sqlString = [NSString stringWithFormat:@"select * from %@ where listid = %d;",kTravelListAndIterm ,listID];
    //查询并输出结果
    FMResultSet *result = [db executeQuery:sqlString];
    NSMutableArray *modelArray = [NSMutableArray array];
    while ([result next]) {
        //将一条记录转化为一个字典
        NSDictionary *dict = [result resultDictionary];
        DetailModel *model = [[DetailModel alloc]initDetailModelWithDict:dict];
        [modelArray addObject:model];
    }
    //释放资源
    [db close];
    
    return modelArray;
}

+ (NSMutableArray *)getCityAndCountryFromDBTableWithName:(NSString *)name
{
    //创建数据库
    FMDatabase *db = [FMDatabase databaseWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
    //打开数据库
    [db open];
    //查询语句
//    NSString *sqlString = [NSString stringWithFormat:];
    //查询并输出结果
    FMResultSet *result = [db executeQuery:@"select name_cn from ? where Rtrim(name_cn) LIKE '%?%'",kCity ,name];
    NSMutableArray *strArray = [NSMutableArray array];
    while ([result next]) {
        NSString *str = [result stringForColumn:0];
        [strArray addObject:str];
    }
    //释放资源
    [db close];
    return strArray;
}

+ (void)deleteTravelListFromTravelListTableWithSort:(NSInteger)sort
{
    //删除操作，首先创建db，写sql语句，执行操作
    //使用队列时不需要自己创建db,队列会创建
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[NSString filePathInDocumentsWithFileName:kDBFileName]];
    [queue inDatabase:^(FMDatabase *db) {
        //创建SQL语句
        NSString *SQLString = [NSString stringWithFormat:@"delete from travellist where sort = %ld;",(long)sort];
        BOOL result = [db executeUpdate:SQLString];
        NSLog(@"%d>>>>%@",result, SQLString);
    }];
}

@end
