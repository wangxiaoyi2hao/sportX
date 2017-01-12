//
//  AppDelegate.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/4/25.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate,CLLocationManagerDelegate>
{

  

}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
//适配需要东西
@property (assign,nonatomic)float autoSizeScaleX;
@property (assign,nonatomic)float autoSizeScaleY;
+ (void)matchAllScreenWithView:(UIView *)allView;

@end

