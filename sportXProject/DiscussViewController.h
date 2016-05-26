//
//  DiscussViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/16.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscussViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    IBOutlet UITableView*_tableview;
    IBOutlet UIView*_headerView;
    IBOutlet UILabel*lbPh;
    IBOutlet UITextView*_textView;
    IBOutlet UIView*costumerView;


}
@end
