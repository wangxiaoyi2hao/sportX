//
//  MineHeadTableViewCell.h
//  sportXProject
//
//  Created by Yao.zhou on 16/5/12.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineHeadTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIImageView *MyHeaderView;
@property (nonatomic,weak) IBOutlet UILabel *lbName;
@property (nonatomic,weak) IBOutlet UILabel *lbSigner;

@end
