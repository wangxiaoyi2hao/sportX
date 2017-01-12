//
//  OnePicLookViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/6/23.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YockPhotoImgView.h"

@interface OnePicLookViewController : UIViewController
{

    IBOutlet YockPhotoImgView*_imagePic;

}
@property(nonatomic,copy)NSString*fromImageUrl;
@end
