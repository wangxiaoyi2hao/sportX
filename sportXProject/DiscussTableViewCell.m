//
//  DiscussTableViewCell.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/16.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "DiscussTableViewCell.h"

@implementation DiscussTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _lbDes=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(55/KScreenWidth), KScreenWidth*(31/KScreenWidth), KScreenWidth*(312/KScreenWidth)-KScreenWidth*(55/KScreenWidth), KScreenWidth*(35/KScreenWidth))];
    _lbDes.font=[UIFont systemFontOfSize:12];
    _lbDes.numberOfLines=0;
    [self.contentView addSubview:_lbDes];
    
    _bottomView=[[UIView alloc]initWithFrame:CGRectMake(KScreenWidth*(2/KScreenWidth), KScreenWidth*(64/KScreenWidth), KScreenWidth, KScreenWidth*(28/KScreenWidth))];
    _lbRoom=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(41/KScreenWidth), 4, KScreenWidth-41, 21)];
    _lbRoom.textAlignment=NSTextAlignmentLeft;
    _lbRoom.font=[UIFont systemFontOfSize:10];
    _lbRoom.textColor=[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255.0/255.0 alpha:1];
    [_bottomView addSubview:_lbRoom];
    _lbTime=[[UILabel alloc]initWithFrame:CGRectMake(41, 18, KScreenWidth-41, 21)];
    _lbTime.font=[UIFont systemFontOfSize:10];
     _lbTime.textAlignment=NSTextAlignmentLeft;
    _lbTime.textColor=[UIColor lightGrayColor];
    [_bottomView addSubview:_lbTime];
    _lbLine=[[UILabel alloc]initWithFrame:CGRectMake(0, 38, KScreenWidth, 1)];
    _lbLine.backgroundColor=[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    [_bottomView addSubview:_lbLine];

    [self.contentView addSubview:_bottomView];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
