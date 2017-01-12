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
#import "PersonDesViewController.h"
#import "OnePicLookViewController.h"
#import "LookUpPicViewController.h"
static NSString*iden=@"InviteImageViewCell";
extern UserInfo*LoginUserInfo;
@interface DiscussViewController ()
{

    UICollectionView*_collectionView;
    NSMutableArray*collectionViewArray;;
    NSMutableArray*commmArray;
    UILabel*lbPL;
    UITextView*text1;
    //这个直接定义成事例好了东西比较多
    
    Response12003*response12003;
    //是否回复他人
    int  isCommtThey;
    //textview ph
    NSString*txPh;
    //评论的时候要传入的userid
    int toUserID;
    //评论的时候要穿入的username 不一定传
    NSString*toUserName;
    //评论的时候要穿入的commentid
    int toCommenId;
    //分页
    int pageCount;
}
@end

@implementation DiscussViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       //
        [self loaquestCommDown];
    }];
    [self loadHeaderView];
    //网络请求
    [self loadRequest];
    _textView.hidden=YES;
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth-3, 44)];
    customView.backgroundColor = [UIColor whiteColor];
    text1=[[UITextView alloc]initWithFrame:CGRectMake(0, 1, KScreenWidth*0.848, 41)];
    text1.font=[UIFont systemFontOfSize:15];
    text1.delegate=self;
    [customView addSubview:text1];
    UILabel*lbBlack=[[UILabel alloc]initWithFrame:CGRectMake(0, 42, KScreenWidth*0.8533, 2)];
    lbBlack.backgroundColor=[UIColor blackColor];
    [customView addSubview:lbBlack];
    lbPL=[[UILabel alloc]initWithFrame:CGRectMake(4, 10, KScreenWidth*0.533333, 21)];
    lbPL.font=[UIFont systemFontOfSize:12];
    lbPL.textColor=[UIColor lightGrayColor];
    lbPL.text=@"请填入评论";
    [customView addSubview:lbPL];
    UIButton*buttonSend=[[UIButton alloc]initWithFrame:CGRectMake(KScreenWidth*0.872, 10, 46, 30)];
    [buttonSend setBackgroundColor:[UIColor blackColor]];
    [buttonSend setTitle:@"发送" forState:UIControlStateNormal];
    [buttonSend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonSend.titleLabel.font=[UIFont systemFontOfSize:15];
    [buttonSend addTarget:self action:@selector(sendCommon) forControlEvents:UIControlEventTouchUpInside];
    [customView addSubview:buttonSend];
    _textView.inputAccessoryView = customView;
    UITapGestureRecognizer *tapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickImage:)];
    [_imageHead addGestureRecognizer:tapImage];
    [self _addMemberList];
    [self loadNav];
}

