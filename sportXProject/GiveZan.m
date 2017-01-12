//
//  GiveZan.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/6/5.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "GiveZan.h"
extern UserInfo*LoginUserInfo;
@implementation GiveZan
//喜欢赞
+(void)sendsend:(int)fromTrend{
    NSString*str=[NSString stringWithFormat:@"%@/trend/likeTrend",REQUESTURL];
    //创建参数字符串对象
    Request12005*request12005=[[Request12005 alloc]init];
    request12005.common.userid=LoginUserInfo.userId;
    request12005.common.userkey=LoginUserInfo.userKey;
    request12005.common.cmdid=12005;
    request12005.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request12005.common.platform=2;
    request12005.common.version=@"1.0.0";
    request12005.params.trendId=fromTrend;
    request12005.params.likeTrend=true;
    NSData*data2=[request12005 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response12005*response12005=[Response12005 parseFromData:dataString error:nil];
        NSLog(@"%@",response12005);
        if (response12005.common.code==0) {
            
        }else{
            
            [[Tostal sharTostal]tostalMesg:@"网络错误" tostalTime:1];
            
        }
        
    }];
}
//取消赞
+(void)dontSendsend:(int)fromTrend{
    NSString*str=[NSString stringWithFormat:@"%@/trend/likeTrend",REQUESTURL];
    //创建参数字符串对象
    Request12005*request12005=[[Request12005 alloc]init];
    request12005.common.userid=LoginUserInfo.userId;
    request12005.common.userkey=LoginUserInfo.userKey;
    request12005.common.cmdid=12005;
    request12005.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request12005.common.platform=2;
    request12005.common.version=@"1.0.0";
    request12005.params.trendId=fromTrend;
    request12005.params.likeTrend=false;
    NSData*data2=[request12005 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response12005*response12005=[Response12005 parseFromData:dataString error:nil];
        NSLog(@"%@",response12005);
        if (response12005.common.code==0) {
            
        }else{
        
            [[Tostal sharTostal]tostalMesg:@"网络错误" tostalTime:1];
        
        }
        
    }];
}
@end
