//
//  SexViewController.m
//  sportXProject
//
//  Created by Yao.zhou on 16/5/16.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SexViewController.h"
extern UserInfo*LoginUserInfo;
@interface SexViewController ()

@end

@implementation SexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
 
}
-(void)loadNav{
     self.title = @"性别";
    
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        static NSString *cellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
  
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                if (LoginUserInfo.userSex==0) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                cell.textLabel.text = @"男";
            }
            if (indexPath.row == 1) {
                if (LoginUserInfo.userSex==1) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                cell.textLabel.text = @"女";
            }
        }
        
        return cell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSString*str=[NSString stringWithFormat:@"%@/pilot/updateMyInfo",REQUESTURL];
            //创建参数字符串对象
            Request10004*request10004=[[Request10004 alloc]init];
            request10004.common.userid=LoginUserInfo.userId;
            request10004.common.userkey=LoginUserInfo.userKey;
            request10004.common.cmdid=11001;
            request10004.common. timestamp=[[NSDate date]timeIntervalSince1970];
            request10004.common.platform=2;
            request10004.common.version=sportVersion;
            request10004.params.sex=Sex_Male;
            request10004.params.sexChanged=true;
            NSData*data2=[request10004 data];
            [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
                Response10004*response10004=[Response10004 parseFromData:dataString error:nil];
                if (response10004.common.code==0) {
                    [[Tostal sharTostal]tostalMesg:@"修改成功" tostalTime:1];
                    LoginUserInfo.userSex=0;;
                    NSLog(@"%@",LoginUserInfo.userAvata);
                    [NSKeyedArchiver archiveRootObject:LoginUserInfo toFile:[MyFile fileByDocumentPath:@"/isUserAll.archiver"]];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    
                }
                
                
            }];

           
        }
        if (indexPath.row == 1) {
            NSString*str=[NSString stringWithFormat:@"%@/pilot/updateMyInfo",REQUESTURL];
            //创建参数字符串对象
            Request10004*request10004=[[Request10004 alloc]init];
            request10004.common.userid=LoginUserInfo.userId;
            request10004.common.userkey=LoginUserInfo.userKey;
            request10004.common.cmdid=11001;
            request10004.common. timestamp=[[NSDate date]timeIntervalSince1970];
            request10004.common.platform=2;
            request10004.common.version=sportVersion;
            request10004.params.sex=Sex_Female;
            NSData*data2=[request10004 data];
            [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
                Response10004*response10004=[Response10004 parseFromData:dataString error:nil];
                if (response10004.common.code==0) {
                    [[Tostal sharTostal]tostalMesg:@"修改成功" tostalTime:1];
                    LoginUserInfo.userSex=1;;
                    NSLog(@"%@",LoginUserInfo.userAvata);
                    [NSKeyedArchiver archiveRootObject:LoginUserInfo toFile:[MyFile fileByDocumentPath:@"/isUserAll.archiver"]];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    
                }
                
                
            }];

        }
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
