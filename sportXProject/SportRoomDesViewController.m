//
//  SportRoomDesViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/11.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "SportRoomDesViewController.h"
#import "SprotRoomTableViewCell.h"
#import "InviteImageViewCell.h"
#import "LookUpPicViewController.h"
#import "DiscussViewController.h"
#import "PersonDesViewController.h"
static NSString *iden = @"InfoCollectionViewCell";
extern UserInfo*LoginUserInfo;
@interface SportRoomDesViewController ()
{

    //页眉上面的collecitonview
    UICollectionView*_collectionView1;
    NSMutableArray*nearFriendsArray;
    UICollectionView*_collectionView2;
    NSMutableArray*imageArray;
    
    //trendArray;
    NSMutableArray*trendArray;
    
    
    
    
    
    
    


}
@end

@implementation SportRoomDesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.title=@"某个健身房";
    [self loadNav];
    UICollectionView *collectionView = [self _addImgView];
    [_putCollection1 addSubview:collectionView];
    _tableView.tableHeaderView=_headerView;
    UICollectionView*collectionView2=[self _addImgView2];
    [_putCollection2 addSubview:collectionView2];
//    [AppDelegate matchAllScreenWithView:self.view];
//    [AppDelegate matchAllScreenWithView:_headerView];
//    [AppDelegate matchAllScreenWithView:_putCollection1];
//    [AppDelegate matchAllScreenWithView:_putCollection2];
    [self requestTopGymDes];
    [self requestTopGymDesTrendArray];
    
#pragma mark 

}
-(void)viewWillAppear:(BOOL)animated{

 self.navigationController.navigationBar.hidden = NO;
}
- (UICollectionView *)_addImgView{
    //    _mArray = [[NSMutableArray alloc] init];
#pragma  mark 这个页面width是怎么掉出来的
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
    //    flowLayOut.itemSize = CGSizeMake((self.changeView1.width-20)/3.0, (self.changeView1.width-20)/3.0);
    flowLayOut.itemSize=CGSizeMake(80, 70);
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 5;
    //设置滑动的方向,默认是垂直滑动
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置头视图的大小
    flowLayOut.headerReferenceSize = CGSizeZero;
    flowLayOut.footerReferenceSize = CGSizeZero;
    
    
    _collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, 375, 70) collectionViewLayout:flowLayOut];
    _collectionView1.backgroundColor = [UIColor clearColor];
    //设置水平滚动条
    _collectionView1.showsHorizontalScrollIndicator=NO;
    //设置代理
    _collectionView1.delegate = self;
    _collectionView1.dataSource = self;
    //注册单元格
    [_collectionView1 registerClass:[InviteImageViewCell class] forCellWithReuseIdentifier:iden];
    //设置头视图的大小
    return _collectionView1;
}
//健身房详情
-(void)requestTopGymDes{
    nearFriendsArray=nil;
    nearFriendsArray=[NSMutableArray array];
    imageArray=nil;
    imageArray=[NSMutableArray array];
    //分页做处理
    NSString*str=[NSString stringWithFormat:@"%@/gym/getGymDetail",REQUESTURL];
    //创建参数字符串对象
    Request13002*request13002=[[Request13002 alloc]init];
    request13002.common.userid=LoginUserInfo.userId;
    request13002.common.userkey=LoginUserInfo.userKey;
    request13002.common.cmdid=13002;
    request13002.common.timestamp=[[NSDate date]timeIntervalSince1970];
    request13002.common.platform=2;
    request13002.common.version=@"1.0.0";
    request13002.params.gymId=_fromGymID;
    NSData*data2=[request13002 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response13002*response13002=[Response13002 parseFromData:dataString error:nil];
        if (response13002.common.code==0) {
            //健身房详情的赋值
            [_imageGymHead sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",response13002.data_p.detailGym.briefGym.gymAvatar]] placeholderImage:[UIImage imageNamed:@""]];
            lbName.text=response13002.data_p.detailGym.briefGym.gymName;
            lbAddress.text=response13002.data_p.detailGym.briefGym.place;
            lbThings.text=response13002.data_p.detailGym.briefGym.eqm;
            lbPerson.text=response13002.data_p.detailGym.courses;
            lbPrice.text=response13002.data_p.detailGym.gymCards;
            lbMessage.text=response13002.data_p.detailGym.gymIntro;
            //场馆图片数组
            for (int i=0; i<response13002.data_p.detailGym.gymCoversArray.count; i++) {
                NSString*imageUrlGym=[response13002.data_p.detailGym.gymCoversArray objectAtIndex:i];
                [imageArray addObject:imageUrlGym];
            }
            //人员列表
            
            for (int i=0; i<response13002.data_p.briefUsersArray.count; i++) {
                BriefUser*brDes=[response13002.data_p.briefUsersArray objectAtIndex:i];
                [nearFriendsArray addObject:brDes];
            }
            [_collectionView1 reloadData];
            [_collectionView2 reloadData];
        }else{
            [[Tostal sharTostal]tostalMesg:response13002.common.message tostalTime:1];
            
        }
    }];
}
//健身房详情
-(void)requestTopGymDesTrendArray{
    trendArray=nil;
    trendArray=[NSMutableArray array];

    //分页做处理
    NSString*str=[NSString stringWithFormat:@"%@/gym/getGymTrend",REQUESTURL];
    //创建参数字符串对象
    Request13004*request13004=[[Request13004 alloc]init];
    request13004.common.userid=LoginUserInfo.userId;
    request13004.common.userkey=LoginUserInfo.userKey;
    request13004.common.cmdid=13004;
    request13004.common.timestamp=[[NSDate date]timeIntervalSince1970];
    request13004.common.platform=2;
    request13004.common.version=@"1.0.0";
    request13004.params.gymId=_fromGymID;
    //需要分页
    NSData*data2=[request13004 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response13004*response13004=[Response13004 parseFromData:dataString error:nil];
        if (response13004.common.code==0) {
            //健身房详情的赋值
         
            //场馆图片数组
            for (int i=0; i<response13004.data_p.trendsArray.count; i++) {
                Trend*tttttt=[response13004.data_p.trendsArray objectAtIndex:i];
                [trendArray addObject:tttttt];
            }
            //人员列表
            [_tableView reloadData];
        }else{
            [[Tostal sharTostal]tostalMesg:response13004.common.message tostalTime:1];
            
        }
    }];
}

