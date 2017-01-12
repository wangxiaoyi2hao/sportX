//
//  ChatViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/30.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "ChatViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "PersonDesViewController.h"
extern UserInfo*LoginUserInfo;
@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
    // Do any additional setup after loading the view.
}
-(void)loadNav{
    
    UIButton * leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:[UIImage imageNamed:@"all_back.png"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [leftButton addTarget:self action:@selector(leftClickButTON) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftItem;
    //右侧按钮
    UIButton*rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 22 )];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"icon_qun_1.png"] forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    UIBarButtonItem *  rightitem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightitem;
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(msMyTry) name:@"heh" object:nil];
    
    
}
- (void)didTapCellPortrait:(NSString *)userId{
    PersonDesViewController*controller=[[PersonDesViewController alloc]init];;
    controller.fromUserId =  [userId intValue];
//    UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:controller];
    
//    [self.navigationController presentViewController:nav animated:YES completion:nil];
    [self.navigationController pushViewController:controller animated:YES];
//    
}

-(void)msMyTry{

    [self.conversationMessageCollectionView reloadData];

}
-(void)rightButtonClick{
    PersonDesViewController*controller=[[PersonDesViewController alloc]init];
    controller.fromUserId=[self.targetId intValue];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)leftClickButTON{

    [self.navigationController popViewControllerAnimated:YES];
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
