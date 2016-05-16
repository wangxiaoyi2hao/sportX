//
//  MyCell.m
//  02 CollectionViewDemo
//
//  Created by liyoubing on 15/6/12.
//  Copyright (c) 2015年 liyoubing. All rights reserved.
//

#import "MemberCollectionCell.h"



@implementation MemberCollectionCell

- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        UIView*backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,(KScreenWidth-40)/5.0,(KScreenWidth-40)/5.0)];
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, (KScreenWidth-40)/5.0-10, (KScreenWidth-40)/5.0-10)];
        
        //设置删除按钮
//        _button = [UIButton buttonWithType:UIButtonTypeCustom];
//        if (KScreenWidth ==320) {
//            _button.frame = CGRectMake(0, 0, 12, 12);
//        }else if (KScreenWidth ==375){
//            _button.frame = CGRectMake(0, 0, 14, 14);
//        }else if (KScreenWidth >375){
//            _button.frame = CGRectMake(0, 0, 16, 16);
//        }
//        [_button setImage:[UIImage imageNamed:@"icon_p_d.png"] forState:UIControlStateNormal];
   
        //设置标题
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (KScreenWidth-40)/5.0, (KScreenWidth-40)/5.0, 20)];
        _nameLabel.font = FONT(11);
        _nameLabel.textAlignment=NSTextAlignmentCenter;
//        _imgView.layer.cornerRadius = ((KScreenWidth-40)/5.0-10)/2.0;//边框圆角
//        _imgView.layer.borderWidth = 1;//边框线宽度
//        _imgView.layer.masksToBounds = YES;
        _imgView.layer.borderColor = [UIColor clearColor].CGColor;
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_imgView];
        [self.contentView addSubview:backView];
        [backView addSubview:_button];
        _imageViewQian=[[UIImageView alloc]initWithFrame:CGRectMake((KScreenWidth-40)/5.0-20, (KScreenWidth-40)/5.0-20, 16, 16)];
        [_imageViewQian setImage:[UIImage imageNamed:@"icon_qiandao_b.png"]];
        [self.contentView addSubview:_imageViewQian];
        _imageViewQian.hidden=YES;
        
    }
    return self;
}

- (void)setImgName:(NSString *)imgName {

    _imgName = imgName;
    _imgView.image = [UIImage imageNamed:_imgName];
//    [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imgName]] placeholderImage:[UIImage imageNamed:@"headImg.png"]];
    
    
}
- (void)setNameLabel:(UILabel *)nameLabel{
    _nameLabel = nameLabel;
    
}


@end
