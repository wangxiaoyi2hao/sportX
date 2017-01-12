//
//  RecievePhoneViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/18.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "RecievePhoneViewController.h"
#import "CheckPhoneViewController.h"
#import <SMS_SDK/SMSSDK.h>
extern UserInfo*LoginUserInfo;
@interface RecievePhoneViewController ()

@end

@implementation RecievePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AppDelegate matchAllScreenWithView:self.view];
    [self loadNav];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadNav{
    self.title=@"获取验证码";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    UIButton * leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:[UIImage imageNamed:@"all_back.png"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [leftButton addTarget:self action:@selector(leftClickButTON) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    
}
-(void)leftClickButTON{

    [self.navigationController popViewControllerAnimated:YES];
}
//显示进度条
-(void)progrssView{
//   MBProgressHUD* _hud = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:_hud];
//    _hud.mode = MBProgressHUDModeAnnularDeterminate;
//    _hud.delegate = self;
//    _hud.labelText = @"Loading";
//    [_hud showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}
-(IBAction)HuoQuCheck:(UIButton*)sender{
#pragma mark 正确逻辑
    //正则判断手机号是否正确
    if ([self isValidateMobile:_tfPhone.text]!=YES) {
        [[Tostal sharTostal]tostalMesg:@"请输入正确手机号" tostalTime:1];
    }else{
        [[Tostal sharTostal]showLoadingView:@"请等待" view:self.view];
            NSString*str=[NSString stringWithFormat:@"%@/pilot/verifyPhoneCanUse",REQUESTURL];
            //创建参数字符串对象
            Request10016*request10016=[[Request10016 alloc]init];
            request10016.common.userid=LoginUserInfo.userId;
            request10016.common.userkey=LoginUserInfo.userKey;
            request10016.common.cmdid=10016;
            request10016.common.  timestamp=[[NSDate date]timeIntervalSince1970];
            request10016.common.platform=2;
            request10016.common.version=sportVersion;
            request10016.params.phone=_tfPhone.text;
            NSData*data2=[request10016 data];
            [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
                Response10016*response10016=[Response10016 parseFromData:dataString error:nil];
                if (response10016.data_p.canUser==YES) {
                    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_tfPhone.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
                        if (!error) {
                            [[Tostal sharTostal]hiddenView];
                            NSLog(@"获取验证码成功");
                            
                            CheckPhoneViewController*controller=[[CheckPhoneViewController alloc]init];
                            controller.fromPhoneNumber=_tfPhone.text;
                            [self.navigationController pushViewController:controller  animated:YES];
                            
                        } else {
                            NSLog(@"错误信息：%@",error);
                        }
                    }];
 
                }else{
                    [[Tostal sharTostal]hiddenView];
                    [[Tostal sharTostal]tostalMesg:@"此手机号已经注册" tostalTime:1];
                }
              
                
            }];

    }
    
//    CheckPhoneViewController*controller=[[CheckPhoneViewController alloc]init];
//                                controller.fromPhoneNumber=_tfPhone.text;
//                                [self.navigationController pushViewController:controller  animated:YES];
}
//判断手机号是否合格方法
-(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
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
