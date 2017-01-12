//
//  SportRoomDesViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/11.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportRoomDesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{

    IBOutlet UIView*_headerView;
    IBOutlet UIView*_putCollection1;
    IBOutlet UIView*_putCollection2;
    IBOutlet UITableView*_tableView;
    //页眉上的详情给的赋值
    IBOutlet UILabel*lbName;
    IBOutlet UILabel*lbAddress;
    IBOutlet UILabel*lbThings;
    IBOutlet UILabel*lbPerson;
    IBOutlet UILabel*lbPrice;
    IBOutlet UILabel*lbMessage;
    IBOutlet UIImageView*_imageGymHead;
    
    
    
    
    

}
@property(nonatomic,assign)int fromGymID;
@end
