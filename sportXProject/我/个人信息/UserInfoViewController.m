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
@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        static NSString *cellID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                cell.textLabel.text = @"昵称";
                cell.detailTextLabel.text = @"Jason";
            }
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.textLabel.text = @"性别";
                cell.detailTextLabel.text = @"男";
            }
            if (indexPath.row == 1) {
                cell.textLabel.text = @"个性签名";
                cell.detailTextLabel.text = @"l你咋不上天呢？";
            }
        }
        
        return cell;
    }

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
