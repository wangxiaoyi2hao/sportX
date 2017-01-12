//
//  SearchSportViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/22.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchSportViewController : UIViewController<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView*_tableView;
    IBOutlet UIView*_headerView;
    IBOutlet UIView*_footerView;
    IBOutlet UIView*_putCoView;


}
@end
