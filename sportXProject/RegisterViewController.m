//
//  RegisterViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/18.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "RegisterViewController.h"
#import "MyAlertView.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
    _imageHead.layer.cornerRadius=40;
    _imageHead.layer.masksToBounds=YES;
    
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
-(IBAction)imageClick:(UIButton*)sender{
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"相册", nil];
    [sheet showInView:self.view];



}
-(void)leftClickButTON{

    [self.navigationController popViewControllerAnimated:YES];

}
-(IBAction)selectSex:(UIButton*)sender{
#pragma mark 倒入alter封装好的浮窗。
  
    MyAlertView *alertView = [[MyAlertView alloc]
                              initWithTitle:@"请选择性别"
                              message:@""
                              cancelButtonTitle:@"女"
                              otherButtonTitles:@"男"
                              clickBlock:^(NSInteger index, UIAlertView *alertView) {
                                  if (index == 0) {
                                    _lbSex.text=@"性别：女";
                                      NSLog(@"取消");
                                  }else if (index == 1) {
                                  _lbSex.text=@"性别：男";
                                  }
                              }];
    [alertView show];


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
