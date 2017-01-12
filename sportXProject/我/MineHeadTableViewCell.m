//
//  MineHeadTableViewCell.m
//  sportXProject
//
//  Created by Yao.zhou on 16/5/12.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "MineHeadTableViewCell.h"

@implementation MineHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [AppDelegate matchAllScreenWithView:self.contentView];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
