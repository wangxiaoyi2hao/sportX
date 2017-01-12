//
//  UserInfo.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/20.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property(nonatomic,copy)NSString*phoneNum;
@property(nonatomic,copy)NSString*passWord;
@property(nonatomic,copy)NSString*userName;
@property(nonatomic,assign)int userId;
@property(nonatomic,copy)NSString*userKey;
//
@property(nonatomic,copy)NSString*rongcludToken;
@property(nonatomic,copy)NSString*userAvata;
@property(nonatomic,copy)NSString*userSign;
@property(nonatomic,assign)int userSex;
@property(nonatomic,assign)float fromLatitue;
@property(nonatomic,assign)float fromLongitue;



@end
