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
    UIView*_headerView;
    UILabel*lbPh;
    IBOutlet UITextView*_textView;
    IBOutlet UIView*costumerView;
    //头像
     UIImageView*_imageHead;
    //用户姓名
    UILabel*lbName;
    //如果显示一张图片的时候
    UIImageView*_imageOne;
    //详情label
    UILabel*lbDes;
    UIImageView*imageZan;
    //赞label
    UILabel*_labelZan;
    //评论图片
    UIImageView*imagePing;
    //评论label
    UILabel*_labelPing;
    //承载下面的view
    UIView*_bottomView;
    //时间
    UILabel*lbTime;
    

}
@property(nonatomic,assign)int fromTrendID;
@property(nonatomic,assign)int fromGymId;
@end
