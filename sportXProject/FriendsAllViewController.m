//
//  FriendsAllViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/13.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "FriendsAllViewController.h"
#import "MemberCollectionCell.h"
static NSString *iden = @"MemberCollectionCell";
@interface FriendsAllViewController ()
{

    UICollectionView*_collectionView;

}
@end

@implementation FriendsAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{

 self.title=@"附近的好友";
    [self loadCollection ];
    [self loadNav];

}
-(void)loadNav{
    
    UIButton * leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:[UIImage imageNamed:@"all_back.png"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [leftButton addTarget:self action:@selector(leftClickButTON) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{


    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    MemberCollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
//    ChatUser*collectchat=[clubManArray objectAtIndex:indexPath.row];
//    if (collectchat.signup==1) {
//        cell.imageViewQian.hidden=NO;
//    }else{
//        cell.imageViewQian.hidden=YES;
//    }
//    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",collectchat.avatar]] placeholderImage:[UIImage imageNamed:@"default"]];
//    [cell.imageViewQian setImage:[UIImage imageNamed:@"0006.png"]];
    [cell.imgView setImage:[UIImage imageNamed:@"0006.png"]];
    cell.nameLabel.text=@"sportX";
    cell.button.hidden=YES;
    return cell;

}
//左侧按钮点击事件
-(void)leftClickButTON{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)loadCollection{

    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
    flowLayOut.itemSize = CGSizeMake(70,80);
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 10;
    flowLayOut.minimumInteritemSpacing = 10;
#pragma mark- 设置相册布局
    CGRect cgRectCollectionPhoto = CGRectMake(0, 37, KScreenWidth, KScreenHeight-108);
    _collectionView = [[UICollectionView alloc] initWithFrame:cgRectCollectionPhoto collectionViewLayout:flowLayOut];
    _collectionView.tag=1;
    _collectionView.backgroundColor = [UIColor clearColor];
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //注册单元格
    [_collectionView registerClass:[MemberCollectionCell class] forCellWithReuseIdentifier:iden];
    [self.view addSubview:_collectionView];

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
