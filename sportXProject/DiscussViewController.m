//
//  DiscussViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/16.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "DiscussViewController.h"
#import "InviteImageViewCell.h"
#import "DiscussTableViewCell.h"
static NSString*iden=@"InviteImageViewCell";
@interface DiscussViewController ()
{

    UICollectionView*_collectionView;
    NSMutableArray*nearFriendsArray;
    UILabel*lbPL;
    UITextView*text1;

}
@end

@implementation DiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.tableHeaderView=_headerView;
    nearFriendsArray=[NSMutableArray array];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
    [nearFriendsArray addObject:@"0006.png"];
  
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 372, 44)];
    customView.backgroundColor = [UIColor whiteColor];
   text1=[[UITextView alloc]initWithFrame:CGRectMake(0, 1, 318, 41)];
    text1.font=[UIFont systemFontOfSize:15];
    text1.delegate=self;
    [customView addSubview:text1];
    UILabel*lbBlack=[[UILabel alloc]initWithFrame:CGRectMake(0, 42, 320, 2)];
    lbBlack.backgroundColor=[UIColor blackColor];
    [customView addSubview:lbBlack];
    lbPL=[[UILabel alloc]initWithFrame:CGRectMake(4, 10, 86, 21)];
    lbPL.textColor=[UIColor lightGrayColor];
    lbPL.text=@"请填入评论";
    [customView addSubview:lbPL];
    UIButton*buttonSend=[[UIButton alloc]initWithFrame:CGRectMake(327, 10, 46, 30)];
    [buttonSend setBackgroundColor:[UIColor colorWithRed:19/255.0 green:183/255.0 blue:156/255.0 alpha:1]];
    [buttonSend setTitle:@"发送" forState:UIControlStateNormal];
    [buttonSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonSend.titleLabel.font=[UIFont systemFontOfSize:15];
    [customView addSubview:buttonSend];
    
    _textView.inputAccessoryView = customView;
   
    [self _addMemberList];
    [self loadNav];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    [_textView resignFirstResponder];
    [text1 resignFirstResponder];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    


    return YES;

}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView isEqual:_textView]) {
        [text1 becomeFirstResponder];
    }else{
        
        
        
    }
    

}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    _textView.text=text1.text;
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
   _textView.text=text1.text;
    if (textView.text.length == 0) {
        lbPL.text = @"请填写评论";
          lbPh.text = @"请填写评论";
    }else{
        lbPL.text = @"";
        lbPh.text = @"";
    }
}
-(void)loadNav{
    self.title=@"动态详情";
    UIButton * leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:[UIImage imageNamed:@"all_back.png"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [leftButton addTarget:self action:@selector(leftClickButTON) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    
}
//左侧按钮点击事件
-(void)leftClickButTON{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark- 设置成员列表
- (void)_addMemberList{
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
    flowLayOut.itemSize = CGSizeMake((KScreenWidth-130)/3.0,(KScreenWidth-130)/3.0);
    
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 1;
    flowLayOut.minimumInteritemSpacing = 2;

   CGRect cgRectCollectionPhoto = CGRectMake(70, 172, KScreenWidth-125, KScreenHeight-KScreenWidth);
#pragma mark- 设置相册布局
    
    _collectionView = [[UICollectionView alloc] initWithFrame:cgRectCollectionPhoto collectionViewLayout:flowLayOut];
    _collectionView.tag=1;
    _collectionView.backgroundColor = [UIColor clearColor];
    //设置代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //    //禁止滚动
    //    _collectionView.scrollEnabled = NO;
    //注册单元格
    [_collectionView registerClass:[InviteImageViewCell class] forCellWithReuseIdentifier:iden];
    [_headerView addSubview:_collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return nearFriendsArray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InviteImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    NSString*imageName=[nearFriendsArray objectAtIndex:indexPath.row];
    [cell.imgView setImage:[UIImage imageNamed:imageName]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 119;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static   NSString *str=@"cell";
    //使用闲置池
    DiscussTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        NSArray*arry=[[NSBundle mainBundle]loadNibNamed:@"DiscussTableViewCell" owner:self options:nil];
        cell=[arry objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return  cell;




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
