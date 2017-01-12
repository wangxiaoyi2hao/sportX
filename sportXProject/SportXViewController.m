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
#import "SearchSportViewController.h"
#import "TakeFriendQuanViewController.h"
#import "AFNetworking.h"
extern float fromLongitude;
extern float fromLatitude;
extern UserInfo*LoginUserInfo;
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
    //分页count
    int pageCount;
    //附近健身房数组
    NSMutableArray*nearGymArray;
    //推荐健身房返回的参数
    Response13003*response13003;

}
@end

@implementation SportXViewController

- (void)viewDidLoad {
       [super viewDidLoad];
    UITapGestureRecognizer *tapAddImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickAddImage)];
    [_imageGymAva addGestureRecognizer:tapAddImage];
    _imageGymAva.userInteractionEnabled = YES;
    [AppDelegate matchAllScreenWithView:self.view];
    [AppDelegate matchAllScreenWithView:_headerView];
    UICollectionView *collectionView = [self _addImgView];
    [putCollView addSubview:collectionView];
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    _tableView.tableHeaderView=_headerView;
    
   
    [self loadScrollview];
    [self loadNav];
    [self sendsend];
    //加上下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self sendsend];
    }];
   _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       [self sendsendDowLoad];
    }];
    

}

//请求附近健身房
-(void)sendsend{
    pageCount=0;
    nearGymArray=nil;
    nearGymArray=[NSMutableArray array];
    [[Tostal sharTostal]showLoadingView:@"正在加载健身房" view:self.view];
//分页做处理
    NSString*str=[NSString stringWithFormat:@"%@/gym/getGymList",REQUESTURL];
    //创建参数字符串对象
    Request13001*request13001=[[Request13001 alloc]init];
    request13001.common.userid=LoginUserInfo.userId;
    request13001.common.userkey=LoginUserInfo.userKey;
    request13001.common.cmdid=13001;
    request13001.common.timestamp=[[NSDate date]timeIntervalSince1970];
    request13001.common.platform=2;
    request13001.common.version=@"1.0.0";
    request13001.params.longitude=116.487654;
    request13001.params.latitude=39.933565;
    request13001.params.pageIndex=pageCount;
    NSLog(@"%.2f",fromLatitude);
    NSData*data2=[request13001 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
            Response13001*response13001=[Response13001 parseFromData:dataString error:nil];
        if (response13001.common.code==0) {
            for (int i=0; i<response13001.data_p.briefGymsArray.count; i++) {
                BriefGym*gymRoom=[response13001.data_p.briefGymsArray objectAtIndex:i];
                [nearGymArray addObject:gymRoom];
            }
            NSLog(@"%@",nearGymArray);
            [_tableView reloadData];
            [[Tostal sharTostal]hiddenView];
             [_tableView.mj_header endRefreshing];
        }else{
              [[Tostal sharTostal]tostalMesg:response13001.common.message tostalTime:1];
             [[Tostal sharTostal]hiddenView];
             [_tableView.mj_header endRefreshing];
            }
        }];
}
//请求附近健身房
-(void)sendsendDowLoad{
    pageCount++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //分页做处理
    NSString*str=[NSString stringWithFormat:@"%@/gym/getGymList",REQUESTURL];
    //创建参数字符串对象
    Request13001*request13001=[[Request13001 alloc]init];
    request13001.common.userid=LoginUserInfo.userId;
    request13001.common.userkey=LoginUserInfo.userKey;
    request13001.common.cmdid=13001;
    request13001.common.timestamp=[[NSDate date]timeIntervalSince1970];
    request13001.common.platform=2;
    request13001.common.version=@"1.0.0";
    request13001.params.longitude=116.487654;
    request13001.params.latitude=39.933565;
    NSLog(@"%.2f",LoginUserInfo.fromLatitue);
    request13001.params.pageIndex=pageCount;
    NSLog(@"%.2f",fromLatitude);
    NSData*data2=[request13001 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response13001*response13001=[Response13001 parseFromData:dataString error:nil];
        if (response13001.common.code==0) {
              NSLog(@"%@",response13001.data_p.briefGymsArray);
            for (int i=0; i<response13001.data_p.briefGymsArray.count; i++) {
                BriefGym*gymRoom=[response13001.data_p.briefGymsArray objectAtIndex:i];
                [nearGymArray addObject:gymRoom];
            }
            if (response13001.data_p.maxCountPerPage>response13001.data_p.briefGymsArray.count) {
                  [_tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
            
               [_tableView.mj_footer endRefreshing];
            }
            
          
            [_tableView reloadData];
            [[Tostal sharTostal]hiddenView];
         
        }else{
            [[Tostal sharTostal]tostalMesg:response13001.common.message tostalTime:1];
            [[Tostal sharTostal]hiddenView];
            [_tableView.mj_footer endRefreshing];
        }
    }];
}

