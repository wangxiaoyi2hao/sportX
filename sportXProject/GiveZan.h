//
//  GiveZan.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/6/5.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiveZan : NSObject
//喜欢赞
+(void)sendsend:(int)fromTrend;
//取消赞
+(void)dontSendsend:(int)fromTrend;
@end
