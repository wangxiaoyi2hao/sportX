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
    [self loadViewCollection];
    #pragma mark 放一个假数据，后期网络请求时可以删除
    nearFriendsArray=[NSMutableArray array];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    
    
    
    
    [super viewDidLoad];
    _tableView.tableHeaderView=_headerView;
    [self loadScrollview];
}
-(void)viewWillAppear:(BOOL)animated{
       
     self.tabBarController.title=@"动态";
     [self.tabBarController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

}
-(void)loadViewCollection{
#pragma mark  collectionView
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
#pragma mark 考虑这里的适配
    flowLayOut.itemSize = CGSizeMake(10, 10);
    //设置滑动方向
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 5;
    flowLayOut.minimumInteritemSpacing = 5;
     flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     flowLayOut.minimumLineSpacing = 5;
#pragma mark- 报名成员(需要动态计算高度)
    CGRect cgRect;
    cgRect = CGRectMake(26, 428, 322, 46);
    _collectionView1 = [[UICollectionView alloc] initWithFrame:cgRect collectionViewLayout:flowLayOut];
    //上面的那个collectionview
    _collectionView1.backgroundColor = [UIColor clearColor];
    _collectionView1.tag=0;
    //设置代理
    _collectionView1.delegate = self;
    _collectionView1.dataSource = self;
    //注册单元格
    [_collectionView1 registerClass:[InfoEditCollectionViewCell class] forCellWithReuseIdentifier:iden];
    [_headerView addSubview:_collectionView1];
}
//collectionview 的代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    InviteImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
  
    //适配相册,让他可以
   
    return cell;


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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


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
