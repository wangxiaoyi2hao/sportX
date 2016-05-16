//
//  SportRoomDesViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/11.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SportRoomDesViewController.h"
#import "SprotRoomTableViewCell.h"
#import "InviteImageViewCell.h"
#import "LookUpPicViewController.h"
static NSString *iden = @"InfoCollectionViewCell";
@interface SportRoomDesViewController ()
{

    //页眉上面的collecitonview
    UICollectionView*_collectionView1;
    NSMutableArray*nearFriendsArray;
    UICollectionView*_collectionView2;
    


}
@end

@implementation SportRoomDesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.title=@"某个健身房";
    [self loadNav];
    UICollectionView *collectionView = [self _addImgView];
    [_putCollection1 addSubview:collectionView];
    _tableView.tableHeaderView=_headerView;
    
    
    UICollectionView*collectionView2=[self _addImgView2];
    [_putCollection2 addSubview:collectionView2];
    
#pragma mark 
     nearFriendsArray=[NSMutableArray array];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
}
- (UICollectionView *)_addImgView{
    //    _mArray = [[NSMutableArray alloc] init];
#pragma  mark 这个页面width是怎么掉出来的
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
    //    flowLayOut.itemSize = CGSizeMake((self.changeView1.width-20)/3.0, (self.changeView1.width-20)/3.0);
    flowLayOut.itemSize=CGSizeMake(80, 70);
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 5;
    //设置滑动的方向,默认是垂直滑动
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置头视图的大小
    flowLayOut.headerReferenceSize = CGSizeZero;
    flowLayOut.footerReferenceSize = CGSizeZero;
    
    
    _collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, 375, 70) collectionViewLayout:flowLayOut];
    _collectionView1.backgroundColor = [UIColor clearColor];
    //设置水平滚动条
    _collectionView1.showsHorizontalScrollIndicator=NO;
    //设置代理
    _collectionView1.delegate = self;
    _collectionView1.dataSource = self;
    //注册单元格
    [_collectionView1 registerClass:[InviteImageViewCell class] forCellWithReuseIdentifier:iden];
    //设置头视图的大小
    return _collectionView1;
}
- (UICollectionView *)_addImgView2{
    //    _mArray = [[NSMutableArray alloc] init];
#pragma  mark 这个页面width是怎么掉出来的
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
    //    flowLayOut.itemSize = CGSizeMake((self.changeView1.width-20)/3.0, (self.changeView1.width-20)/3.0);
    flowLayOut.itemSize=CGSizeMake(40, 40);
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 5;
    //设置滑动的方向,默认是垂直滑动
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置头视图的大小
    flowLayOut.headerReferenceSize = CGSizeZero;
    flowLayOut.footerReferenceSize = CGSizeZero;
    
    
    _collectionView2 = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, 375, 43) collectionViewLayout:flowLayOut];
    _collectionView2.backgroundColor = [UIColor clearColor];
    //设置水平滚动条
    _collectionView2.showsHorizontalScrollIndicator=NO;
    //设置代理
    _collectionView2.delegate = self;
    _collectionView2.dataSource = self;
    //注册单元格
    [_collectionView2 registerClass:[InviteImageViewCell class] forCellWithReuseIdentifier:iden];
    //设置头视图的大小
    return _collectionView2;
}

-(void)loadNav{

    UIButton * leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:[UIImage imageNamed:@"all_back.png"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [leftButton addTarget:self action:@selector(leftClickButTON) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftItem;


}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

 return  nearFriendsArray.count;

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    InviteImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    NSString*imageName=[nearFriendsArray objectAtIndex:indexPath.row];
    [cell.imgView setImage:[UIImage imageNamed:imageName]];
    return cell;

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if ([collectionView isEqual:_collectionView1]) {
        LookUpPicViewController*controller= [[LookUpPicViewController alloc]init];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }

}
//左侧按钮点击事件
-(void)leftClickButTON{
    [self.navigationController popViewControllerAnimated:YES];

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 353;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static   NSString *str=@"cell";
    //使用闲置池
    SprotRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        NSArray*arry=[[NSBundle mainBundle]loadNibNamed:@"SprotRoomTableViewCell" owner:self options:nil];
        cell=[arry objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.lbDes.text=@"111111111111111111";
    return  cell;

#pragma  mark 这里面的cell 的type 不一样到时候看type 然后再根据东西来做
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
