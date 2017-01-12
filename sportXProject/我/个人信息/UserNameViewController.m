//
//  UserNameViewController.m
//  sportXProject
//
//  Created by Yao.zhou on 16/5/16.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "UserNameViewController.h"
extern UserInfo*LoginUserInfo;
@interface UserNameViewController ()

@end

@implementation UserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
    [_tfName becomeFirstResponder];
    _tfName.text=LoginUserInfo.userName;
}
-(void)loadNav{
    self.title=@"名字";
    
    //左侧按钮
    UIButton* leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"all_back.png"] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    UIBarButtonItem * leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftitem;
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton*rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40 )];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [rightButton setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    UIBarButtonItem *  rightitem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightitem;
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)rightButtonClick{

        NSString*str=[NSString stringWithFormat:@"%@/pilot/updateMyInfo",REQUESTURL];
        //创建参数字符串对象
        Request10004*request10004=[[Request10004 alloc]init];
        request10004.common.userid=LoginUserInfo.userId;
        request10004.common.userkey=LoginUserInfo.userKey;
        request10004.common.cmdid=11001;
        request10004.common. timestamp=[[NSDate date]timeIntervalSince1970];
        request10004.common.platform=2;
        request10004.common.version=sportVersion;
        request10004.params.userName=_tfName.text;
    
        
        NSData*data2=[request10004 data];
        [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
            Response10004*response10004=[Response10004 parseFromData:dataString error:nil];
            if (response10004.common.code==0) {
                [[Tostal sharTostal]tostalMesg:@"修改成功" tostalTime:1];
                LoginUserInfo.userName=_tfName.text;
               
                [NSKeyedArchiver archiveRootObject:LoginUserInfo toFile:[MyFile fileByDocumentPath:@"/isUserAll.archiver"]];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                
            }
            
            
        }];
        
    }



-(void)leftButtonClick{
    
    MyAlertView *alertView = [[MyAlertView alloc]
                              initWithTitle:@"温馨提示"
                              message:@"确定放弃编辑"
                              cancelButtonTitle:@"取消"
                              otherButtonTitles:@"确定"
                              clickBlock:^(NSInteger index, UIAlertView *alertView) {
                                  if (index == 0) {
                                      
                                      
                                      NSLog(@"取消");
                                  }else if (index == 1) {
                                      [self.navigationController popViewControllerAnimated:YES];
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
