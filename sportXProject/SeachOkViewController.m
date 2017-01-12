//
//  SeachOkViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/6/20.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SeachOkViewController.h"
#import "SprotViewTableViewCell.h"
#import "SprotRoomTableViewCell.h"
#import "SearchUserTableViewCell.h"
#import "PersonDesViewController.h"
#import "SportRoomDesViewController.h"
extern UserInfo*LoginUserInfo;
@interface SeachOkViewController ()
{

    UIButton * title_btn1;
    UIButton * title_btn1_state;
    UIButton * title_btn2;
    UIButton * title_btn2_state;
    UISearchBar*searchBar1;
    
    //一是场所二是用户
    UITableView * tableView1;
    UITableView * tableView2;
    UIButton*button;
    UIButton*button1;
    UIImageView *imageView1;
    UIImageView *imageView2;
    //用户
    NSMutableArray*userArray;
    //场所
    NSMutableArray*roomArray;
    
    
    
}
@end

@implementation SeachOkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加场所和用户按钮
    [self addBarAndPersonButton];
    [self setNavigationBar];
    //添加两个视图
    [self initMainView];
    [self requestHotKeyGym];
    // Do any additional setup after loading the view.
}
#pragma mark- 设置导航栏
- (void)setNavigationBar{
    [self.tabBarController.tabBar setBarTintColor:[UIColor blackColor]];
    UIView * navigationTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 64)];
    navigationTitleView.backgroundColor = [UIColor colorWithRed:88/255.0 green:79/255.0 blue:96/255.0 alpha:1];
    [self.view addSubview:navigationTitleView];
    //添加搜索框
    searchBar1 =[[UISearchBar alloc]initWithFrame:CGRectMake(10, 26, KScreenWidth-60, 30)];
    searchBar1.text=_fromSeachKey;
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
//    [searchBar1 becomeFirstResponder];
//    //导航栏取消按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(KScreenWidth-55, 20+(44-25)/2.0, 50, 25);
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationTitleView addSubview:rightButton];
}
//搜索用户
-(void)requestHotKey{
    userArray=nil;
    userArray=[NSMutableArray array];
    NSString*str=[NSString stringWithFormat:@"%@/pilot/searchUser",REQUESTURL];
    //创建参数字符串对象
    Request10013*request10013=[[Request10013 alloc]init];
    request10013.common.userid=LoginUserInfo.userId;
    request10013.common.userkey=LoginUserInfo.userKey;
    request10013.common.cmdid=10013;
    request10013.common.timestamp=[[NSDate date]timeIntervalSince1970];
    request10013.common.platform=2;
    request10013.common.version=sportVersion;
    request10013.params.keyword=searchBar1.text;
    NSData*data2=[request10013 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response10013*response10013=[Response10013 parseFromData:dataString error:nil];
        if (response10013.common.code==0) {
            for (int i=0; i<response10013.data_p.searchedUsersArray.count; i++) {
                SearchedUser*userSearch=[response10013.data_p.searchedUsersArray objectAtIndex:i];
                [userArray addObject:userSearch];
            }
            if (userArray.count==0) {
                button1.hidden = YES;
                imageView1.hidden = NO;
            }else{
                button1.hidden = NO;
                imageView1.hidden = YES;
            }
            [tableView2 reloadData];
            
        }
        
        
    }];
    
}
//搜索场所
-(void)requestHotKeyGym{
    roomArray=nil;
    roomArray=[NSMutableArray array];
    NSString*str=[NSString stringWithFormat:@"%@/pilot/searchGym",REQUESTURL];
    //创建参数字符串对象
    Request10014*request10014=[[Request10014 alloc]init];
    request10014.common.userid=LoginUserInfo.userId;
    request10014.common.userkey=LoginUserInfo.userKey;
    request10014.common.cmdid=10013;
    request10014.common.timestamp=[[NSDate date]timeIntervalSince1970];
    request10014.common.platform=2;
    request10014.common.version=sportVersion;
    request10014.params.keyword=searchBar1.text;
    NSData*data2=[request10014 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response10014*response10014=[Response10014 parseFromData:dataString error:nil];
        if (response10014.common.code==0) {
            for (int i=0; i<response10014.data_p.briefGymsArray.count; i++) {
                BriefGym*userSearch=[response10014.data_p.briefGymsArray objectAtIndex:i];
                [roomArray addObject:userSearch];
            }
            if (roomArray.count==0) {
                imageView1.hidden = NO;
                button.hidden = YES;
            }else{
                imageView1.hidden = YES;
                button.hidden = NO;
            }
            [tableView1 reloadData];
            
        }
        
        
    }];
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self changeTitleLabelState:0];
    tableView1.transform = CGAffineTransformMakeTranslation(0, 0);
    tableView2.transform = CGAffineTransformMakeTranslation(KScreenWidth, 0);
    [self requestHotKeyGym];


}



