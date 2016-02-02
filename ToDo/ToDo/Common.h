//
//  Common.h
//  ToDo
//
//  Created by qingyun on 16/1/28.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#ifndef Common_h
#define Common_h

/*  Size  */
#define kScreenW    [UIScreen mainScreen].bounds.size.width
#define kScreenH    [UIScreen mainScreen].bounds.size.height
#define kScreenB    [UIScreen mainScreen].bounds

/*  ListModel  */
#define kName       @"name"
#define kImage      @"image"
#define kSort       @"sort"
#define kRelatedpoi @"relatedpoi"

/*  DetailModel  */
#define kListid             @"listid"
#define kFenleiname         @"fenleiname"
#define kDetailfenleiid     @"detailfenleiid"
#define kDetailfenleiname   @"detailfenleiname"
#define kIscheck            @"ischeck"
#define kItermsort          @"itermsort"

/*  ItermModel  */
#define kFenleiid           @"fenleiid"
#define kIsuseradd          @"isuseradd"

/*  DBTableName  */
#define kDBFileName                 @"ToDoData.sqlite3"     //数据库文件名
#define kTravelList                 @"travellist"           //清单列表
#define kTravelListAndIterm         @"travellistanditerm"   //列表详情
#define kCity                       @"city"                 //城市列表
#define kCountry                    @"country"              //国家列表
#define kFenLei                     @"fenlei"               //分类列表
#define kFenLeiAndIterm             @"fenleianditerm"       //类别详情
#define kFenleiDetailInfo           @"fenleidetailinfo"     //分类信息
#define kCityAndCountryCount        @"sqlite_sequence"      //国家和城市数量信息


#endif /* Common_h */
