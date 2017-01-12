//
//  SearchUserTableViewCell.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/6/21.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SearchUserTableViewCell.h"
#import "InviteImageViewCell.h"
static NSString *iden = @"InviteImageViewCell";
@implementation SearchUserTableViewCell

- (void)awakeFromNib {
    UICollectionView *collectionView = [self _addImgView];
    [self.changeImgView addSubview:collectionView];
}
#pragma mark- 网格视图
- (UICollectionView *)_addImgView{
   
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
    flowLayOut.itemSize = CGSizeMake((self.changeImgView.width-20)/3.0, (self.changeImgView.width-20)/3.0);
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 5;
    //设置滑动的方向,默认是垂直滑动
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置头视图的大小
    flowLayOut.headerReferenceSize = CGSizeZero;
    flowLayOut.footerReferenceSize = CGSizeZero;
    
    //2.创建collectionView
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,self.changeImgView.width, self.changeImgView.height) collectionViewLayout:flowLayOut];
    _collectionView.backgroundColor = [UIColor clearColor];
    //设置水平滚动条
    _collectionView.showsHorizontalScrollIndicator=NO;
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollEnabled=NO;
    //交互模式
    _collectionView.userInteractionEnabled=NO;
    //注册单元格
    [_collectionView registerClass:[InviteImageViewCell class] forCellWithReuseIdentifier:iden];
    //设置头视图的大小
    return _collectionView;
}
#pragma mark - UICollectionViewDataSource
//指定有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mutableArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    InviteImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    NSString*imageUrl = [_mutableArray objectAtIndex:indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]] placeholderImage:[UIImage imageNamed:@"fsfsd"]];
    //适配相册,让他可以
    if (_mutableArray.count>0) {
        if (_mutableArray.count==1) {
            _collectionView.width = (self.changeImgView.width-20)/3.0+6+5;
        }else if (_mutableArray.count==2) {
            _collectionView.width = 6+(self.changeImgView.width-20)/3.0+5+(self.changeImgView.width-20)/3.0+5;
        }
    }
    return cell;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
