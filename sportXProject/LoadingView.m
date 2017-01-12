//
//  LoadingView.m
//  Weclub
//
//  Created by chen on 16/3/7.
//  Copyright © 2016年 BIT. All rights reserved.
//

#import "LoadingView.h"
#import "AppDelegate.h"


@implementation LoadingView

-(void)awakeFromNib{
//    [AppDelegate matchAllScreenWithView:self];
    //(1)创建动画对象
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //(2)设置属性
    basicAnimation.fromValue = 0;
    basicAnimation.toValue = @(M_PI*2);
    //设置动画时间
    basicAnimation.duration = .6;
    //设置重复次数
    basicAnimation.repeatCount = MAXFLOAT;//HUGE_VALF
    //设置锚点(旋转点)
    _loadingImageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    //(3)添加动画
    [_loadingImageView.layer addAnimation:basicAnimation forKey:@"rotation"];
}
+(LoadingView *)shareLoadingView{
    
    static LoadingView* loadingView = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        loadingView = [[[self class] alloc] init];
     
    });
    
    return loadingView;
    
}
-(LoadingView*)findOut{
    _loadingView = [[[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil] lastObject];
    return _loadingView;
}
-(void)hidden{

    [_loadingView removeFromSuperview];
}
@end
