//
//  SportXViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/4/25.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SportXViewController.h"
#import "InfoEditCollectionViewCell.h"
#import "InviteImageViewCell.h"
#import "SprotViewTableViewCell.h"
#import "SportRoomDesViewController.h"
#import "FriendsAllViewController.h"
#import "PersonDesViewController.h"
//定义一个静态的collectionview的变量
static NSString *iden = @"InfoCollectionViewCell";
@interface SportXViewController ()
{

//banner数组
    NSMutableArray*bannerArray;
    //页眉上面的collecitonview
    UICollectionView*_collectionView1;
    //假数据数组。。
    NSMutableArray*nearFriendsArray;

}
@end

@implementation SportXViewController

- (void)viewDidLoad {
   
    #pragma mark 放一个假数据，后期网络请求时可以删除
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
    
    UICollectionView *collectionView = [self _addImgView];
    [putCollView addSubview:collectionView];
    
    
    [super viewDidLoad];
    _tableView.tableHeaderView=_headerView;
    [self loadScrollview];
}
-(void)viewWillAppear:(BOOL)animated{
       
     self.tabBarController.title=@"发现";
     [self.tabBarController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

}
- (UICollectionView *)_addImgView{
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
    
    //2.创建collectionView
    
    //    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,self.changeView1.width, self.changeView1.height) collectionViewLayout:flowLayOut];
    
    _collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, 313, 43) collectionViewLayout:flowLayOut];
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

//-(void)loadViewCollection{
//#pragma mark  collectionView
//    //1.创建布局对象
//    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
//    //设置单元格的大小
//#pragma mark 考虑这里的适配
//    flowLayOut.itemSize = CGSizeMake(20, 20);
//    //设置滑动方向
//    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    //设置每行之间的最小空隙
//    flowLayOut.minimumLineSpacing = 5;
//    flowLayOut.minimumInteritemSpacing = 5;
//     flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//     flowLayOut.minimumLineSpacing = 5;
//    
//#pragma mark- 报名成员(需要动态计算高度)
//   
//    _collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 31, 428) collectionViewLayout:flowLayOut];
//    //上面的那个collectionview
//    _collectionView1.backgroundColor = [UIColor clearColor];
//    _collectionView1.tag=0;
//    //设置代理
//    _collectionView1.delegate = self;
//    _collectionView1.dataSource = self;
//        _collectionView1.showsHorizontalScrollIndicator=NO;
//    //注册单元格
//    [_collectionView1 registerClass:[InfoEditCollectionViewCell class] forCellWithReuseIdentifier:iden];
//    [putCollView addSubview:_collectionView1];
//}
//collectionview 的代理
-(IBAction)goRoomDes:(UIButton*)sender{

    SportRoomDesViewController*controller=[[SportRoomDesViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];


}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  nearFriendsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    InviteImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    NSString*imageName=[nearFriendsArray objectAtIndex:indexPath.row];
    [cell.imgView setImage:[UIImage imageNamed:imageName]];
    //适配相册,让他可以
   
    return cell;


}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

//    FriendsAllViewController*controller=[[FriendsAllViewController alloc]init];
//    [self.navigationController pushViewController:controller animated:YES];
    PersonDesViewController*controller=[[PersonDesViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];

}
-(void)loadScrollview{
    //广告图的数组
    bannerArray=[NSMutableArray arrayWithObjects:@"sportgo.jpg",@"sportgo.jpg",@"sportgo.jpg", nil];
    _scrollview.contentSize=CGSizeMake(KScreenWidth*bannerArray.count, 136);
    _scrollview.pagingEnabled=YES;
    _scrollview.delegate=self;
    for (int i=0; i<bannerArray.count; i++) {
        UIImageView*scrollViewImageView=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*i, 0, KScreenWidth, _scrollview.bounds.size.height)];
 
        [scrollViewImageView setImage:[UIImage imageNamed:[bannerArray objectAtIndex:i]]];
        [_scrollview addSubview:scrollViewImageView];
    }
}
#pragma mark tabelview的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{



    return 10;
}
//组透视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 30)];
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(3, 0, 100, 15)];
    [label setFont:[UIFont systemFontOfSize:13]];
    
        label.text = @"附近健身房";
    label .textColor=[UIColor lightGrayColor];
    [sectionView addSubview:label];
    return sectionView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 181;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static   NSString *str=@"cell";
    //使用闲置池
    SprotViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        NSArray*arry=[[NSBundle mainBundle]loadNibNamed:@"SprotViewTableViewCell" owner:self options:nil];
        cell=[arry objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    SportRoomDesViewController*controller=[[SportRoomDesViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];

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