//请求推荐健身房
-(void)requestTopGym{
     nearFriendsArray=nil;
     nearFriendsArray=[NSMutableArray array];
    //分页做处理
    NSString*str=[NSString stringWithFormat:@"%@/gym/getRecommendGym",REQUESTURL];
    //创建参数字符串对象
    Request13003*request13003=[[Request13003 alloc]init];
    request13003.common.userid=LoginUserInfo.userId;
    request13003.common.userkey=LoginUserInfo.userKey;
    request13003.common.cmdid=13003;
    request13003.common.timestamp=[[NSDate date]timeIntervalSince1970];
    request13003.common.platform=2;
    request13003.common.version=@"1.0.0";
    request13003.params.longitude=116.487654;
    request13003.params.latitude=39.933565;
    //询问后台看怎么去请求
//    request13003.params.gymId=
    NSLog(@"%.2f",fromLatitude);
    NSData*data2=[request13003 data];

    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
       response13003=[Response13003 parseFromData:dataString error:nil];
        if (response13003.common.code==0) {
            NSLog(@"%@",nearGymArray);
            [_imageGymAva sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",response13003.data_p.briefGym.gymAvatar]] placeholderImage:[UIImage imageNamed:@""]];
            lbGymName.text=response13003.data_p.briefGym.gymName;
            lbGymPerCount.text=[NSString stringWithFormat:@"%i",response13003.data_p.userNum];
            lbGymSheBei.text=response13003.data_p.briefGym.eqm;
            lbTrendCount.text=[NSString stringWithFormat:@"%i",response13003.data_p.trendNum];
            for (int i=0; i<response13003.data_p.briefUsersArray.count; i++) {
                BriefUser*brbr=[response13003.data_p.briefUsersArray objectAtIndex:i];
                [nearFriendsArray addObject:brbr];
            }
            [_collectionView1 reloadData];
         
        }else{
            [[Tostal sharTostal]tostalMesg:response13003.common.message tostalTime:1];
        
        }
    }];
}
-(void)onclickAddImage{
    
    
    SportRoomDesViewController*controller=[[SportRoomDesViewController alloc]init];
    controller.fromGymID=response13003.data_p.briefGym.id_p;
    [self.navigationController pushViewController:controller animated:YES];
    //吊的不行
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate=nil;
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.title=@"发现";
    [self.tabBarController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //推荐健身房
    [self requestTopGym];
}
-(void)loadNav{
    //左侧按钮
    UIButton* leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"icon_search.png"] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    UIBarButtonItem * leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.tabBarController.navigationItem.leftBarButtonItem = leftitem;
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //右侧按钮
    UIButton*rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 20 )];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    UIBarButtonItem *  rightitem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.tabBarController.navigationItem.rightBarButtonItem = rightitem;
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}
//右边按钮点击事件
-(void)rightButtonClick{

    
//跳转发布页面
    TakeFriendQuanViewController*controller=[[TakeFriendQuanViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];


}
//左边按钮点击事件
-(void)leftButtonClick{

    SearchSportViewController*controller=[[SearchSportViewController alloc]init];
//    controller.hidesBottomBarWhenPushed=YES;
    //初始化一个转场动画
    CATransition *transition = [[CATransition alloc] init];
    //设置转场动画风格
    //transition.type = @"cube";
    transition.duration = 0.3;
    //设置动画的方向
    transition.subtype = kCATransitionFromTop;
    //把动画添加到导航控制器视图的图层上
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:controller animated:NO];
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
///collectionview 的代理
-(IBAction)goRoomDes:(UIButton*)sender{

    SportRoomDesViewController*controller=[[SportRoomDesViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];


}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  nearFriendsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    InviteImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    BriefUser*brbr2=[nearFriendsArray objectAtIndex:indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",brbr2.userAvatar]] placeholderImage:[UIImage imageNamed:@""]];
    //适配相册,让他可以
   
    return cell;


}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BriefUser*brbr2=[nearFriendsArray objectAtIndex:indexPath.row];
    PersonDesViewController*controller=[[PersonDesViewController alloc]init];
    controller.fromUserId=brbr2.userId;
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



    return nearGymArray.count;
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
     AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return 191*app.autoSizeScaleY;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static   NSString *str=@"cell";
    //使用闲置池
    SprotViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        NSArray*arry=[[NSBundle mainBundle]loadNibNamed:@"SprotViewTableViewCell" owner:self options:nil];
        cell=[arry objectAtIndex:0];
     
    }
    BriefGym*gymRoom;
    if (nearGymArray.count!=0) {
          gymRoom=[nearGymArray objectAtIndex:indexPath.row];
    }
  
    [cell._imageGym sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",gymRoom.gymCover]] placeholderImage:[UIImage imageNamed:@""]];
    cell._lbName.text=gymRoom.gymName;
    cell._lbAddress.text=gymRoom.place;
    //设备
    cell.lbBigBei.text=gymRoom.eqm;
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    BriefGym*gymRoom=[nearGymArray objectAtIndex:indexPath.row];
    SportRoomDesViewController*controller=[[SportRoomDesViewController alloc]init];
    controller.fromGymID=gymRoom.id_p;
    [self.navigationController pushViewController:controller animated:YES];
    //吊的不行
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate=nil;
    }

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
