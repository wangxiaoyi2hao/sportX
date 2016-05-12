//
//  SprotViewTableViewCell.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/10.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SprotViewTableViewCell.h"
#import "InviteImageViewCell.h"
#import "MBProgressHUD.h"
static NSString *iden = @"InviteImageViewCell";
@implementation SprotViewTableViewCell

- (void)awakeFromNib {
    _imageAray=[NSMutableArray arrayWithObjects:@"0006",@"0006",@"0006",@"0006",@"0006",@"0006", nil];
    UICollectionView *collectionView = [self _addImgView];
    [self.changeView1 addSubview:collectionView];
    // Initialization code
}
#pragma mark- 网格视图
- (UICollectionView *)_addImgView{
//    _mArray = [[NSMutableArray alloc] init];
#pragma  mark 这个页面width是怎么掉出来的
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
//    flowLayOut.itemSize = CGSizeMake((self.changeView1.width-20)/3.0, (self.changeView1.width-20)/3.0);
    flowLayOut.itemSize=CGSizeMake(111, 80);
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 5;
    //设置滑动的方向,默认是垂直滑动
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置头视图的大小
    flowLayOut.headerReferenceSize = CGSizeZero;
    flowLayOut.footerReferenceSize = CGSizeZero;
    
    //2.创建collectionView
    
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,self.changeView1.width, self.changeView1.height) collectionViewLayout:flowLayOut];

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 344, 95.5) collectionViewLayout:flowLayOut];
    _collectionView.backgroundColor = [UIColor clearColor];
    //设置水平滚动条
    _collectionView.showsHorizontalScrollIndicator=NO;
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //注册单元格
    [_collectionView registerClass:[InviteImageViewCell class] forCellWithReuseIdentifier:iden];
    //设置头视图的大小
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageAray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{

    InviteImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    NSString*imageName=[_imageAray objectAtIndex:indexPath.row];
    [cell.imgView setImage:[UIImage imageNamed:imageName]];
    return cell;
    


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
