//
//  LoadingView.h
//  Weclub
//
//  Created by chen on 16/3/7.
//  Copyright © 2016年 BIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *loadingImageView;
@property (weak, nonatomic) IBOutlet UILabel *loadingTitleLabel;
@property (weak, nonatomic) IBOutlet LoadingView *backView;
@property(nonatomic,strong)LoadingView*loadingView;
+(LoadingView *)shareLoadingView;
-(LoadingView*)findOut;
-(void)hidden;
@end
