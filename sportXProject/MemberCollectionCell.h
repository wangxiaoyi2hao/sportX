//
//  MyCell.h
//  02 CollectionViewDemo
//
//  Created by liyoubing on 15/6/12.
//  Copyright (c) 2015年 liyoubing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberCollectionCell : UICollectionViewCell




@property(nonatomic, copy)NSString *imgName;
@property(nonatomic, copy)UILabel *nameLabel;
@property(nonatomic, strong)UIButton *button;
@property(nonatomic,strong)UIImageView*imgView;
@property(nonatomic,strong)UIImageView*imageViewQian;
@end
