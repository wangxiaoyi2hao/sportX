//
//  SprotRoomTableViewCell.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/12.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SprotRoomTableViewCell.h"
#import "InviteImageViewCell.h"
static NSString*iden=@"InviteImageViewCell";
#import "MJPhotoBrowser/MJPhoto.h"
#import "MJPhotoBrowser.h"
@implementation SprotRoomTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _lbDes1=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*0.194666667, KScreenWidth*0.0986667, KScreenWidth*0.76, 20)];
    [_lbDes1 setFont:[UIFont systemFontOfSize:12]];
    _lbDes1.numberOfLines=0;
    [self.contentView addSubview:_lbDes1];
    //0 300 375 49
   _downView=[[UIView alloc]initWithFrame:CGRectMake(0, KScreenWidth*0.8, KScreenWidth, KScreenWidth*(60/KScreenWidth))];
    _downView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_downView];
    
    if (KScreenWidth<375) {
        /*从新算一下左边给向下面放点*/
        _imageZan=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*(190/KScreenWidth), KScreenWidth*(33/KScreenWidth), KScreenWidth*0.048, KScreenWidth*0.048)];
        [_imageZan setImage:[UIImage imageNamed:@"like.png"]];
        [_downView addSubview:_imageZan];
        _buttonZan=[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth*(180/KScreenWidth), 15, 90, 90)];
        [_downView addSubview:_buttonZan];
        _labelZan=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(220/KScreenWidth), 33, 40, 21)];
        [_labelZan setFont:[UIFont systemFontOfSize:14]];
        [_downView addSubview:_labelZan];
        UIImageView*imagePing=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*(250/KScreenWidth) ,  KScreenWidth*(35/KScreenWidth), KScreenWidth*0.048, KScreenWidth*0.048)];
        [imagePing setImage:[UIImage imageNamed:@"message"]];
        [_downView addSubview:imagePing];
        _labelPing=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(280/KScreenWidth), KScreenWidth*(33/KScreenWidth), 40, 21)];
        [_labelPing setFont:[UIFont systemFontOfSize:14]];
        [_downView addSubview:_labelPing];
        _lbLine=[[UILabel alloc]initWithFrame:CGRectMake(0, KScreenWidth*(59/KScreenWidth), KScreenWidth, 1)];
        _lbLine.backgroundColor=[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
        [_downView addSubview:_lbLine];

    }else{
    
        /*从新算一下左边给向下面放点*/
        _imageZan=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*(200/KScreenWidth), KScreenWidth*(33/KScreenWidth), KScreenWidth*0.048, KScreenWidth*0.048)];
        [_imageZan setImage:[UIImage imageNamed:@"like.png"]];
        [_downView addSubview:_imageZan];
        _buttonZan=[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth*(180/KScreenWidth), 15, 90, 90)];
        [_downView addSubview:_buttonZan];
        _labelZan=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(235/KScreenWidth), 33, 40, 21)];
        [_labelZan setFont:[UIFont systemFontOfSize:14]];
        
        [_downView addSubview:_labelZan];
        UIImageView*imagePing=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*(300/KScreenWidth) ,  KScreenWidth*(35/KScreenWidth), KScreenWidth*0.048, KScreenWidth*0.048)];
        [imagePing setImage:[UIImage imageNamed:@"message"]];
        [_downView addSubview:imagePing];
        _labelPing=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(334/KScreenWidth), KScreenWidth*(33/KScreenWidth), 40, 21)];
        [_labelPing setFont:[UIFont systemFontOfSize:14]];
        [_downView addSubview:_labelPing];
        _lbLine=[[UILabel alloc]initWithFrame:CGRectMake(0, KScreenWidth*(59/KScreenWidth), KScreenWidth, 1)];
        _lbLine.backgroundColor=[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
        [_downView addSubview:_lbLine];

    
    }
    
  //如果是单独图片的时候
    _bigImageP=[[UIImageView alloc]initWithFrame:CGRectMake(0, 141, KScreenWidth-40, 169)];
    _bigImageP.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_bigImageP];
    _lbDiDIan=[[UILabel alloc]initWithFrame:CGRectMake(73, 15, KScreenWidth-73, 15)];
    _lbDiDIan.font=[UIFont systemFontOfSize:10];
    _lbDiDIan.textColor=[UIColor colorWithRed:0/255.0 green:122.0/255.0 blue:255.0 alpha:1];
    [_downView addSubview:_lbDiDIan];
    _lbTime=[[UILabel alloc]initWithFrame:CGRectMake(_lbDes1.origin.x, 0, KScreenWidth, KScreenWidth*0.04)];
    _lbTime.textColor=[UIColor lightGrayColor];
    _lbTime.font=[UIFont systemFontOfSize:10];
    [_downView addSubview:_lbTime];
    [self _addMemberList];
    
}
#pragma mark- 设置成员列表
- (void)_addMemberList{
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
    flowLayOut.itemSize = CGSizeMake((KScreenWidth-130)/3.0,(KScreenWidth-130)/3.0);
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 1;
    flowLayOut.minimumInteritemSpacing = 2;
    CGRect cgRectCollectionPhoto = CGRectMake(70, 172, KScreenWidth-125, KScreenHeight-KScreenWidth+30);
#pragma mark- 设置相册布局
    _collectionView = [[UICollectionView alloc] initWithFrame:cgRectCollectionPhoto collectionViewLayout:flowLayOut];
    _collectionView.tag=1;
    _collectionView.backgroundColor = [UIColor clearColor];
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //    //禁止滚动
    _collectionView.scrollEnabled = NO;
    //注册单元格
    [_collectionView registerClass:[InviteImageViewCell class]
        forCellWithReuseIdentifier:iden];
    _collectionView.userInteractionEnabled=NO;
    [self.contentView addSubview:_collectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _picturArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InviteImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    NSString*imageName=[_picturArray objectAtIndex:indexPath.row];
//    [cell.imgView setImage:[UIImage imageNamed:@"0006.png"]];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageName]] placeholderImage:[UIImage imageNamed:@""]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 119;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 3;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