-(void)viewWillAppear:(BOOL)animated{

    [self loaquestComm];

}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    text1.text=@"";
    [_textView resignFirstResponder];
    [text1 resignFirstResponder];
}
#pragma mark 获取评论列表
-(void)loaquestComm{
    pageCount=0;
    commmArray=nil;
    commmArray=[NSMutableArray array];
    NSString*str=[NSString stringWithFormat:@"%@/trend/getTrendComment",REQUESTURL];
    //创建参数字符串对象
    Request12004*request12004=[[Request12004 alloc]init];
    request12004.common.userid=LoginUserInfo.userId;
    request12004.common.userkey=LoginUserInfo.userKey;
    request12004.common.cmdid=12002;
    request12004.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request12004.common.platform=2;
    request12004.common.version=sportVersion;
    request12004.params.trendId=_fromTrendID;
    request12004.params.pageIndex=pageCount;
    NSData*data2=[request12004 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response12004*response12004=[Response12004 parseFromData:dataString error:nil];
        if (response12004.common.code==0) {
            for (int i=0; i<response12004.data_p.commentsArray.count; i++) {
                Comment*commentRec=[response12004.data_p.commentsArray objectAtIndex:i];
                [commmArray addObject:commentRec];
            }
            [[Tostal sharTostal]hiddenView];
            [_tableview.mj_header endRefreshing];
            [_tableview reloadData];
        }else{
            [[Tostal sharTostal]tostalMesg:@"网络错误" tostalTime:1];
            [[Tostal sharTostal]hiddenView];
            [_tableview.mj_header endRefreshing];
        }
    }];



}
#pragma mark 获取评论列表
-(void)loaquestCommDown{
   
    pageCount++;
    NSString*str=[NSString stringWithFormat:@"%@/trend/getTrendComment",REQUESTURL];
    //创建参数字符串对象
    Request12004*request12004=[[Request12004 alloc]init];
    request12004.common.userid=LoginUserInfo.userId;
    request12004.common.userkey=LoginUserInfo.userKey;
    request12004.common.cmdid=12002;
    request12004.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request12004.common.platform=2;
    request12004.common.version=sportVersion;
    request12004.params.trendId=_fromTrendID;
    request12004.params.pageIndex=pageCount;
    NSData*data2=[request12004 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response12004*response12004=[Response12004 parseFromData:dataString error:nil];
        if (response12004.common.code==0) {
            for (int i=0; i<response12004.data_p.commentsArray.count; i++) {
                Comment*commentRec=[response12004.data_p.commentsArray objectAtIndex:i];
                [commmArray addObject:commentRec];
            }
            
            
            if (response12004.data_p.maxCountPerPage>response12004.data_p.commentsArray.count) {
                [_tableview.mj_footer endRefreshingWithNoMoreData];
            }else{
                
                 [_tableview.mj_header endRefreshing];
            }
            
         
            [_tableview reloadData];
        }else{
    
            [[Tostal sharTostal]tostalMesg:@"网络错误" tostalTime:1];
            [[Tostal sharTostal]hiddenView];
            [_tableview.mj_header endRefreshing];
        }
    }];
    
    
    
}
#pragma mark 获取动态详情
-(void)loadRequest{
   
    collectionViewArray=nil;
      collectionViewArray=[NSMutableArray array];
    [[Tostal sharTostal]showLoadingView:@"正在加载" view:self.view];
    NSString*str=[NSString stringWithFormat:@"%@/trend/getTrendById",REQUESTURL];
    //创建参数字符串对象
    Request12003*request12003=[[Request12003 alloc]init];
    request12003.common.userid=LoginUserInfo.userId;
    request12003.common.userkey=LoginUserInfo.userKey;
    request12003.common.cmdid=12003;
    request12003.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request12003.common.platform=2;
    request12003.common.version=sportVersion;
    request12003.params.trendId=_fromTrendID;
    NSData*data2=[request12003 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
       response12003=[Response12003 parseFromData:dataString error:nil];
        if (response12003.common.code==0) {
            for (int i=0; i<response12003.data_p.trend.imgsArray.count; i++) {
                NSString*imageUrl=[response12003.data_p.trend.imgsArray objectAtIndex:i];
                [collectionViewArray addObject:imageUrl];
            }
            NSLog(@"%@",response12003.data_p.trend.imgsArray);
            //赞的图片
            if (response12003.data_p.trend.isLiked==YES) {
                [imageZan setImage:[UIImage imageNamed:@"liked.png"]];
            }else{
            
                [imageZan setImage:[UIImage imageNamed:@"like.png"]];
            }
            //名字。
            lbName.text=response12003.data_p.trend.briefUser.userName;
            //图片头像
            [_imageHead sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",response12003.data_p.trend.briefUser.userAvatar]] placeholderImage:[UIImage imageNamed:@""]];
             UIFont *font=[UIFont systemFontOfSize:14];
             CGRect rect=[response12003.data_p.trend.content boundingRectWithSize:CGSizeMake(277, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
            if (response12003.data_p.trend.imgsArray.count==1) {
                CGSize sizefromUrl=  [CheckImage downloadImageSizeWithURL:[response12003.data_p.trend.imgsArray objectAtIndex:0]];
                NSLog(@"%@",NSStringFromCGSize(sizefromUrl));
                _imageOne.hidden=NO;
                _collectionView.hidden=YES;
                 [lbDes setFrame:CGRectMake(73, KScreenWidth*0.104, KScreenWidth*0.76533, rect.size.height)];
                //详情label
                lbDes.text=response12003.data_p.trend.content;
                [_imageOne sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[response12003.data_p.trend.imgsArray objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@""]];
                [_imageOne setFrame:CGRectMake(73, rect.size.height+lbDes.frame.origin.y+5, sizefromUrl.width/6, sizefromUrl.height/6)];
                [_bottomView setFrame:CGRectMake(0, rect.size.height+lbDes.frame.origin.y+5+sizefromUrl.height/6, KScreenWidth, KScreenWidth*(54/KScreenWidth))];
                [_headerView setFrame:CGRectMake(0, 0, KScreenWidth, lbDes.frame.origin.y+5+_bottomView.frame.origin.y+_imageOne.frame.origin.y/10)];
            }else{
                if (response12003.data_p.trend.imgsArray.count>1&&response12003.data_p.trend.imgsArray.count<=6) {
                    if (response12003.data_p.trend.imgsArray.count>=3&&response12003.data_p.trend.imgsArray.count<=6) {
                        _collectionView.hidden=NO;
                        _imageOne.hidden=YES;
                        [lbDes setFrame:CGRectMake(70, 39, 287, rect.size.height)];
                        //详情label
                        lbDes.text=response12003.data_p.trend.content;
                        [_collectionView setFrame:CGRectMake(73, rect.size.height+lbDes.frame.origin.y+5, KScreenWidth-125, 223)];
                        [_bottomView setFrame:CGRectMake(0, rect.size.height+lbDes.frame.origin.y+5+_collectionView.frame.origin.y+60+50, KScreenWidth, 54)];
                        [_headerView setFrame:CGRectMake(0, 0, KScreenWidth, rect.size.height+lbDes.frame.origin.y+5+_bottomView.frame.origin.y+_collectionView.frame.origin.y)];
                        [_collectionView reloadData];
                    }else{
                        _collectionView.hidden=NO;
                        _imageOne.hidden=YES;
                       [lbDes setFrame:CGRectMake(73, KScreenWidth*0.104, KScreenWidth*0.76533, rect.size.height)];;
                        //详情label
                        lbDes.text=response12003.data_p.trend.content;
                        [_collectionView setFrame:CGRectMake(73, rect.size.height+lbDes.frame.origin.y+5, KScreenWidth-125, 223)];
                        [_bottomView setFrame:CGRectMake(0, rect.size.height+lbDes.frame.origin.y+5+_collectionView.frame.origin.y+60, KScreenWidth, 54)];
                        [_headerView setFrame:CGRectMake(0, 0, KScreenWidth, rect.size.height+lbDes.frame.origin.y+5+_bottomView.frame.origin.y+_collectionView.frame.origin.y)];
                        [_collectionView reloadData];
                    }
                }else{
                    if (response12003.data_p.trend.imgsArray.count>6) {
                        _collectionView.hidden=NO;
                        _imageOne.hidden=YES;
                       [lbDes setFrame:CGRectMake(73, KScreenWidth*0.104, KScreenWidth*0.76533, rect.size.height)];;
                        //详情label
                        lbDes.text=response12003.data_p.trend.content;
                        [_collectionView setFrame:CGRectMake(73, rect.size.height+lbDes.frame.origin.y+5, KScreenWidth-125, KScreenHeight-KScreenWidth)];
                        [_bottomView setFrame:CGRectMake(0, rect.size.height+lbDes.frame.origin.y+5+_collectionView.frame.origin.y+60+100+20+15, KScreenWidth, 54)];
                        [_headerView setFrame:CGRectMake(0, 0, KScreenWidth, rect.size.height+lbDes.frame.origin.y+5+_bottomView.frame.origin.y+_collectionView.frame.origin.y-30-20)];
                        [_collectionView reloadData];
                        
                    }else{
                        _collectionView.hidden=YES;
                        _imageOne.hidden=YES;
                        [lbDes setFrame:CGRectMake(73, KScreenWidth*0.104, KScreenWidth*0.76533, rect.size.height)];;
                        //详情label
                        lbDes.text=response12003.data_p.trend.content;
                        [_bottomView setFrame:CGRectMake(0, rect.size.height+lbDes.frame.origin.y+5, KScreenWidth, KScreenWidth*(54/KScreenWidth))];
                        [_headerView setFrame:CGRectMake(0, 0, KScreenWidth, rect.size.height+lbDes.frame.origin.y+5+_bottomView.frame.origin.y)];
                    }
                }
            }
            _labelPing.text=[NSString stringWithFormat:@"%i",response12003.data_p.trend.commentCount];
            _labelZan.text=[NSString stringWithFormat:@"%i",response12003.data_p.trend.likeCount];
            _tableview.tableHeaderView=_headerView;
            [[Tostal sharTostal]hiddenView];
        }
    }];



}
-(void)loadHeaderView{
 //页眉view
    _headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenWidth, 430)];
    _headerView.backgroundColor=[UIColor whiteColor];
    //头像 先把坐标写死 适配的时候再说
    _imageHead=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*(12/KScreenWidth), KScreenWidth*(10/KScreenWidth), 50, 50)];
    [_headerView addSubview:_imageHead];
 
    _imageHead.tag = 101;
    _imageHead.userInteractionEnabled = YES;
    lbName=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(70/KScreenWidth), KScreenWidth*(10/KScreenWidth), KScreenWidth*(258/KScreenWidth), KScreenWidth*(21/KScreenWidth))];
    lbName.font=[UIFont systemFontOfSize:14];
    lbName.textColor=[UIColor darkGrayColor];
    [_headerView addSubview:lbName];
    lbDes=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(70/KScreenWidth), KScreenWidth*(39/KScreenWidth), KScreenWidth*(287/KScreenWidth), KScreenWidth*(143/KScreenWidth))];
    lbDes.font=[UIFont systemFontOfSize:14];
    lbDes.textColor=[UIColor blackColor];
    lbDes.numberOfLines=0;
    [_headerView addSubview:lbDes];
    
    _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, KScreenWidth*(375/KScreenWidth), KScreenWidth, KScreenWidth*(54/KScreenWidth))];
    [_headerView addSubview:_bottomView];
    lbTime=[[UILabel alloc]initWithFrame:CGRectMake(70, 0, 130, 21)];
    
    lbTime.font=[UIFont systemFontOfSize:13];
    lbTime.textColor=[UIColor lightGrayColor];
    lbTime.text=@"1分钟";
    [_bottomView addSubview:lbTime];
    
    if (KScreenWidth<375) {
    imageZan=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*(180/KScreenWidth), KScreenWidth*(28/KScreenWidth), KScreenWidth*(18/KScreenWidth), KScreenWidth*(18/KScreenWidth))];
        
        _labelZan=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(215/KScreenWidth), KScreenWidth*(28/KScreenWidth), KScreenWidth*(40/KScreenWidth), KScreenWidth*(21/KScreenWidth))];
          imagePing=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*(247/KScreenWidth) , KScreenWidth*(30/KScreenWidth), KScreenWidth*(18/KScreenWidth), KScreenWidth*(18/KScreenWidth))];
         _labelPing=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(285/KScreenWidth), KScreenWidth*(28/KScreenWidth), KScreenWidth*(40/KScreenWidth), KScreenWidth*(21/KScreenWidth))];
    }else{
     imageZan=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*(216/KScreenWidth), KScreenWidth*(28/KScreenWidth), KScreenWidth*(18/KScreenWidth), KScreenWidth*(18/KScreenWidth))];
        
        _labelZan=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(243/KScreenWidth), KScreenWidth*(28/KScreenWidth), KScreenWidth*(40/KScreenWidth), KScreenWidth*(21/KScreenWidth))];
          imagePing=[[UIImageView alloc]initWithFrame:CGRectMake(KScreenWidth*(287/KScreenWidth) , KScreenWidth*(29/KScreenWidth), KScreenWidth*(18/KScreenWidth), KScreenWidth*(18/KScreenWidth))];
           _labelPing=[[UILabel alloc]initWithFrame:CGRectMake(KScreenWidth*(322/KScreenWidth), KScreenWidth*(28/KScreenWidth), KScreenWidth*(40/KScreenWidth), KScreenWidth*(21/KScreenWidth))];
    }
   
    [imageZan setImage:[UIImage imageNamed:@"like.png"]];
    [_bottomView addSubview:imageZan];
    UITapGestureRecognizer *tapAddImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zanClick)];
    [imageZan addGestureRecognizer:tapAddImage];
     imageZan.userInteractionEnabled = YES;

    [_labelZan setFont:[UIFont systemFontOfSize:14]];
    
    [_bottomView addSubview:_labelZan];
  
    [imagePing setImage:[UIImage imageNamed:@"message"]];
    [_bottomView addSubview:imagePing];
    UITapGestureRecognizer *tapPingImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pingClcik)];
    [imagePing addGestureRecognizer:tapPingImage];
    imagePing.userInteractionEnabled = YES;

 
    [_labelPing setFont:[UIFont systemFontOfSize:14]];
    
    [_bottomView addSubview:_labelPing];

    
     _tableview.tableHeaderView=_headerView;
    
}
-(void)clickOnBigImage:(UITapGestureRecognizer *)sender{
    
    
    LookUpPicViewController*controller=[[LookUpPicViewController alloc]init];
    controller.imageArray=response12003.data_p.trend.imgsArray;
    [self.navigationController presentViewController:controller animated:YES completion:nil];


}
//看用户详情
- (void)onclickImage:(UITapGestureRecognizer *)sender{

    PersonDesViewController*controller=[[PersonDesViewController alloc]init];
    controller.fromUserId=response12003.data_p.trend.briefUser.userId;
    [self.navigationController pushViewController:controller animated:YES];

}
-(void)zanClick{
    if (response12003.data_p.trend.isLiked==YES) {
        [imageZan setImage:[UIImage imageNamed:@"like.png"]];
        [GiveZan dontSendsend:response12003.data_p.trend.id_p];
        response12003.data_p.trend.isLiked=NO;
        response12003.data_p.trend.likeCount--;
         _labelZan.text=[NSString stringWithFormat:@"%i",response12003.data_p.trend.likeCount];
    }else{
        [imageZan setImage:[UIImage imageNamed:@"liked.png"]];
        [GiveZan sendsend:response12003.data_p.trend.id_p];
        response12003.data_p.trend.isLiked=YES;
        response12003.data_p.trend.likeCount++;
        _labelZan.text=[NSString stringWithFormat:@"%i",response12003.data_p.trend.likeCount];
    
    }


}
-(void)pingClcik{
    isCommtThey=1;
    lbPL.text = @"请填写评论";
    [_textView becomeFirstResponder];
    [text1 becomeFirstResponder];

}
//我不想用拼音的但是我的脑子不行我先用一下不好意思
-(void)fuzhiKongjian{



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
    
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        if (isCommtThey==1) {
             lbPL.text = @"请填写评论";
        }else{
        
             lbPL.text=txPh;
        }
       
        
    }else{
        lbPL.text = @"";
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
    _collectionView.hidden=YES;
    
    
    _imageOne=[[UIImageView alloc]initWithFrame:CGRectMake(70, 172, KScreenWidth-125, KScreenHeight-KScreenWidth)];
    [_headerView addSubview:_imageOne];
    _imageOne.userInteractionEnabled=YES;
//    _imageOne.hidden=YES;
    UITapGestureRecognizer *tapImage1= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOnBigImage:)];
    [_imageOne addGestureRecognizer:tapImage1];
    
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return collectionViewArray.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    InviteImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
    NSString*imageName=[collectionViewArray objectAtIndex:indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageName]] placeholderImage:[UIImage imageNamed:@"defaultpic.png"]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LookUpPicViewController*controller=[[LookUpPicViewController alloc]init];
    controller.imageArray=collectionViewArray;
    controller.index=(int)indexPath.row;
    [self.navigationController presentViewController:controller animated:YES completion:nil];


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     Comment*commentV=[commmArray objectAtIndex:indexPath.row];
    if (![[HelperUtil isDefault:commentV.toUserName]isEqualToString:@"未填写"]) {
        UIFont *font=[UIFont systemFontOfSize:12];
        CGRect rect=[[NSString stringWithFormat:@"回复 %@: %@",commentV.commentContent,commentV.toUserName] boundingRectWithSize:CGSizeMake(277, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
        float height=rect.size.height+73;
        NSLog(@"%.2f",rect.size.height);
        
        return height;
    }else{
        UIFont *font=[UIFont systemFontOfSize:12];
        CGRect rect=[commentV.commentContent boundingRectWithSize:CGSizeMake(277, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        
        float height=rect.size.height+73;
        NSLog(@"%.2f",rect.size.height);
        
        return height;
    }
  
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return commmArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static   NSString *str=@"cell";
    //使用闲置池
    DiscussTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        NSArray*arry=[[NSBundle mainBundle]loadNibNamed:@"DiscussTableViewCell" owner:self options:nil];
        cell=[arry objectAtIndex:0];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Comment*commentV=[commmArray objectAtIndex:indexPath.row];
    cell.lbName.text=commentV.briefUser.userName;
    [cell.imageHead sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",commentV.briefUser.userAvatar]] placeholderImage:[UIImage imageNamed:@""]];
    [cell.buttonHeadClick addTarget:self action:@selector(tableviewHeadClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.buttonHeadClick.tag=indexPath.row;
    NSLog(@"－－－－－－－－－－－%@",commentV.toUserName);
    //获取评论内容的高度
    if (![[HelperUtil isDefault:commentV.toUserName]isEqualToString:@"未填写"]) {
        cell.lbDes.text=[NSString stringWithFormat:@"回复 %@: %@",commentV.toUserName,commentV.commentContent];
    }else{
    
        cell.lbDes.text=commentV.commentContent;
    }
    UIFont *font=[UIFont systemFontOfSize:12];
    CGRect rect=[cell.lbDes.text boundingRectWithSize:CGSizeMake(277, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    NSLog(@"%@",commentV.commentContent);
    [cell.lbDes setFrame:CGRectMake(KScreenWidth*(55/KScreenWidth), 31, KScreenWidth*(312/KScreenWidth)-KScreenWidth*(55/KScreenWidth), rect.size.height)];
    [cell.bottomView setFrame:CGRectMake(2, rect.size.height+cell.lbDes.frame.origin.y+5, KScreenWidth, 28)];
    cell.lbRoom.text=commentV.gymName;
    cell.lbTime.text=[self intervalSinceNow:[self changeTime:commentV.createTime/1000]];
    return  cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     Comment*commentV=[commmArray objectAtIndex:indexPath.row];
    toUserID=commentV.briefUser.userId;
    NSLog(@"%i",toUserID);
    toUserName=commentV.briefUser.userName;
    toCommenId=commentV.commentId;
   txPh=[NSString stringWithFormat:@"回复 %@",commentV.briefUser.userName];
    lbPL.text=[NSString stringWithFormat:@"回复 %@",commentV.briefUser.userName];
    isCommtThey=0;
    [_textView becomeFirstResponder];
    [text1 becomeFirstResponder];
   
    
}
-(void)tableviewHeadClick:(UIButton*)sender{

 Comment*commentV=[commmArray objectAtIndex:sender.tag];
    PersonDesViewController*controller=[[PersonDesViewController alloc]init];
    controller.fromUserId=commentV.briefUser.userId;
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark 从当前时间计算时间
//时间戳转字符串
-(NSString*)changeTime:(NSTimeInterval)timemInterval{
    
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:timemInterval];
    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}
//计算时间－－从当前时间计算时间
- (NSString *)intervalSinceNow: (NSString *) theDate
{
    
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *d=[date dateFromString:theDate];
    
    NSTimeInterval late=[d timeIntervalSince1970]*1;
    
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-late;
    
    if (cha/3600<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        
    }
    
    return timeString;
}

//去回复别人的评论
-(void)loaquestToGoComm{
    NSString*str=[NSString stringWithFormat:@"%@/trend/commentTrend",REQUESTURL];
    //创建参数字符串对象
    Request12006*request12006=[[Request12006 alloc]init];
    request12006.common.userid=LoginUserInfo.userId;
    request12006.common.userkey=LoginUserInfo.userKey;
    request12006.common.cmdid=12006;
    request12006.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request12006.common.platform=2;
    request12006.common.version=sportVersion;
    request12006.params.trendId=_fromTrendID;
    request12006.params.toCommentId=toCommenId;
    request12006.params.toUserId=toUserID;
    request12006.params.content=text1.text;
    request12006.params.gymId=_fromGymId;
//    request12006.params.
    NSLog(@"%i",toUserID);
    NSLog(@"%i",toCommenId);
    
    NSLog(@"%@",text1.text);
    NSData*data2=[request12006 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response12006*response12006=[Response12006 parseFromData:dataString error:nil];
        if (response12006.common.code==0) {
            NSLog(@"评论成功");
            text1.text=@"";
            [text1 resignFirstResponder];
            [_textView resignFirstResponder];
            //让用户看到评论
            [self loaquestComm];
            
        }else{
            [[Tostal sharTostal]tostalMesg:@"网络错误" tostalTime:1];
            [[Tostal sharTostal]hiddenView];
            [_tableview.mj_header endRefreshing];
            
        }
    }];
}
//发送评论
-(void)sendCommon{
    if (![text1.text isEqualToString:@""]) {
        [self loaquestToGoComm];
        [text1 resignFirstResponder];
        [_textView resignFirstResponder];
    }else{
        [[Tostal sharTostal]tostalMesg:@"请输入评论" tostalTime:1];
    }
  
    
    
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
