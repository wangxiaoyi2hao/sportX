//
//  AppDelegate.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/4/25.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "AppDelegate.h"
#import "MineViewController.h"
#import "MessageViewController.h"
#import "OutSignViewController.h"
#import "SportXViewController.h"
#import "UserInfo.h"
#import "MyFile.h"
#import "LoginViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "GuideGOViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "SMessageListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "GuideGOViewController.h"
#import "LoginViewController.h"
extern UserInfo*LoginUserInfo;
float fromLongitude;
float fromLatitude;
@interface AppDelegate ()<RCIMUserInfoDataSource>
{

    int selectIndex;
    CLLocationManager *_locationManager;//用于获取位置
    CLLocation *_checkLocation;//用于保存位置信息
    Response10018*response10018;
    
}
@property(strong,nonatomic)  RCUserInfo* userInfo2;
@end

@implementation AppDelegate
-(void)setupLocationManager{
    _locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"开始定位");
        _locationManager.delegate = self;
        // distanceFilter是距离过滤器，为了减少对定位装置的轮询次数，位置的改变不会每次都去通知委托，而是在移动了足够的距离时才通知委托程序
        // 它的单位是米，这里设置为至少移动1000再通知委托处理更新;
        _locationManager.distanceFilter = 200.0;
        // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        //ios8+以上要授权，并且在plist文件中添加NSLocationWhenInUseUsageDescription，NSLocationAlwaysUsageDescription，值可以为空
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0) {//ios8+，不加这个则不会弹框
            [_locationManager requestWhenInUseAuthorization];//使用中授权
            [_locationManager requestAlwaysAuthorization];
        }
        [_locationManager startUpdatingLocation];
    }else{
        NSLog(@"定位失败，请确定是否开启定位功能");
     
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"didUpdateToLocation+++");
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *cl = [locations lastObject];
    fromLatitude = cl.coordinate.latitude;
    fromLongitude = cl.coordinate.longitude;
    NSLog(@"纬度--%f",cl.coordinate.latitude);//要的经度和纬度、
    NSLog(@"经度--%f",cl.coordinate.longitude);

    //从沙河里面取出个人的用户信息
  
   

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupLocationManager];
    
    [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:1];
    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
   
        [self _judgementScreen];
    //短信验证
        [self shareSDKMessage];
    //在这里先获取一下沙河里面的信息
      LoginUserInfo=[NSKeyedUnarchiver unarchiveObjectWithFile:[MyFile fileByDocumentPath:@"/isUserAll.archiver"]];
    
    //融云调用方法
        [self RongcludThing];
    
    
    //我实在不想再写一个方法了就放到这里吧  上来判断是否复制过搜索记录的sqlite
        NSString *pathStr=[[NSBundle mainBundle] pathForResource:@"sportX" ofType:@"sqlite"];
    
    NSString *document=[MyFile fileByDocumentPath:@"/sportX.sqlite"];
    ;
    if (![[NSFileManager defaultManager] fileExistsAtPath:[MyFile fileByDocumentPath:@"/sportX.sqlite"]]) {
        NSLog(@"还没复制过");
        [[NSFileManager defaultManager] copyItemAtPath:pathStr toPath:document error:nil];
    }else{
        
        NSLog(@"已经复制过");
    }

    //设置定位
  
    return YES;
}
-(void)delayMethod{
    //定位
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
    tabControl.delegate=self;
    tabControl.viewControllers=@[home,web,center,setting];
    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:tabControl];
    nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    if([[UIDevice currentDevice].systemVersion floatValue]>=7.0){
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    _window.rootViewController=nav;
    
    [_window makeKeyAndVisible];


}
-(void)afterWhere{



}
#pragma mark 短信验证
-(void)shareSDKMessage{
    [SMSSDK registerApp:@"12ce9d19c6a94"
             withSecret:
     @"9831ef6e5a61a915c5a1b9f75a589db5"];
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    int index=(int)[tabBarController selectedIndex];
    if(index!=0){
            if(LoginUserInfo==nil){
                    LoginViewController*login=[[LoginViewController alloc]init];
                    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:login];
                    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"] forBarMetrics:UIBarMetricsDefault];
                    nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
                    [tabBarController presentViewController:nav animated:YES completion:nil];
                    tabBarController.selectedIndex=selectIndex;
                }
    }else{
                selectIndex=(int)[tabBarController selectedIndex];
    }
}


