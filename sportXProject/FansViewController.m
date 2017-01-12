//
//  FansViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/29.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "FansViewController.h"
#import "MemberCollectionCell.h"
#import "PersonDesViewController.h"
static NSString *iden = @"MemberCollectionCell";
extern UserInfo*LoginUserInfo;
@interface FansViewController ()
{

 UICollectionView* _collectionView;
    NSMutableArray*mutArray;
}
@end

@implementation FansViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self loadCollection];
    [self loadNav];
    [self loadRequest];
    // Do any additional setup after loading the view.
}
-(void)loadNav{
    self.title=@"粉丝";
    //左侧按钮
    UIButton* leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"all_back.png"] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    UIBarButtonItem * leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftitem;
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)leftButtonClick{

    [self.navigationController popViewControllerAnimated:YES];
}
//请求关注列表
-(void)loadRequest{
    mutArray=nil;
    mutArray=[NSMutableArray array];
    NSString*str=[NSString stringWithFormat:@"%@/pilot/getUserFensi",REQUESTURL];
    //创建参数字符串对象
    Request10010*request10010=[[Request10010 alloc]init];
    request10010.common.userid=LoginUserInfo.userId;
    request10010.common.userkey=LoginUserInfo.userKey;
    request10010.common.cmdid=10010;
    request10010.common. timestamp=[[NSDate date]timeIntervalSince1970];
    request10010.common.platform=2;
    request10010.common.version=sportVersion;
    request10010.params.userId=_fromUserID;
    NSLog(@"%i",_fromUserID);
    NSData*data2=[request10010 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response10010*response10010=[Response10010 parseFromData:dataString error:nil];
        NSLog(@"%@",response10010.data_p.briefUsersArray);;
        if (response10010.common.code==0) {
            for (int i=0; i<response10010.data_p.briefUsersArray.count; i++) {
                BriefUser*brie=[response10010.data_p.briefUsersArray objectAtIndex:i];
                [mutArray addObject:brie];
            }
            
            [_collectionView reloadData];
        }else{
            
            [[Tostal sharTostal]tostalMesg:response10010.common.message tostalTime:1];
        }
        
        
    }];
    
}

-(void)loadCollection{

    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
    flowLayOut.itemSize = CGSizeMake(70,70);
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 10;
    flowLayOut.minimumInteritemSpacing = 10;
#pragma mark- 设置相册布局
    CGRect cgRectCollectionPhoto = CGRectMake(0, 0, KScreenWidth, KScreenHeight-108);
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return mutArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MemberCollectionCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    BriefUser*atten=[mutArray objectAtIndex: indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",atten.userAvatar]] placeholderImage:[UIImage imageNamed:@"icon_touxiang.png"]];
    cell.nameLabel.text=atten.userName;
    cell.button.hidden=YES;
    cell.button.hidden=YES;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    BriefUser*atten=[mutArray objectAtIndex: indexPath.row];
    PersonDesViewController*controller=[[PersonDesViewController alloc]init];
    controller.fromUserId=atten.userId;
    [self.navigationController pushViewController:controller animated:YES];
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
