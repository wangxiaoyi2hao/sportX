//
//  PersonDesViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/14.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "PersonDesViewController.h"
#import "SprotRoomTableViewCell.h"
#import "ChatViewController.h"
#import "FansViewController.h"
#import "AttentionViewController.h"
#import "DiscussViewController.h"
#import "UserPhotoMyViewController.h"
extern UserInfo*LoginUserInfo;
@interface PersonDesViewController ()
{
   NSMutableArray*trendArrayMy;
    BOOL isAttention;
    //获取用户详情
    Response10012*response10012;
}
@end

@implementation PersonDesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.tableHeaderView=_headerView;
    [self loadNav];
    [self requestList];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
self.navigationController.navigationBar.hidden = NO;
}
-(void)requestList{
    trendArrayMy=nil;
    trendArrayMy=[NSMutableArray array];
    [[Tostal sharTostal]showLoadingView:@"正在加载" view:self.view];
    NSString*str=[NSString stringWithFormat:@"%@/pilot/getUserDetail",REQUESTURL];
    //创建参数字符串对象
    Request10012*request10012=[[Request10012 alloc]init];
    request10012.common.userid=LoginUserInfo.userId;
    request10012.common.userkey=LoginUserInfo.userKey;
    request10012.common.cmdid=10012;
    request10012.common.timestamp=[[NSDate date]timeIntervalSince1970];
    request10012.common.platform=2;
    request10012.common.version=sportVersion;
    request10012.params.userId=_fromUserId;
    NSData*data2=[request10012 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
         response10012=[Response10012 parseFromData:dataString error:nil];
        if (response10012.common.code==0) {
            lbName.text=response10012.data_p.detailUser.userName;
            lbDong.text=[NSString stringWithFormat:@"%i",response10012.data_p.detailUser.trendCount];
            lbFenScount.text=[NSString stringWithFormat:@"%i",response10012.data_p.detailUser.fensiCount];
            lbGuanConunt.text=[NSString stringWithFormat:@"%i",response10012.data_p.detailUser.guanzhuCount];
            [_imageHead sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",response10012.data_p.detailUser.userAvatar]] placeholderImage:[UIImage imageNamed:@""]];
            lbSign.text=[HelperUtil isDefault:response10012.data_p.detailUser.sign];
            if (response10012.data_p.detailUser.isFollowed==YES) {
                [buttonAtten setTitle:@"已关注" forState:UIControlStateNormal];
            }else{
                [buttonAtten setTitle:@"关注" forState:UIControlStateNormal];
            
            }
            for (int i=0; i<response10012.data_p.detailUser.trendsArray.count; i++) {
                Trend*trendG=[response10012.data_p.detailUser.trendsArray objectAtIndex:i];
                [trendArrayMy addObject:trendG];
            }
            [[Tostal sharTostal]hiddenView];
            [_tableView reloadData];
        }else{
            [[Tostal sharTostal]tostalMesg:response10012.common.message tostalTime:10];
            [[Tostal sharTostal]hiddenView];
        }
    }];
}
//关注按钮
-(IBAction)attentionMation:(UIButton*)sender{
    if (response10012.data_p.detailUser.isFollowed==true) {
        isAttention=false;
        [self requestNOTAttention];
        
    }else{
        isAttention=true;
        [self requestAttention];
    }
    

}
//关注／取消关注他人
-(void)requestNOTAttention{
    [[Tostal sharTostal]showLoadingView:@"正在加载" view:self.view];

    
    NSString*str=[NSString stringWithFormat:@"%@/pilot/guanzhuUser",REQUESTURL];
    //创建参数字符串对象
    Request10011*request10011=[[Request10011 alloc]init];
    request10011.common.userid=LoginUserInfo.userId;
    request10011.common.userkey=LoginUserInfo.userKey;
    request10011.common.cmdid=10011;
    request10011.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request10011.common.platform=2;
    request10011.common.version=sportVersion;
    request10011.params.toUserId=_fromUserId;
    request10011.params.isFollow=isAttention;
    NSData*data2=[request10011 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response10011*response10011=[Response10011 parseFromData:dataString error:nil];
        if (response10011.common.code==0) {
            [buttonAtten setTitle:@"关注" forState:UIControlStateNormal];
            
            [[Tostal sharTostal]hiddenView];
            [_tableView reloadData];
            
        }else{
            [[Tostal sharTostal]tostalMesg:response10011.common.message tostalTime:10];
            [[Tostal sharTostal]hiddenView];
            
            
        }
    }];
}

//关注
-(void)requestAttention{
    [[Tostal sharTostal]showLoadingView:@"正在加载" view:self.view];
    NSString*str=[NSString stringWithFormat:@"%@/pilot/guanzhuUser",REQUESTURL];
    //创建参数字符串对象
    Request10011*request10011=[[Request10011 alloc]init];
    request10011.common.userid=LoginUserInfo.userId;
    request10011.common.userkey=LoginUserInfo.userKey;
    request10011.common.cmdid=10011;
    request10011.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request10011.common.platform=2;
    request10011.common.version=sportVersion;
    request10011.params.toUserId=_fromUserId;
    request10011.params.isFollow=isAttention;
    NSData*data2=[request10011 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response10011*response10011=[Response10011 parseFromData:dataString error:nil];
        if (response10011.common.code==0) {
            [buttonAtten setTitle:@"已关注" forState:UIControlStateNormal];
            [[Tostal sharTostal]hiddenView];
            [_tableView reloadData];
        }else{
            [[Tostal sharTostal]tostalMesg:response10011.common.message tostalTime:10];
            [[Tostal sharTostal]hiddenView];
      
            
        }
    }];
}

-(IBAction)attentionGo:(UIButton*)sender{

    AttentionViewController*controller=[[AttentionViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];



}
-(IBAction)fansGo:(UIButton*)sender{
 
    FansViewController*controller=[[FansViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
}
//动态按钮
-(IBAction)kaoQuan:(UIButton*)sender{
    UserPhotoMyViewController*controller=[[UserPhotoMyViewController alloc]init];
    controller.fromUserid=_fromUserId;
    [self.navigationController pushViewController:controller animated:YES];

}
//进入单聊
-(IBAction)chatConttoller:(UIButton*)sender{
    //新建一个聊天会话View Controller对象
    ChatViewController *chat = [[ChatViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = [NSString stringWithFormat:@"%i",_fromUserId];
    //设置聊天会话界面要显示的标题
    chat.title = lbName.text;
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];

}

-(void)loadNav{
    self.title=@"个人详情";
    UIButton * leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setImage:[UIImage imageNamed:@"all_back.png"] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [leftButton addTarget:self action:@selector(leftClickButTON) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    
}
-(void)leftClickButTON{

    [self.navigationController popViewControllerAnimated:YES];
}
    
#pragma mark tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return trendArrayMy.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Trend*tableTrend;
    if (trendArrayMy.count!=0) {
        tableTrend=[trendArrayMy objectAtIndex:indexPath.row];
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
    if (trendArrayMy.count!=0) {
        tableTrend=[trendArrayMy objectAtIndex:indexPath.row];
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
    
    Trend*tableTrend=[trendArrayMy objectAtIndex:sender.tag];
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
    Trend*tableTrend1=[trendArrayMy objectAtIndex:indexPath.row];
    DiscussViewController*controller=[[DiscussViewController alloc]init];
    controller.fromTrendID=tableTrend1.id_p;
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
