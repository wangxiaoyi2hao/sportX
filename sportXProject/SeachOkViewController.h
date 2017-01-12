//
//  SeachOkViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/6/20.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeachOkViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(nonatomic,copy)NSString*fromSeachKey;
@end
    