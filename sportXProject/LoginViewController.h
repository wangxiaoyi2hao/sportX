//
//  LoginViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/18.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITabBarControllerDelegate>
@property(nonatomic,weak)IBOutlet UITextField*_tfPoneNum;
@property(nonatomic,weak)IBOutlet UITextField*_tfPassWord;
@property(nonatomic,assign)int fromWhere;
@end
