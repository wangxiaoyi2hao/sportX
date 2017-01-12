//
//  CheckPhoneViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/21.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "CheckPhoneViewController.h"
#import "RegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>

@interface CheckPhoneViewController ()

@end

@implementation CheckPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
    [AppDelegate matchAllScreenWithView:self.view];

    // Do any additional setup after loading the view from its nib.
}
-(void)loadNav{
    self.title=@"请输入验证码";
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
-(IBAction)changeNext:(UIButton*)sender{
#pragma mark 正确
    [[Tostal sharTostal]showLoadingView:@"请等待" view:self.view];
    [SMSSDK commitVerificationCode:_textYan.text phoneNumber:_fromPhoneNumber zone:@"86" result:^(NSError *error) {
        
        if (!error) {
            NSLog(@"验证成功");
            [[Tostal sharTostal]hiddenView];
            RegisterViewController*controller=[[RegisterViewController alloc]init];
      controller.fromPhoneNumber=_fromPhoneNumber;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else
        {
            NSLog(@"错误信息:%@",error);
            [[Tostal sharTostal]hiddenView];
            [[Tostal sharTostal]tostalMesg:@"验证码错误" tostalTime:1];
        }
    }];
#pragma 测试
//    RegisterViewController*controller=[[RegisterViewController alloc]init];
//    [self.navigationController pushViewController:controller animated:YES];


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