#pragma mark 融云的一些方法
//事例化融云的key
-(void)RongcludThing{
 
      [[RCIM sharedRCIM] initWithAppKey:@"qd46yzrf48y6f"];
      [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [[RCIM sharedRCIM]clearUserInfoCache];
    NSLog(@"%@",LoginUserInfo.rongcludToken);
    //获取融云token
    [[RCIM sharedRCIM] connectWithToken:LoginUserInfo.rongcludToken success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}
#pragma mark - 屏幕适配
- (void)_judgementScreen{
    //  程序启动的时候进行对屏幕大小的判断，获取伸缩比例
    if (KScreenWidth==375) {
        self.autoSizeScaleX = 1.0;
        self.autoSizeScaleY = 1.0;
    }else if(KScreenWidth < 375){
        self.autoSizeScaleX = KScreenWidth/375;
        self.autoSizeScaleY = KScreenHeight/667;
        
    }else if(KScreenWidth > 375){
        self.autoSizeScaleX = KScreenWidth/375;
        self.autoSizeScaleY = KScreenHeight/667;
    }
}
//屏幕适配
+ (void)matchAllScreenWithView:(UIView *)allView
{
    for (UIView * tmpView in allView.subviews)
    {
        tmpView.frame = CGRectMake1(tmpView.frame.origin.x, tmpView.frame.origin.y, tmpView.frame.size.width, tmpView.frame.size.height);
        [self matchAllScreenWithView:tmpView];
    }
}
CG_INLINE CGRect
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
}

//去根据userid  抽到我所得到的详细信息
-(void)requestRounHead:(NSString*)userId{
    NSString*str=[NSString stringWithFormat:@"%@/pilot/getBriefUser",REQUESTURL];
    //创建参数字符串对象
    Request10018*request10018=[[Request10018 alloc]init];
    request10018.common.userid=LoginUserInfo.userId;
    request10018.common.userkey=LoginUserInfo.userKey;
    request10018.common.cmdid=10018;
    request10018.common. timestamp=[[NSDate date]timeIntervalSince1970];
    request10018.common.platform=2;
    request10018.common.version=sportVersion;
    request10018.params.userId=[userId intValue];
    NSLog(@"%i",[userId intValue]);
    NSData*data2=[request10018 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        if (response10018.common.code==0) {
            response10018=[Response10018 parseFromData:dataString error:nil];
            _userInfo2.userId=[NSString stringWithFormat:@"%i",response10018.data_p.briefUser.userId];
            _userInfo2.name=response10018.data_p.briefUser.userName;
            _userInfo2.portraitUri=response10018.data_p.briefUser.userAvatar;
            NSLog(@"%@",_userInfo2);
        }
      
        
    }];
  

}


- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *))completion{

    if ([userId isEqualToString:[NSString stringWithFormat:@"%i",LoginUserInfo.userId]]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId=[NSString stringWithFormat:@"%i",LoginUserInfo.userId];
        user.name=LoginUserInfo.userName;
        user.portraitUri=LoginUserInfo.userAvata;
        completion(user);
        return;
    }else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                //2.添加任务到队列中，就可以执行任务
                //        //异步函数：具备开启新线程的能力
                NSString*str=[NSString stringWithFormat:@"%@/pilot/getBriefUser",REQUESTURL];
                //创建参数字符串对象
                Request10018*request10018=[[Request10018 alloc]init];
                request10018.common.userid=LoginUserInfo.userId;
                request10018.common.userkey=LoginUserInfo.userKey;
                request10018.common.cmdid=10018;
                request10018.common. timestamp=[[NSDate date]timeIntervalSince1970];
                request10018.common.platform=2;
                request10018.common.version=sportVersion;
                request10018.params.userId=[userId intValue];
                NSLog(@"%i",[userId intValue]);
                NSData*data2=[request10018 data];
                [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
                    if (response10018.common.code==0) {
                        response10018=[Response10018 parseFromData:dataString error:nil];
                        _userInfo2=[[RCUserInfo alloc]init];
                        _userInfo2.userId=[NSString stringWithFormat:@"%i",response10018.data_p.briefUser.userId];
                        _userInfo2.name=response10018.data_p.briefUser.userName;
                        _userInfo2.portraitUri=response10018.data_p.briefUser.userAvatar;
                        NSLog(@"%@",_userInfo2);
                    }
                    
                    if (_userInfo2) {
                        
                        completion(_userInfo2);
                    }else{
                        completion(nil);
                    }
                }];
                
                
            });
            
           
        });
      
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
