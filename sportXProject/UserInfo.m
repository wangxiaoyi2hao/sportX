//
//  UserInfo.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/20.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "UserInfo.h"
UserInfo*LoginUserInfo;
@implementation UserInfo
- (void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:_userName forKey:@"username"];
    [aCoder encodeObject:_passWord forKey:@"userpwd"];
    [aCoder encodeObject:_phoneNum forKey:@"phoneNum"];

}
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        _userName=[aDecoder decodeObjectForKey:@"username"];
        _passWord=[aDecoder decodeObjectForKey:@"userpwd"];
        _phoneNum=[aDecoder decodeObjectForKey:@"phoneNum"];
     
        
    }
    return self;
}
@end
