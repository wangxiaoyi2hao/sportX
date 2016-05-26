//
//  MineOtherTableViewCell.h
//  sportXProject
//
//  Created by Yao.zhou on 16/5/12.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineOtherTableViewCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UIImageView *MineImageView;
@property (nonatomic,weak) IBOutlet UILabel *MineLable;
-(void)MineInfo:(NSIndexPath *)indexPath;
@end
