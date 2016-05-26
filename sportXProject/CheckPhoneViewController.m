//
//  CheckPhoneViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/21.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "CheckPhoneViewController.h"
#import "RegisterViewController.h"

@interface CheckPhoneViewController ()

@end

@implementation CheckPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadNav{
    self.title=@"注册";
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
    RegisterViewController*controller=[[RegisterViewController alloc]init];
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
