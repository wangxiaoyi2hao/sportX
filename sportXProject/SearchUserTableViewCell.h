//
//  SearchUserTableViewCell.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/6/21.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchUserTableViewCell : UITableViewCell<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>


 @property(nonatomic, weak)   IBOutlet UIView*changeImgView;
@property (nonatomic, strong)NSMutableArray *mutableArray;
@property(nonatomic,weak)IBOutlet UIImageView*_imageHead;
@property(nonatomic,weak)IBOutlet UILabel*lbName;
@property(nonatomic,weak)IBOutlet UILabel*lbSign;

@property(nonatomic, strong)UICollectionView *collectionView;
@end