//取消按钮
- (void)cancelButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

    
}
- (void)addBarAndPersonButton{
    //设置承载两个按钮的视图
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 48)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 47, KScreenWidth, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:207/255.0 green:207/255.0 blue:207/255.0 alpha:1];
    [titleView addSubview:lineView];
    //场所按钮
    title_btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth/2.0, 48)];
    title_btn1.selected = YES;
    title_btn1.tag = 0;
    [title_btn1 setTitle:@"场所" forState:UIControlStateNormal];
    [title_btn1 setTitleColor:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    title_btn1.titleLabel.font = FONT(16);
    [title_btn1 addTarget:self action:@selector(title_btn1_press) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:title_btn1];
    title_btn1_state = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth/8.0, 47, KScreenWidth/4.0, 1)];
    title_btn1_state.backgroundColor = [UIColor redColor];
    [titleView addSubview:title_btn1_state];
    
    //用户按钮
    title_btn2 = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth/2.0, 0, KScreenWidth/2.0, 48)];
    title_btn2.selected = NO;
    title_btn2.tag = 0;
    [title_btn2 setTitle:@"用户" forState:UIControlStateNormal];
    [title_btn2 setTitleColor:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1] forState:UIControlStateNormal];
    title_btn2.titleLabel.font = FONT(16);
    [title_btn2 addTarget:self action:@selector(title_btn2_press) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:title_btn2];
    title_btn2_state = [[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth*5/8.0, 47, KScreenWidth/4.0, 1)];
    title_btn2_state.backgroundColor = [UIColor clearColor];
    [titleView addSubview:title_btn2_state];
    

}

//切换到场所部分
-(void)title_btn1_press{
    [self changeTitleLabelState:0];
    tableView1.transform = CGAffineTransformMakeTranslation(0, 0);
    tableView2.transform = CGAffineTransformMakeTranslation(KScreenWidth, 0);
    [self requestHotKeyGym];

    
}
//切换到用户部分
-(void)title_btn2_press{
    [self changeTitleLabelState:1];
    tableView1.transform = CGAffineTransformMakeTranslation(-KScreenWidth, 0);
    tableView2.transform = CGAffineTransformMakeTranslation(0, 0);
    [self requestHotKey];
 
  
}
//切换场所和用户
-(void)changeTitleLabelState:(int)index{
    if(index == 1){
        //点击用户
        title_btn1.selected = NO;
        title_btn1_state.backgroundColor = [UIColor clearColor];
        title_btn2_state.backgroundColor = [UIColor redColor];
        title_btn2.selected = YES;
   
    }
    else{
        //点击场所
        title_btn2.selected = NO;
        title_btn2_state.backgroundColor = [UIColor clearColor];
        
        title_btn1.selected = YES;
        title_btn1_state.backgroundColor = [UIColor redColor];
   
        
    }
}

#pragma mark 添加两个列表
#pragma mark- 创建场所和用户两个列表
-(void)initMainView{
    //场所列表
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(0, KScreenWidth*(112/KScreenWidth), KScreenWidth, KScreenHeight-48-64)];
    tableView1.backgroundColor = [UIColor whiteColor];
    tableView1.delegate = self;
    tableView1.dataSource = self;
    tableView1.separatorStyle=UITableViewCellSeparatorStyleNone;

    tableView1.tableFooterView=button;
    //用户列表
    tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 48+64, KScreenWidth, KScreenHeight-48-64)];
    tableView2.backgroundColor = [UIColor whiteColor];
    tableView2.delegate = self;
    tableView2.dataSource = self;
    tableView2.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView2.transform = CGAffineTransformMakeTranslation(KScreenWidth, 0);
    [self.view addSubview:tableView1];
    [self.view addSubview:tableView2];
    //数据为空的时候,那个图标
    imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth-85*KScreenWidth/375.0)/2.0, 180, 85*KScreenWidth/375.0, (85+5+18)*KScreenHeight/667.0)];
    imageView1.image = [UIImage imageNamed:@"icon_nothing.png"];
    [self.view addSubview:imageView1];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:tableView1]) {
        
        static   NSString *str=@"cell";
        //使用闲置池
        SprotViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        
        if (cell == nil) {
            NSArray*arry=[[NSBundle mainBundle]loadNibNamed:@"SprotViewTableViewCell" owner:self options:nil];
            cell=[arry objectAtIndex:0];
           
        }
        BriefGym*gymRoom=[roomArray objectAtIndex:indexPath.row];
        [cell._imageGym sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",gymRoom.gymCover]] placeholderImage:[UIImage imageNamed:@""]];
        cell._lbName.text=gymRoom.gymName;
        cell._lbAddress.text=gymRoom.place;
        //设备
        cell.lbBigBei.text=gymRoom.eqm;
        return  cell;

    }else{
    
        static   NSString *str=@"cell2";
        //使用闲置池
        SearchUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        
        if (cell == nil) {
            NSArray*arry=[[NSBundle mainBundle]loadNibNamed:@"SearchUserTableViewCell" owner:self options:nil];
            cell=[arry objectAtIndex:0];
          
        }
        SearchedUser*searchUser=[userArray objectAtIndex:indexPath.row];
        [cell._imageHead sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",searchUser.userAvatar]] placeholderImage:[UIImage imageNamed:@""]];
        cell.lbName.text=searchUser.userName;
        cell.lbSign.text=searchUser.sign;
        cell.mutableArray=searchUser.imagesArray;
        return  cell;

    
    
    }
        
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:tableView1]) {
        return roomArray.count;
    }else{
    
        return userArray.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:tableView1]) {
        return KScreenWidth*(191/KScreenWidth);
    }else{
     return KScreenWidth*(147/KScreenWidth);
    }
   
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    if ([tableView isEqual:tableView1]) {
        BriefGym*gymRoom=[roomArray objectAtIndex:indexPath.row];
        SportRoomDesViewController*controller=[[SportRoomDesViewController alloc]init];
        controller.fromGymID=gymRoom.id_p;
        [self.navigationController pushViewController:controller animated:YES];
        
        
    }else{
        PersonDesViewController*controller=[[PersonDesViewController alloc]init];
      
        SearchedUser*searchUser=[userArray objectAtIndex:indexPath.row];
      
        controller.fromUserId=searchUser.userId;
       
        [self.navigationController pushViewController:controller animated:YES];
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
