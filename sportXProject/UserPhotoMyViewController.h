//
//  UserPhotoMyViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/6/12.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserPhotoMyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UITableView*_tableView;
}
@property(nonatomic,assign)int fromUserid;
@end
