//
//  OnePicLookViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/6/23.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "OnePicLookViewController.h"

@interface OnePicLookViewController ()

@end

@implementation OnePicLookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_imagePic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_fromImageUrl]] placeholderImage:[UIImage imageNamed:@""]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
