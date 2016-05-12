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

}
@end
