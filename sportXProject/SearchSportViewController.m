//
//  SearchSportViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/22.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SearchSportViewController.h"
#import "SearchCollectionViewCell.h"
#import "DBSearch.h"
#import "SeachOkViewController.h"
static NSString *iden = @"SearchCollectionViewCell";
extern UserInfo*LoginUserInfo;
@interface SearchSportViewController ()
{

    UISearchBar*searchBar1;
    //
    UICollectionView*_collectionView;
    //搜索列表的数组
    NSMutableArray*searchArray;
    NSMutableArray*hotCiArray;
    
    
    

}
@end

@implementation SearchSportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self addCollectionView];
    [_headerView setFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth*(220/KScreenWidth))];
    [_footerView setFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth*(42/KScreenWidth))];
    _tableView.tableHeaderView=_headerView;
    _tableView.tableFooterView=_footerView;
    [self requestHotKey];



}
//获取热门关键字
-(void)requestHotKey{
    hotCiArray=nil;
    hotCiArray=[NSMutableArray array];
    NSString*str=[NSString stringWithFormat:@"%@/pilot/getSearchKeys",REQUESTURL];
    //创建参数字符串对象
    Request10015*request10015=[[Request10015 alloc]init];
    request10015.common.userid=LoginUserInfo.userId;
    request10015.common.userkey=LoginUserInfo.userKey;
    request10015.common.cmdid=10015;
    request10015.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request10015.common.platform=2;
    request10015.common.version=sportVersion;
    
    NSData*data2=[request10015 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response10015*response10015=[Response10015 parseFromData:dataString error:nil];
        if (response10015.common.code==0) {
            for (int i=0; i<response10015.data_p.keysArray.count; i++) {
                NSString*searchKey=[response10015.data_p.keysArray objectAtIndex:i];
                [hotCiArray addObject:searchKey];
            }
            
            [_collectionView reloadData];
         
        }
        
        
    }];
    
}

-(IBAction)deleteAll:(UIButton*)sender{
    [[DBSearch sharedInfo] deleteSearchHistory];
    searchArray=[[DBSearch sharedInfo] AllSearchHistory];
    [[Tostal sharTostal]tostalMesg:@"清空历史记录" tostalTime:1];
    [_tableView reloadData];

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    if (![searchBar.text isEqualToString:@""]) {
        [[DBSearch sharedInfo] InsertSearchHistory:searchBar.text];
        SeachOkViewController*controller=[[SeachOkViewController alloc]init];
        controller.fromSeachKey=searchBar.text;
        [self.navigationController pushViewController:controller animated:YES];
     
    }else{
        [[Tostal sharTostal]tostalMesg:@"请输入搜索内容" tostalTime:1];
       
    }


}
-(void)addCollectionView{
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
    flowLayOut.itemSize = CGSizeMake(KScreenWidth*0.2266,KScreenWidth*0.1066);
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 1;
    flowLayOut.minimumInteritemSpacing = 1;
    CGRect cgRectCollectionPhoto = CGRectMake(0, 0, KScreenWidth-25, KScreenWidth*(130/KScreenWidth));

    _collectionView = [[UICollectionView alloc] initWithFrame:cgRectCollectionPhoto collectionViewLayout:flowLayOut];
    _collectionView.tag=1;
    _collectionView.backgroundColor = [UIColor clearColor];
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //注册单元格
    [_collectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:iden];
    [_putCoView addSubview:_collectionView];
}
//collectionview的一些代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return hotCiArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    cell.lbHotCi.text=[hotCiArray objectAtIndex:indexPath.row];
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SeachOkViewController*controller=[[SeachOkViewController alloc]init];
    NSString*seaseaKey=[hotCiArray objectAtIndex:indexPath.row];
    controller.fromSeachKey=seaseaKey;
    [self.navigationController pushViewController:controller animated:YES];

}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [searchBar1 resignFirstResponder];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return searchArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static   NSString *str=@"cell";
    //使用闲置池
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
    }
    cell.textLabel.textColor=[UIColor darkGrayColor];
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    cell.textLabel.text=[searchArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    SeachOkViewController*controller=[[SeachOkViewController alloc]init];
    NSString*seaseaKey=[searchArray objectAtIndex:indexPath.row];
    controller.fromSeachKey=seaseaKey;
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    searchArray=[[DBSearch sharedInfo] AllSearchHistory];

}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark- 设置导航栏
- (void)setNavigationBar{
    [self.tabBarController.tabBar setBarTintColor:[UIColor blackColor]];
    UIView * navigationTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
    navigationTitleView.backgroundColor = [UIColor colorWithRed:88/255.0 green:79/255.0 blue:96/255.0 alpha:1];
    [self.view addSubview:navigationTitleView];
    //添加搜索框
    searchBar1 =[[UISearchBar alloc]initWithFrame:CGRectMake(10, 26, KScreenWidth-60, 30)];
    searchBar1.barTintColor=[UIColor clearColor];
    [searchBar1 setBackgroundImage:[UIImage imageNamed:@"tb_bar.png"]];
    [searchBar1 setScopeBarBackgroundImage:[UIImage imageNamed:@"tb_bar.png"]];
    [searchBar1 setPlaceholder:@"请输入搜索的关键字"];
    searchBar1.delegate=self;
    [navigationTitleView addSubview:searchBar1];
    searchBar1.layer.cornerRadius = 15;
    searchBar1.layer.masksToBounds = YES;
    [searchBar1.layer setBorderWidth:8];
    [searchBar1.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    [searchBar1 becomeFirstResponder];
    //导航栏取消按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(KScreenWidth-55, 20+(44-25)/2.0, 50, 25);
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationTitleView addSubview:rightButton];
}
-(void)cancelButtonAction{

  [self.navigationController popViewControllerAnimated:NO];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
