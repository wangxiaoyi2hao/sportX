//
//  SearchSportViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/22.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SearchSportViewController.h"

@interface SearchSportViewController ()
{

    UISearchBar*_searchBar;

}
@end

@implementation SearchSportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark- 设置导航栏
- (void)setNavigationBar{
    
    [self.tabBarController.tabBar setBarTintColor:[UIColor blackColor]];
    UIView * navigationTitleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 70)];
    navigationTitleView.backgroundColor = [UIColor colorWithRed:88/255.0 green:79/255.0 blue:96/255.0 alpha:1];
    [self.view addSubview:navigationTitleView];
    //添加搜索框
    _searchBar =[[UISearchBar alloc]initWithFrame:CGRectMake(8, 20, KScreenWidth-60, 0)];
    _searchBar.barTintColor=[UIColor clearColor];
    [_searchBar setBackgroundImage:[UIImage imageNamed:@"search_bg.png"]];
    [_searchBar setScopeBarBackgroundImage:[UIImage imageNamed:@"search_bg.png"]];
    [_searchBar setPlaceholder:@"搜索内容"];
    _searchBar.delegate=self;
    [navigationTitleView addSubview:_searchBar];
    _searchBar.layer.cornerRadius = 15;
    _searchBar.layer.masksToBounds = YES;
    [_searchBar.layer setBorderWidth:8];
    [_searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];  //设置边框为白色
    [_searchBar becomeFirstResponder];
    
    //导航栏取消按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(KScreenWidth-55, 20+(44-25)/2.0, 50, 25);
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setTitle:@"取消" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [navigationTitleView addSubview:rightButton];
}
-(void)cancelButtonAction{

  [self.navigationController popViewControllerAnimated:NO];

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
