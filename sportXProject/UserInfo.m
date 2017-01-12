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
    [aCoder encodeInt32:_userId forKey:@"userId"];
    [aCoder encodeObject:_userKey forKey:@"userKey"];
    [aCoder encodeObject:_rongcludToken forKey:@"rongcludToken"];
    [aCoder encodeObject:_userAvata forKey:@"userAvata"];
    [aCoder encodeObject:_userSign forKey:@"userSign"];
    [aCoder encodeInt32:_userSex forKey:@"userSex"];
    [aCoder encodeFloat:_fromLatitue forKey:@"fromLatitue"];
    [aCoder encodeFloat:_fromLongitue forKey:@"fromLongitue"];

}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        _userName=[aDecoder decodeObjectForKey:@"username"];
        _passWord=[aDecoder decodeObjectForKey:@"userpwd"];
        _phoneNum=[aDecoder decodeObjectForKey:@"phoneNum"];
        _userId=[aDecoder decodeInt32ForKey:@"userId"];
        _userKey=[aDecoder decodeObjectForKey:@"userKey"];
        _rongcludToken=[aDecoder decodeObjectForKey:@"rongcludToken"];
        _userAvata=[aDecoder decodeObjectForKey:@"userAvata"];
          _userSign=[aDecoder decodeObjectForKey:@"userSign"];
        _userSex=[aDecoder decodeInt32ForKey:@"userSex"];
        _fromLongitue=[aDecoder decodeFloatForKey:@"fromLongitue"];
        _fromLatitue=[aDecoder decodeFloatForKey:@"fromLatitue"];
      
        
        
    }
    return self;
}
@end
