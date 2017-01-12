//
//  LoginViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/18.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//
#import "RecievePhoneViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SportXViewController.h"
#import "OutSignViewController.h"
#import "SMessageListViewController.h"
#import "MineViewController.h"
extern UserInfo*LoginUserInfo;
extern float fromLongitude;
extern float fromLatitude;
@interface LoginViewController ()<RCIMUserInfoDataSource>
{
    int selectIndex;

}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
    [AppDelegate matchAllScreenWithView:self.view];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadNav{
    self.title=@"登录";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton * leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:[UIImage imageNamed:@"all_back.png"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [leftButton addTarget:self action:@selector(leftClickButTON) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftItem;
    if (_fromWhere==BEGINGO) {
        leftButton.hidden=YES;
        //右侧按钮
        UIButton*rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40 )];
        rightButton.backgroundColor = [UIColor clearColor];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //    [rightButton setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
        [rightButton setTitle:@"跳过" forState:UIControlStateNormal];
        rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
        UIBarButtonItem *  rightitem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = rightitem;
        [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];

    }
    
    
}
-(void)rightButtonClick{

    UITabBarController*tabControl=[[UITabBarController alloc]init];
    tabControl.tabBar.tintColor=[UIColor blackColor];
    SportXViewController*home=[[SportXViewController alloc]init];
    home.tabBarItem.title=@"发现";
    home.tabBarItem.image=[UIImage imageNamed:@"compass.png"];
    OutSignViewController*web=[[OutSignViewController alloc]init];
    web.tabBarItem.title=@"关注";
    web.tabBarItem.image=[UIImage imageNamed:@"positive.png"];
    SMessageListViewController*center=[[SMessageListViewController alloc]init];
    center.tabBarItem.title=@"消息";
    center.tabBarItem.image=[UIImage imageNamed:@"Messageicon.png"];
    MineViewController*setting=[[MineViewController alloc]init];
    setting.tabBarItem.title=@"我";
    setting.tabBarItem.image=[UIImage imageNamed:@"user_avatart.png"];
    tabControl.delegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    tabControl.viewControllers=@[home,web,center,setting];
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:tabControl];
    nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    if([[UIDevice currentDevice].systemVersion floatValue]>=7.0){
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }

   ((AppDelegate *)([UIApplication sharedApplication]).delegate).window.rootViewController = nav;
    [UIView animateWithDuration:.5 animations:^{
        nav.view.layer.transform = CATransform3DIdentity;
    }];


}

-(IBAction)rigriseClick:(UIButton*)sender{
    
    
    RecievePhoneViewController*controller=[[RecievePhoneViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];


}
-(IBAction)loginClick:(UIButton*)sender{

    NSString*str=[NSString stringWithFormat:@"%@/pilot/login",REQUESTURL];
    //创建参数字符串对象
    Request10002*request10002=[[Request10002 alloc]init];
    request10002.common.userid=LoginUserInfo.userId;
    request10002.common.userkey=LoginUserInfo.userKey;
    request10002.common.cmdid=11001;
    request10002.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request10002.common.platform=2;
    request10002.common.version=sportVersion;
    request10002.params.phone=__tfPoneNum.text;
    request10002.params.password=[HelperUtil md532BitUpper:__tfPassWord.text];
    
    NSData*data2=[request10002 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response10002*response10002=[Response10002 parseFromData:dataString error:nil];
        if (response10002.common.code==0) {
            UserInfo*userGo=[[UserInfo alloc]init];
            userGo.userId=response10002.data_p.briefUser.userId;
            userGo.userKey=response10002.data_p.userKey;
            userGo.userName=response10002.data_p.briefUser.userName;
            userGo.userAvata=response10002.data_p.briefUser.userAvatar;
            userGo.userSex=response10002.data_p.sex;
            userGo.userSign=response10002.data_p.sign;
            userGo.phoneNum=response10002.data_p.phone;
            userGo.rongcludToken=response10002.data_p.rongyunToken;
            NSLog(@"%@",response10002.data_p.rongyunToken);
            LoginUserInfo=userGo;
            [NSKeyedArchiver archiveRootObject:userGo toFile:[MyFile fileByDocumentPath:@"/isUserAll.archiver"]];
            [[Tostal sharTostal]hiddenView];
           

            [self RongcludThing];
        }
        
        
    }];


}
-(void)getRongCloudTokenUser{

    NSString*str=[NSString stringWithFormat:@"%@/token/getRongyunToken",REQUESTURL];
    //创建参数字符串对象
    Request11002*request11002=[[Request11002 alloc]init];
    request11002.common.userid=LoginUserInfo.userId;
    request11002.common.userkey=LoginUserInfo.userKey;
    request11002.common.cmdid=11002;
    request11002.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request11002.common.platform=2;
    request11002.common.version=sportVersion;
    request11002.params.oldTokenCannotUse=YES;
   
    
    NSData*data2=[request11002 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response11002*response11002=[Response11002 parseFromData:dataString error:nil];
        if (response11002.common.code==0) {
            LoginUserInfo.rongcludToken=response11002.data_p.rongyunToken;
            NSLog(@"%@",LoginUserInfo.rongcludToken);
            [NSKeyedArchiver archiveRootObject:LoginUserInfo toFile:[MyFile fileByDocumentPath:@"/isUserAll.archiver"]];
            [self RongcludThing];
        }
        
        
    }];

}
//事例化融云的key
-(void)RongcludThing{
    
    [[RCIM sharedRCIM] initWithAppKey:@"qd46yzrf48y6f"];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    //    [[RCIM sharedRCIM]clearUserInfoCache];
    NSLog(@"%@",LoginUserInfo.rongcludToken);
    //获取融云token
    NSLog(@"%@",LoginUserInfo.rongcludToken);
    [[RCIM sharedRCIM] connectWithToken:LoginUserInfo.rongcludToken success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
         [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        [self getRongCloudTokenUser];
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}
-(void)leftClickButTON{
    if (_fromWhere==940812) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"huidaoshouye" object:nil];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else{
       [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
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
