//
//  PersonDesViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/14.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonDesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{

    IBOutlet UIView*_headerView;
    IBOutlet UITableView*_tableView;
    IBOutlet UILabel*lbName;
    IBOutlet UIImageView*_imageHead;
    IBOutlet UILabel*lbGuanConunt;
    IBOutlet UILabel*lbFenScount;
    IBOutlet UILabel*lbDong;
    IBOutlet UILabel*lbSign;
    IBOutlet UIButton*buttonAtten;
    
    


}
@property(nonatomic,assign)int fromUserId;
@end
