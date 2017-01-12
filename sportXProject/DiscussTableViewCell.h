//
//  DiscussTableViewCell.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/16.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscussTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIImageView*imageHead;
@property(nonatomic,weak)IBOutlet UILabel*lbName;
@property(nonatomic,strong)UILabel*lbDes;
@property(nonatomic,strong)UIView*bottomView;
@property(nonatomic,strong)UILabel*lbRoom;
@property(nonatomic,strong)UILabel*lbTime;
@property(nonatomic,strong)UILabel*lbLine;
@property(nonatomic,strong) IBOutlet   UIButton*buttonHeadClick;
@end
