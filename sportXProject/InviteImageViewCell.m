//
//  InviteImageViewCell.m
//  Weclub
//
//  Created by chen on 15/12/16.
//  Copyright © 2015年 BIT. All rights reserved.
//

#import "InviteImageViewCell.h"

@implementation InviteImageViewCell
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imgView];
    }
    return self;
}


- (void)setImgView:(UIImageView *)imgView{
    _imgView = imgView;
}

@end
