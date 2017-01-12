//
//  SearchCollectionViewCell.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/6/16.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SearchCollectionViewCell.h"

@implementation SearchCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.contentView.backgroundColor=[UIColor lightGrayColor];
        
        
        UIView*putView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.width-1, self.contentView.height-1)];
        putView.backgroundColor=[UIColor whiteColor];
        _lbHotCi=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,  self.contentView.width-1,  self.contentView.height-1)];
        _lbHotCi.textAlignment=NSTextAlignmentCenter;
        _lbHotCi.font=[UIFont systemFontOfSize:12];

        [putView addSubview:_lbHotCi];
        [self.contentView addSubview:putView];
        
    }
    return self;
}

@end
