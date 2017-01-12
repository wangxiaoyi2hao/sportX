//
//  SportXViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/4/25.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportXViewController : UIViewController<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
{

    IBOutlet UIScrollView*_scrollview;
    IBOutlet UITableView*_tableView;
    IBOutlet UIView*_headerView;
    IBOutlet UIImageView*_tabImageMain;
    IBOutlet UIView*putCollView;
    //推荐健身房内容
    IBOutlet UIImageView*_imageGymAva;
    IBOutlet UILabel*lbGymName;
    IBOutlet UILabel*lbGymPerCount;
    IBOutlet UILabel*lbGymSheBei;
    IBOutlet UILabel*lbTrendCount;

    

}
@property(nonatomic,copy)NSMutableData*receiveData;
@end
