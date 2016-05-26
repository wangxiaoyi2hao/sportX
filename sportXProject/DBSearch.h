//
//  DBSearch.h
//  Weclub
//
//  Created by lsp's mac pro on 16/1/21.
//  Copyright © 2016年 BIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBSearch : NSObject
{
    sqlite3 *_datebase;
}
+(DBSearch *)sharedInfo;
-(NSMutableArray *)AllSearchHistory;
-(BOOL)deleteSearchHistory;
-(BOOL)InsertSearchHistory:(NSString *)searchStr;
#pragma mark  查询用户的历史纪录
-(NSMutableArray *)AllSearchManHistory;
#pragma mark 清空用户的历史纪录
-(BOOL)deleteSearchManHistory;
#pragma mark  添加搜索的用户的记录
-(BOOL)InsertSearchManHistory:(NSString *)searchStr;
@end
