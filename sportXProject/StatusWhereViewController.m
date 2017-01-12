//
//  StatusWhereViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/24.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "StatusWhereViewController.h"
#import "StatusWhereTableViewCell.h"
extern float fromLongitude;
extern float fromLatitude;
@interface StatusWhereViewController ()
{

    int pageCount;
    NSMutableArray*nearGymArray;

}
@end

@implementation StatusWhereViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
    [self sendsend];
    //加上下拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self sendsend];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self sendsendDowLoad];
    }];
    // Do any additional setup after loading the view from its nib.
}
-(void)loadNav{
   self.title=@"选择位置";
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
//请求附近健身房
-(void)sendsend{
    pageCount=0;
    nearGymArray=nil;
    nearGymArray=[NSMutableArray array];
    [[Tostal sharTostal]showLoadingView:@"正在加载健身房" view:self.view];
    //分页做处理
    NSString*str=[NSString stringWithFormat:@"%@/gym/getGymList",REQUESTURL];
    //创建参数字符串对象
    Request13001*request13001=[[Request13001 alloc]init];
    request13001.common.userid=7;
    request13001.common.userkey=@"";
    request13001.common.cmdid=13001;
    request13001.common.timestamp=[[NSDate date]timeIntervalSince1970];
    request13001.common.platform=2;
    request13001.common.version=@"1.0.0";
    request13001.params.longitude=fromLongitude;
    request13001.params.latitude=fromLatitude;
    request13001.params.pageIndex=pageCount;
    NSLog(@"%.2f",fromLatitude);
    NSData*data2=[request13001 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response13001*response13001=[Response13001 parseFromData:dataString error:nil];
        if (response13001.common.code==0) {
            for (int i=0; i<response13001.data_p.briefGymsArray.count; i++) {
                BriefGym*gymRoom=[response13001.data_p.briefGymsArray objectAtIndex:i];
                [nearGymArray addObject:gymRoom];
            }
            NSLog(@"%@",nearGymArray);
            [_tableView reloadData];
            [[Tostal sharTostal]hiddenView];
            [_tableView.mj_header endRefreshing];
        }else{
            [[Tostal sharTostal]tostalMesg:response13001.common.message tostalTime:1];
            [[Tostal sharTostal]hiddenView];
            [_tableView.mj_header endRefreshing];
        }
    }];
}
//请求附近健身房
-(void)sendsendDowLoad{
    pageCount++;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    //分页做处理
    NSString*str=[NSString stringWithFormat:@"%@/gym/getGymList",REQUESTURL];
    //创建参数字符串对象
    Request13001*request13001=[[Request13001 alloc]init];
    request13001.common.userid=7;
    request13001.common.userkey=@"";
    request13001.common.cmdid=13001;
    request13001.common.timestamp=[[NSDate date]timeIntervalSince1970];
    request13001.common.platform=2;
    request13001.common.version=@"1.0.0";
    request13001.params.longitude=fromLongitude;
    request13001.params.latitude=fromLatitude;
    request13001.params.pageIndex=pageCount;
    NSLog(@"%.2f",fromLatitude);
    NSData*data2=[request13001 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response13001*response13001=[Response13001 parseFromData:dataString error:nil];
        if (response13001.common.code==0) {
            for (int i=0; i<response13001.data_p.briefGymsArray.count; i++) {
                BriefGym*gymRoom=[response13001.data_p.briefGymsArray objectAtIndex:i];
                [nearGymArray addObject:gymRoom];
            }
            NSLog(@"%i",response13001.data_p.maxCountPerPage);
            NSLog(@"%@",nearGymArray);
            NSLog(@"----------------%lu",response13001.data_p.maxCountPerPage-response13001.data_p.briefGymsArray_Count);
            if (response13001.data_p.maxCountPerPage-nearGymArray.count<=0) {
                [_tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
            
              [_tableView.mj_footer endRefreshing];
            }
            [_tableView reloadData];
            [[Tostal sharTostal]hiddenView];
          
        }else{
            [[Tostal sharTostal]tostalMesg:response13001.common.message tostalTime:1];
            [[Tostal sharTostal]hiddenView];
            [_tableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark tableviewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 58;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return nearGymArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static   NSString *str=@"cell";
    //使用闲置池
    StatusWhereTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        NSArray*arry=[[NSBundle mainBundle]loadNibNamed:@"StatusWhereTableViewCell" owner:self options:nil];
        cell=[arry objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    BriefGym*gymRoom=[nearGymArray objectAtIndex:indexPath.row];
    cell.lbName.text=gymRoom.gymName;
    [cell.imageHead sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",gymRoom.gymAvatar]] placeholderImage:[UIImage imageNamed:@""]];
    cell.lbAddress.text=gymRoom.place;
 
    return  cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    BriefGym*gymRoom=[nearGymArray objectAtIndex:indexPath.row];
    NSLog(@"%@",gymRoom.gymName);
    NSDictionary*dic=[[NSDictionary alloc]init];
    dic = @{
            @"gymName":gymRoom.gymName,
            @"gymid":[NSString stringWithFormat:@"%i",gymRoom.id_p]
            };

#pragma mark 从网络获取的数据传过去
      [[NSNotificationCenter defaultCenter]postNotificationName:@"更新地理位置" object:self userInfo:dic];
    [self.navigationController popViewControllerAnimated:YES];
    
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
