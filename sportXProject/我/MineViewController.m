//
//  MineViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/4/25.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadTableViewCell.h"
#import "MineOtherTableViewCell.h"
#import "UserInfoViewController.h"
#import "SetUpViewController.h"
#import "FansViewController.h"
#import "AttentionViewController.h"
#import "XbiViewController.h"
#import "UserPhotoMyViewController.h"
extern UserInfo*LoginUserInfo;
@interface MineViewController ()
@property (nonatomic,weak) IBOutlet UITableView *myTableView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AppDelegate matchAllScreenWithView:self.view];

}
-(void)viewWillAppear:(BOOL)animated{
    [_myTableView reloadData];
  self.tabBarController.title=@"我";
    [self.tabBarController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor ]}];

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (indexPath.section == 0) {
        return 100*app.autoSizeScaleY;
    } else {
        return 53*app.autoSizeScaleY;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 3:
            return 1;
            break;
            
        default:
            return 2;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static  NSString *cellId1=@"cell1";
    static  NSString *cellId2=@"cell2";
    if (indexPath.section == 0) {
        MineHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MineHeadTableViewCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        [cell.MyHeaderView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",LoginUserInfo.userAvata]] placeholderImage:[UIImage imageNamed:@"headImg.png"]];
        NSLog(@"%@",LoginUserInfo.userAvata);
        cell.lbName.text=LoginUserInfo.userName;
        cell.lbSigner.text=LoginUserInfo.userSign;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else {
    
        MineOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId2];
        if (cell == nil) {
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"MineOtherTableViewCell" owner:self options:nil];
            cell = [array objectAtIndex:0];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell MineInfo:indexPath];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        [self.navigationController pushViewController:[UserInfoViewController new] animated:YES];
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            NSLog(@"进入相册洁面");
            UserPhotoMyViewController*controller=[[UserPhotoMyViewController alloc]init];
            controller.fromUserid=LoginUserInfo.userId;
            [self.navigationController pushViewController:controller animated:YES];
        }
        if (indexPath.row==1) {
            XbiViewController*controller=[[XbiViewController alloc]init];
            [self .navigationController pushViewController:controller animated:YES];
        }
    }
    if (indexPath.section==2) {
 
            if (indexPath.row==0) {
                AttentionViewController*controller=[[AttentionViewController alloc]init];
                controller.fromUserID=LoginUserInfo.userId;
                [self.navigationController pushViewController:controller  animated:YES];
            }
            if (indexPath.row==1) {
                //粉丝
                FansViewController*controller=[[FansViewController alloc]init];
                controller.fromUserID=LoginUserInfo.userId;
                [self.navigationController pushViewController:controller animated:YES];
               
            }
        }
    
    if (indexPath.section==3) {
        SetUpViewController*controller=[[SetUpViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
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
