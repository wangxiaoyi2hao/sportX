//
//  RegisterViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/18.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,weak)IBOutlet UILabel*lbSex;
@property(nonatomic,weak)IBOutlet UIImageView*imageHead;
@property(nonatomic,weak)IBOutlet UITextField*tfName;
@property(nonatomic,weak)IBOutlet UITextField*tfPwd;
@property(nonatomic,copy)NSString*fromPhoneNumber;
@end