- (UICollectionView *)_addImgView2{
    //    _mArray = [[NSMutableArray alloc] init];
#pragma  mark 这个页面width是怎么掉出来的
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的大小
    //    flowLayOut.itemSize = CGSizeMake((self.changeView1.width-20)/3.0, (self.changeView1.width-20)/3.0);
    flowLayOut.itemSize=CGSizeMake(40, 40);
    //设置每行之间的最小空隙
    flowLayOut.minimumLineSpacing = 5;
    //设置滑动的方向,默认是垂直滑动
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置头视图的大小
    flowLayOut.headerReferenceSize = CGSizeZero;
    flowLayOut.footerReferenceSize = CGSizeZero;
    
    
    _collectionView2 = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, 375, 43) collectionViewLayout:flowLayOut];
    _collectionView2.backgroundColor = [UIColor clearColor];
    //设置水平滚动条
    _collectionView2.showsHorizontalScrollIndicator=NO;
    //设置代理
    _collectionView2.delegate = self;
    _collectionView2.dataSource = self;
    //注册单元格
    [_collectionView2 registerClass:[InviteImageViewCell class] forCellWithReuseIdentifier:iden];
    //设置头视图的大小
    return _collectionView2;
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
    if ([collectionView isEqual:_collectionView1]) {
        return imageArray.count;
    }else{
     return  nearFriendsArray.count;
    }


}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if ([collectionView isEqual:_collectionView1]) {
        InviteImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
        NSString*imageName=[imageArray objectAtIndex:indexPath.row];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageName]] placeholderImage:[UIImage imageNamed:@""]];
          return cell;
    }else{
    
        InviteImageViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:iden forIndexPath:indexPath];
        BriefUser*brieMessage=[nearFriendsArray objectAtIndex:indexPath.row];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",brieMessage.userAvatar]] placeholderImage:[UIImage imageNamed:@""]];
          return cell;
    }

   
  

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if ([collectionView isEqual:_collectionView1]) {
        LookUpPicViewController*controller= [[LookUpPicViewController alloc]init];
        controller.imageArray=imageArray;
        controller.index=(int)indexPath.row;
        [self.navigationController presentViewController:controller animated:YES completion:nil];
    }else{
    
        PersonDesViewController*controller=[[PersonDesViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }

}

//左侧按钮点击事件
-(void)leftClickButTON{
    [self.navigationController popViewControllerAnimated:YES];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return trendArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Trend*tableTrend;
    if (trendArray.count!=0) {
        tableTrend=[trendArray objectAtIndex:indexPath.row];
    }
    if (tableTrend.imgsArray.count==1) {
        UIFont *font=[UIFont systemFontOfSize:12];
        CGSize sizefromUrl=   [CheckImage downloadImageSizeWithURL:[tableTrend.imgsArray objectAtIndex:0]];
        CGRect rect=[tableTrend.content boundingRectWithSize:CGSizeMake(277, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        float height;
        if ([[HelperUtil isDefault:tableTrend.gymName]isEqualToString:@"未填写"]) {
            height=rect.size.height+sizefromUrl.height/6+100+10+30;
        }else{
            height=rect.size.height+sizefromUrl.height/6+100+10+31;
        }
        
        NSLog(@"%.2f",rect.size.height);
        return height;
    }
    if (tableTrend.imgsArray.count>1){
        if (tableTrend.imgsArray.count>1&&tableTrend.imgsArray.count<=6) {
            if (tableTrend.imgsArray.count>3&&tableTrend.imgsArray.count<=6){
                
                UIFont *font=[UIFont systemFontOfSize:12];
                CGRect rect=[tableTrend.content boundingRectWithSize:CGSizeMake(277, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
                
                float height=rect.size.height+30+169+50+30+30;
                NSLog(@"%.2f",rect.size.height);
                return height;
                
            }else{
                UIFont *font=[UIFont systemFontOfSize:12];
                CGRect rect=[tableTrend.content boundingRectWithSize:CGSizeMake(277, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
                
                float height=rect.size.height+30+169+30;
                NSLog(@"%.2f",rect.size.height);
                return height;
                
            }
            
        }else{
            UIFont *font=[UIFont systemFontOfSize:12];
            CGRect rect=[tableTrend.content boundingRectWithSize:CGSizeMake(277, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
            
            float height=rect.size.height+30+73+169+30+70+30;
            NSLog(@"%.2f",rect.size.height);
            return height;
        }
        
        
    }else{
        
        UIFont *font=[UIFont systemFontOfSize:12];
        CGRect rect=[tableTrend.content boundingRectWithSize:CGSizeMake(277, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
        float height=rect.size.height+30+73;
        NSLog(@"%.2f",rect.size.height);
        return height;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static   NSString *str=@"cell";
    //使用闲置池
    SprotRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        NSArray*arry=[[NSBundle mainBundle]loadNibNamed:@"SprotRoomTableViewCell" owner:self options:nil];
        cell=[arry objectAtIndex:0];
    }
    Trend*tableTrend;
    if (trendArray.count!=0) {
        tableTrend=[trendArray objectAtIndex:indexPath.row];
    }
    
    if (tableTrend.isLiked==YES) {
        [cell.imageZan setImage:[UIImage imageNamed:@"liked.png"]];
    }else{
        
        [cell.imageZan setImage:[UIImage imageNamed:@"like.png"]];
    }
    //    NSLog(@"%@",  [self changeTime:(NSTimeInterval)tableTrend.createTime]);
    cell.lbTime.text=[NSString stringWithFormat:@"%@",[self intervalSinceNow: [self changeTime:tableTrend.createTime/1000]]];
    
    
    [cell._imageHead sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",tableTrend.briefUser.userAvatar]] placeholderImage:[UIImage imageNamed:@"feedback_bg.png"]];
    cell.lbDes1.text=tableTrend.content;
    cell.lbName.text=tableTrend.briefUser.userName;
    cell.labelZan.text=[NSString stringWithFormat:@"%i",tableTrend.likeCount];
    cell.labelPing.text=[NSString stringWithFormat:@"%i",tableTrend.commentCount];
    cell.buttonZan.tag=indexPath.row;
    cell.lbDiDIan.text=tableTrend.gymName;
    
    
    [cell.buttonZan addTarget:self action:@selector(zanClick:) forControlEvents:UIControlEventTouchUpInside];
    //获取评论内容的高度
    UIFont *font=[UIFont systemFontOfSize:12];
    CGRect rect=[tableTrend.content boundingRectWithSize:CGSizeMake(277, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    NSLog(@"%@",tableTrend.content);
    NSLog(@"%.2f",rect.size.height);
    if (tableTrend.imgsArray.count==1) {
        CGSize sizefromUrl=[CheckImage downloadImageSizeWithURL:[tableTrend.imgsArray objectAtIndex:0]];
        NSLog(@"%@",NSStringFromCGSize(sizefromUrl));
        cell.bigImageP.hidden=NO;
        cell.collectionView.hidden=YES;
        [cell.lbDes1 setFrame:CGRectMake(73, KScreenWidth*0.0986667, KScreenWidth*0.76, rect.size.height)];
        [cell.bigImageP sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[tableTrend.imgsArray objectAtIndex:0]]] placeholderImage:[UIImage imageNamed:@"defaultpic.png"]];
        [cell .bigImageP setFrame:CGRectMake(73, rect.size.height+cell.lbDes1.frame.origin.y+5, sizefromUrl.width/6, sizefromUrl.height/6)];
        if ([[HelperUtil isDefault:tableTrend.gymName]isEqualToString:@"未填写"]) {
            [cell.downView setFrame:CGRectMake(0, rect.size.height+cell.lbDes1.frame.origin.y+sizefromUrl.height/6+30, KScreenWidth, 39)];
        }else{
            [cell.downView setFrame:CGRectMake(0, rect.size.height+cell.lbDes1.frame.origin.y+sizefromUrl.height/6+30, KScreenWidth, KScreenWidth*(60/KScreenWidth))];
        }
        
        
    }else{
        
        
        if (tableTrend.imgsArray.count>1&&tableTrend.imgsArray.count<=6) {
            if (tableTrend.imgsArray.count>3&&tableTrend.imgsArray.count<=6) {
                
                cell.collectionView.hidden=NO;
                cell.bigImageP.hidden=YES;
                cell.picturArray=tableTrend.imgsArray;
                [cell.lbDes1 setFrame:CGRectMake(73, 37, KScreenWidth*0.76, rect.size.height)];
                [cell .collectionView setFrame:CGRectMake(73, rect.size.height+cell.lbDes1.frame.origin.y+5, KScreenWidth-125, KScreenHeight-KScreenWidth)];
                [cell.downView setFrame:CGRectMake(0, rect.size.height+cell.lbDes1.frame.origin.y+cell.collectionView.frame.origin.y+60+60+30, KScreenWidth, KScreenWidth*(60/KScreenWidth))];
                
            }else{
                cell.collectionView.hidden=NO;
                cell.bigImageP.hidden=YES;
                cell.picturArray=tableTrend.imgsArray;
                [cell.lbDes1 setFrame:CGRectMake(73, 37, KScreenWidth*0.76, rect.size.height)];
                [cell .collectionView setFrame:CGRectMake(73, rect.size.height+cell.lbDes1.frame.origin.y+5, KScreenWidth-125, KScreenHeight-KScreenWidth)];
                [cell.downView setFrame:CGRectMake(0, rect.size.height+cell.lbDes1.frame.origin.y+cell.collectionView.frame.origin.y+60, KScreenWidth, KScreenWidth*(60/KScreenWidth))];
                
            }
            
            
        }else{
            
            
            
            if (tableTrend.imgsArray.count>6) {
                cell.collectionView.hidden=NO;
                cell.bigImageP.hidden=YES;
                cell.picturArray=tableTrend.imgsArray;
                [cell.lbDes1 setFrame:CGRectMake(73, 37, KScreenWidth*0.76, rect.size.height)];
                [cell .collectionView setFrame:CGRectMake(73, rect.size.height+cell.lbDes1.frame.origin.y+5, KScreenWidth-125, KScreenHeight-KScreenWidth)];
                [cell.downView setFrame:CGRectMake(0, rect.size.height+cell.lbDes1.frame.origin.y+5+cell.collectionView.frame.origin.y+60+150+30, KScreenWidth, KScreenWidth*(60/KScreenWidth))];
            }else{
                cell.collectionView.hidden=YES;
                cell.bigImageP.hidden=YES;
                [cell.lbDes1 setFrame:CGRectMake(73, 37, KScreenWidth*0.76, rect.size.height)];
                [cell.downView setFrame:CGRectMake(0, rect.size.height+cell.lbDes1.frame.origin.y+5, KScreenWidth, KScreenWidth*(60/KScreenWidth))];
                
            }
            
        }
        
        
        
    }
    
    
    
    return  cell;
    
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


//点击赞事件
-(void)zanClick:(UIButton*)sender{
    
    Trend*tableTrend=[trendArray objectAtIndex:sender.tag];
    if (tableTrend.isLiked==YES) {
        //取消赞
        [GiveZan dontSendsend:tableTrend.id_p];
        tableTrend.isLiked=NO;
        tableTrend.likeCount--;
        
    }else{
        //点赞
        [GiveZan sendsend:tableTrend.id_p];
        tableTrend.isLiked=YES;
        tableTrend.likeCount++;
    }
    [_tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     Trend*tableTrend=[trendArray objectAtIndex:indexPath.row];
    DiscussViewController*controller=[[DiscussViewController alloc]init];
    controller.fromTrendID=tableTrend.id_p;
    controller.fromGymId=_fromGymID;
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
