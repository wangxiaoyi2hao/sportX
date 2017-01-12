//
//  XbiViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/30.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "XbiViewController.h"

@interface XbiViewController ()

@end

@implementation XbiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
    [AppDelegate matchAllScreenWithView:self.view];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadNav{
    self.title=@"我的X币";
    //左侧按钮
    UIButton* leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"all_back.png"] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    UIBarButtonItem * leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftitem;
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)leftButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)xbWei:(UIButton*)sender{

    UIAlertView*ate2r=[[UIAlertView alloc]initWithTitle:nil message:@"此功能程序员兄弟们正在开发" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [ate2r show];

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
