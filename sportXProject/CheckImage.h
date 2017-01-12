//
//  CheckImage.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/6/4.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckImage : NSObject


/**
 获取网络图片的Size, 先通过文件头来获取图片大小
 如果失败 会下载完整的图片Data 来计算大小 所以最好别放在主线程
 如果你有使用SDWebImage就会先看下 SDWebImage有缓存过改图片没有
 支持文件头大小的格式 png、gif、jpg   http://www.cocoachina.com/bbs/read.php?tid=165823
 */
+(CGSize)downloadImageSizeWithURL:(id)imageURL;
@end
