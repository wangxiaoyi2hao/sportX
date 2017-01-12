//
//  SetUpViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/30.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SetUpViewController.h"
#import "LoginViewController.h"
#import "AboutViewController.h"
extern UserInfo*LoginUserInfo;
@interface SetUpViewController ()

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AppDelegate matchAllScreenWithView:self.view];
    [self loadNav];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadNav{
    self.title=@"设置";
    
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else{
     return 1;
    }

   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
         NSUInteger cacheTuger= [[SDImageCache sharedImageCache]getSize];
            cell.textLabel.text = @"清除缓存";
            if (cacheTuger>=1) {
                   cell.detailTextLabel.text = [NSString stringWithFormat:@"%.0luM",(unsigned long)[[SDImageCache sharedImageCache]getSize]/1024/1024];
            }else{
            cell.detailTextLabel.text=@"0M";
            
            }
         
        }
        if (indexPath.row==1) {
            cell.textLabel.text=@"关于SportX";
        }
        if (indexPath.row==2) {
            cell.textLabel.text=@"去评分";
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"退出登录";
            cell.textLabel.textColor=[UIColor redColor];
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
          
        }
     
    }
    
    return cell;

}
//

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            [[SDImageCache sharedImageCache]clearDisk];
            [tableView reloadData];
        }
        if (indexPath.row==1) {
            AboutViewController*controller=[[AboutViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:@"退出后不会删除任何历史数据，下次登陆后依然可以使用本帐号" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"退出登录" otherButtonTitles:@"取消", nil];
            [sheet showInView:self.view];
            
        }
        
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        LoginUserInfo=nil;
        [NSKeyedArchiver archiveRootObject:LoginUserInfo toFile:[MyFile fileByDocumentPath:@"/isUserAll.archiver"]];
          LoginViewController*controller=[[LoginViewController alloc]init];
        UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:controller];
        [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_ios7.png"] forBarMetrics:UIBarMetricsDefault];
        nav.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
        controller.fromWhere=940812;
        [self.navigationController presentViewController:nav animated:YES completion:nil];
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
