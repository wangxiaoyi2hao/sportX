//
//  OutSignViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/4/25.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "OutSignViewController.h"
#import "SprotRoomTableViewCell.h"
#import "DiscussViewController.h"
#import "CheckImage.h"
#import "SportRoomDesViewController.h"
extern UserInfo*LoginUserInfo;
@interface OutSignViewController ()
{

    NSMutableArray*trendArrayMy;
    int pageCount;
    NSString*dayDate;

}
@end

@implementation OutSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (LoginUserInfo!=nil) {
        [self requestList];
    }
    [AppDelegate matchAllScreenWithView:self.view];
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self requestList];
    }];
    _tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self requestListDownLoad];
    }];
    // Do any additional setup after loading the view from its nib.
}
-(void)requestListDownLoad{
    pageCount++;

    NSString*str=[NSString stringWithFormat:@"%@/trend/getMyFollowTrends",REQUESTURL];
    //创建参数字符串对象
    Request12002*request12002=[[Request12002 alloc]init];
    request12002.common.userid=LoginUserInfo.userId;
    request12002.common.userkey=LoginUserInfo.userKey;
    request12002.common.cmdid=12002;
    request12002.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request12002.common.platform=2;
    request12002.common.version=sportVersion;
    request12002.params.pageIndex=pageCount;
    NSData*data2=[request12002 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response12002*response12002=[Response12002 parseFromData:dataString error:nil];
        if (response12002.common.code==0) {
            for (int i=0; i<response12002.data_p.trendsArray.count; i++) {
                Trend*mytend=[response12002.data_p.trendsArray objectAtIndex:i];
                [trendArrayMy addObject:mytend];
            }
         
            if (response12002.data_p.maxCountPerPage>response12002.data_p.trendsArray.count) {
                [_tableview.mj_footer endRefreshingWithNoMoreData];
            }else{
                
                [_tableview.mj_footer endRefreshing];
            }
            [[Tostal sharTostal]hiddenView];
   
            [_tableview reloadData];
            
        }else{
            [[Tostal sharTostal]tostalMesg:response12002.common.message tostalTime:10];
            [[Tostal sharTostal]hiddenView];
            [_tableview.mj_footer endRefreshing];
        }
    }];
}

-(void)requestList{
    pageCount=0;
    trendArrayMy=nil;
    trendArrayMy=[NSMutableArray array];
    NSString*str=[NSString stringWithFormat:@"%@/trend/getMyFollowTrends",REQUESTURL];
    //创建参数字符串对象
    Request12002*request12002=[[Request12002 alloc]init];
    request12002.common.userid=LoginUserInfo.userId;
    request12002.common.userkey=LoginUserInfo.userKey;
    request12002.common.cmdid=12002;
    request12002.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request12002.common.platform=2;
    request12002.common.version=sportVersion;
    request12002.params.pageIndex=pageCount;
    NSData*data2=[request12002 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response12002*response12002=[Response12002 parseFromData:dataString error:nil];
        if (response12002.common.code==0) {
            NSLog(@"%@",response12002.data_p.trendsArray);
            for (int i=0; i<response12002.data_p.trendsArray.count; i++) {
                
                Trend*mytend=[response12002.data_p.trendsArray objectAtIndex:i];
                [trendArrayMy addObject:mytend];
            }
            
            [[Tostal sharTostal]hiddenView];
            [_tableview.mj_header endRefreshing];
            [_tableview reloadData];
         
        }else{
            [[Tostal sharTostal]tostalMesg:response12002.common.message tostalTime:10];
             [[Tostal sharTostal]hiddenView];
            [_tableview.mj_header endRefreshing];
        
        }
     }];
}
-(void)viewWillAppear:(BOOL)animated{
    
  self.tabBarController.title=@"关注";
     [self.tabBarController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}
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
//去健身房那嘎达

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
    [_tableview reloadData];
}
- (CGFloat)heightForImage:(UIImage *)image
{
    //(2)获取图片的大小
    CGSize size = image.size;
    //(3)求出缩放比例
    CGFloat scale = KScreenWidth / size.width;
    CGFloat imageHeight = size.height * scale;
    return imageHeight;
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
