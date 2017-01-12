//
//  TakeFriendQuanViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/23.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeFriendQuanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
{
    IBOutlet UITableView*_tableView;
    IBOutlet UITextView*_textView;
    

}
@property (weak, nonatomic) IBOutlet UIView *imageBaseView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (weak, nonatomic) IBOutlet UIImageView *imageView6;
@property (weak, nonatomic) IBOutlet UIImageView *imageView7;
@property (weak, nonatomic) IBOutlet UIImageView *imageView8;
@property (weak, nonatomic) IBOutlet UIImageView *imageView9;
@property (strong, nonatomic)  UIImageView *imageViewAdd;
@property(nonatomic,strong)NSMutableArray*assets;
@end
