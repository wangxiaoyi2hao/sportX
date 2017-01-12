//
//  SprotRoomTableViewCell.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/12.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SprotRoomTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UILabel*lbDes1;

@property(nonatomic,weak)IBOutlet UIImageView*_imageHead;
@property(nonatomic,weak)IBOutlet UILabel*lbName;
@property(nonatomic,strong) UIView*downView;
@property(nonatomic,strong) UIImageView*bigImageP;
@property(nonatomic,strong)UILabel*labelZan;
@property(nonatomic,strong)UILabel*labelPing;
@property(nonatomic,strong) UILabel*lbLine;
@property(nonatomic,strong)UICollectionView*collectionView;
@property(nonatomic,strong)NSMutableArray*picturArray;
@property(nonatomic,strong)UIImageView*imageZan;
@property(nonatomic,strong)UIButton*buttonZan;
@property(nonatomic,strong)UILabel*lbTime;
@property(nonatomic,strong)UILabel*lbDiDIan;


@end
