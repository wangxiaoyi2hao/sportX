//
//  UserInfoViewController.h
//  sportXProject
//
//  Created by Yao.zhou on 16/5/16.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) IBOutlet UITableView *myTableView;

@end
