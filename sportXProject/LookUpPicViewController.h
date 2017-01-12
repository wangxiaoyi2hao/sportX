//
//  LookUpPicViewController.h
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/15.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LookUpPicViewController : UIViewController
{

 IBOutlet UIScrollView*_scrollView;
    IBOutlet UIPageControl *_pageControl;

}
@property (nonatomic,assign)int index;
@property(nonatomic,strong)NSMutableArray*imageArray;
@end
