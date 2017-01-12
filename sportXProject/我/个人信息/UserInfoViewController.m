//
//  UserInfoViewController.m
//  sportXProject
//
//  Created by Yao.zhou on 16/5/16.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoTableViewCell.h"
#import "UserPhotoViewController.h"
#import "UserNameViewController.h"
#import "SexViewController.h"
#import "SignerViewController.h"

extern UserInfo*LoginUserInfo;
@interface UserInfoViewController ()
{


   
}
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
}
-(void)viewWillAppear:(BOOL)animated{

}
-(void)viewDidAppear:(BOOL)animated{
    
    [_myTableView reloadData];
}
-(void)loadNav{
 self.title = @"个人信息";
    
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
-(void)requestUpdateMessage{
    NSString*str=[NSString stringWithFormat:@"%@/pilot/updateMyInfo",REQUESTURL];
    //创建参数字符串对象
    Request10004*request10004=[[Request10004 alloc]init];
    request10004.common.userid=LoginUserInfo.userId;
    request10004.common.userkey=LoginUserInfo.userKey;
    request10004.common.cmdid=10004;
    request10004.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request10004.common.platform=2;
    request10004.common.version=sportVersion;
    
    NSData*data2=[request10004 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response10004*response11004=[Response10004 parseFromData:dataString error:nil];
        if (response11004.common.code==0) {
           
        }
        
        
    }];
    
}

-(void)leftButtonClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 75;
    } else {
        return 44;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {
        static NSString *cellID1 = @"cell";
        UserInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"UserInfoTableViewCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        
        [cell._imageHead sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",LoginUserInfo.userAvata]] placeholderImage:[UIImage imageNamed:@""]];
        NSLog(@"%@",LoginUserInfo.userAvata);
     
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        static NSString *cellID = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                cell.textLabel.text = @"昵称";
                cell.detailTextLabel.text = LoginUserInfo.userName;
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"性别";
                if (LoginUserInfo.userSex==0) {
                    cell.detailTextLabel.text = @"男";
                }else{
                  cell.detailTextLabel.text = @"女";
                
                }
                
            }
            if (indexPath.row == 1) {
                cell.textLabel.text = @"个性签名";
                cell.detailTextLabel.text = LoginUserInfo.userSign;
            }
        }
        
        return cell;
    }

}
-(void)cellButtonClick{

  


}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
             [self.navigationController pushViewController:[UserPhotoViewController new] animated:YES];
           
        }
        if (indexPath.row == 1) {
            [self.navigationController pushViewController:[UserNameViewController new] animated:YES];
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[SexViewController new] animated:YES];
        }
        if (indexPath.row == 1) {
            [self.navigationController pushViewController:[SignerViewController new] animated:YES];
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
