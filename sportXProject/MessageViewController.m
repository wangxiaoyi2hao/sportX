//
//  MessageViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/4/25.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "MessageViewController.h"
#import "ChatViewController.h"
#import "PersonDesViewController.h"


@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title=@"消息";
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
  
}
//重载函数，onSelectedTableRow 是选择会话列表之后的事件，该接口开放是为了便于您自定义跳转事件。在快速集成过程中，您只需要复制这段代码。
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    //无论是群组还是单人聊天都跳转到这个类中
     ChatViewController*conversationVC = [[ChatViewController alloc]init];
    conversationVC.conversationType =model.conversationType;
    conversationVC.targetId = model.targetId;
//    conversationVC.fromTagerId=model.targetId;
    conversationVC.title = model.conversationTitle;
    conversationVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:conversationVC animated:YES];
    //清除某一类型消息数量
    [[RCIMClient sharedRCIMClient] clearMessagesUnreadStatus:conversationVC.conversationType targetId:conversationVC.targetId];
    //获取所有的未读消息数
    int notReadMessage = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    //把数据传到最下边的角标上
//    self.number = [NSString stringWithFormat:@"%d",notReadMessage];
}
/*!
 即将显示Cell的回调
 @param cell        即将显示的Cell
 @param indexPath   该Cell对应的会话Cell数据模型在数据源中的索引值
 @discussion 您可以在此回调中修改Cell的一些显示属性。
 */
- (void)willDisplayConversationTableCell:(RCConversationBaseCell *)cell
                             atIndexPath:(NSIndexPath *)indexPath{
    //获取到对应数据是男是女再添加,暂时不做这个,主要是取不到姓名的label
    //对应位置添加一个元素
    //    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 20, 20)];
    //    label.backgroundColor = [UIColor greenColor];
    //    [cell.contentView addSubview:label];
    //设置cell背景色为透明
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    RCConversationCell *concell = (RCConversationCell *)cell;
//    concell.bubbleTipView.bubbleTipBackgroundColor = [HelperUtil colorWithHexString:@"FE6162"];
    
    //    RCConversationModel *model= self.conversationListDataSource[indexPath.row];
    //    if (model.conversationType == ConversationType_PRIVATE) {
    //        RCConversationCell *concell = (RCConversationCell *)cell;
    ////        concell.conversationTitle.translatesAutoresizingMaskIntoConstraints = YES;
    //        concell.bubbleTipView
    //    }
}
/*!
 点击Cell头像的回调
 
 @param model   会话Cell的数据模型
 */
- (void)didTapCellPortrait:(RCConversationModel *)model{
    if (model.conversationType == ConversationType_PRIVATE) {
        
        PersonDesViewController *infoTVC = [[PersonDesViewController alloc]init];
//        infoTVC.fromUserId =  model.targetId;
        
        infoTVC.hidesBottomBarWhenPushed=YES;
        UINavigationController*nav=[[UINavigationController alloc]initWithRootViewController:infoTVC];
        
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        
    }else{
        
    }
}

/*!
 在会话列表中，收到新消息的回调
 
 @param notification    收到新消息的notification
 
 @discussion SDK在此方法中有针对消息接收有默认的处理（如刷新等），如果您重写此方法，请注意调用super。
 
 notification的object为RCMessage消息对象，userInfo为NSDictionary对象，其中key值为@"left"，value为还剩余未接收的消息数的NSNumber对象。
 */
- (void)didReceiveMessageNotification:(NSNotification *)notification{
    [super didReceiveMessageNotification:notification];
    //    如果让显示数字,下边内容解开注释
    NSInteger cont = [[RCIMClient sharedRCIMClient] getTotalUnreadCount];
    NSString *str = [NSString stringWithFormat:@"%ld",cont];
//    self.number = str;
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
