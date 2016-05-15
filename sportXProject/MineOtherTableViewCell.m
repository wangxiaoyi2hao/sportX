//
//  MineOtherTableViewCell.m
//  sportXProject
//
//  Created by Yao.zhou on 16/5/12.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "MineOtherTableViewCell.h"

@implementation MineOtherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)MineInfo:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [_MineImageView setImage:[UIImage imageNamed:@"photo.png"]];
            _MineLable.text = @"相册";
        }
        if (indexPath.row == 1) {
            [_MineImageView setImage:[UIImage imageNamed:@"fensi.png"]];
            _MineLable.text = @"X币";
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [_MineImageView setImage:[UIImage imageNamed:@"guanzhu.png"]];
            _MineLable.text = @"关注";
        }
        if (indexPath.row == 1) {
            [_MineImageView setImage:[UIImage imageNamed:@"fensi.png"]];
            _MineLable.text = @"粉丝";
        }
    }
    if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            [_MineImageView setImage:[UIImage imageNamed:@"setting.png"]];
            _MineLable.text = @"设置";
        }
       
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
