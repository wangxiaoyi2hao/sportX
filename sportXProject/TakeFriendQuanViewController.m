//
//  TakeFriendQuanViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/23.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "TakeFriendQuanViewController.h"
#import "TakeFriendsTableViewCell.h"
#import "StatusWhereViewController.h"
#import "MJPhotoBrowser/MJPhoto.h"
#import <MJPhotoBrowser.h>
#import <MJPhoto.h>
#import "QiNiuClassSend.h"
#import "UIImage+ResizeMagick.h"
#import <MapKit/MapKit.h>
#import <CTAssetsPickerController.h>
#import <CTAssetItemViewController.h>

extern UserInfo*LoginUserInfo;
extern float fromLongitude;
extern float fromLatitude;
@interface TakeFriendQuanViewController ()
{
//1  是发通知过来了  0 是没有发通知过来
    int howToWhere;
    NSMutableArray*imageArray;
     NSInteger selectedPhoto;
    MJPhotoBrowser*browser;
    //上传给qiniu的数组
    NSMutableArray*qiNiuArray;
    NSString*qiNiuToke;
    NSString*backetName;
    //传给后台的数组
    NSMutableArray*sendToHouArray;
    int isPutData;
    //
    NSString*gymName;
    
    int fromGymId;
    
    


}
@end

@implementation TakeFriendQuanViewController
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"想说的话...."]) {
        textView.text = @"";
        textView.textColor=[UIColor blackColor];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"想说的话....";
        textView.textColor=[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.showsVerticalScrollIndicator=NO;
    gymName=@"请选择位置";
    _tableView.scrollEnabled=NO;
    [self loadImages];
    imageArray=[NSMutableArray array];
    qiNiuArray=[NSMutableArray array];
    sendToHouArray=[NSMutableArray array];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshWeiz:) name:@"更新地理位置" object:nil];
    [self loadNav];
    //给图片加上手势
    
    if (KScreenWidth==375) {
        self.imageViewAdd=[[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 67, 67)];
    }else{
        if (KScreenWidth==414) {
            self.imageViewAdd=[[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 67, 67)];
        }else{
         self.imageViewAdd=[[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 50  , 50)];
        }
    
    }
   
    [self.imageViewAdd setImage:[UIImage imageNamed:@"icon_add_tianjia"]];
    [self.imageBaseView addSubview:self.imageViewAdd];
    [self.imageViewAdd.layer setBorderColor:[[UIColor groupTableViewBackgroundColor] CGColor]];
    [self.imageViewAdd.layer setBorderWidth:1];
    [self.imageViewAdd.layer setCornerRadius:5.0];
    UITapGestureRecognizer *tapAddImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickAddImage)];
    [self.imageViewAdd addGestureRecognizer:tapAddImage];
    self.imageViewAdd.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImage1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickImage:)];
        [self.imageView1 addGestureRecognizer:tapImage1];
        self.imageView1.tag = 101;
        self.imageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImage2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickImage:)];
    [self.imageView2 addGestureRecognizer:tapImage2];
    self.imageView2.tag = 102;
    self.imageView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImage3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickImage:)];
    [self.imageView3 addGestureRecognizer:tapImage3];
    self.imageView3.tag = 103;
    self.imageView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImage4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickImage:)];
    [self.imageView4 addGestureRecognizer:tapImage4];
       self.imageView4.userInteractionEnabled = YES;
    self.imageView4.tag = 104;
 
    UITapGestureRecognizer *tapImage5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickImage:)];
    [self.imageView5 addGestureRecognizer:tapImage5];
    self.imageView5.tag = 105;
    self.imageView5.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImage6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickImage:)];
    [self.imageView6 addGestureRecognizer:tapImage6];
    self.imageView6.tag = 106;
    self.imageView6.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImage7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickImage:)];
    [self.imageView7 addGestureRecognizer:tapImage7];
    self.imageView7.tag = 107;
    self.imageView7.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImage8 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickImage:)];
    [self.imageView8 addGestureRecognizer:tapImage8];
    self.imageView8.tag = 108;
    self.imageView8.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapImage9 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onclickImage:)];
    [self.imageView9 addGestureRecognizer:tapImage9];
    self.imageView9.tag = 109;
    self.imageView9.userInteractionEnabled = YES;

    // Do any additional setup after loading the view from its nib.
}
-(void)onclickAddImage{
    [_textView resignFirstResponder];
    UIActionSheet*sheet1=[[UIActionSheet alloc]initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
    [sheet1 showInView:self.view];

}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {
        NSLog(@"我是00");
        //相册
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.delegate=self;
        imgPicker.allowsEditing=YES;
        imgPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imgPicker animated:YES completion:nil];

    }
    if (buttonIndex==1) {
        //相机
        //拍照
        UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
        imagePicker.delegate=self;
        imagePicker.allowsEditing=YES;//设置是否可编辑。
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;//设置以哪种方式取照片，是从本地相册取，还是从相机拍照取。
        [self presentViewController:imagePicker animated:YES completion:nil];
        NSLog(@"我是11");
    }


}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    isPutData=1;
    
    NSData* imageData = [image resizedAndReturnData];
    [qiNiuArray addObject:imageData];
    [imageArray addObject:image];
    [self loadImages];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}
-(void)viewWillAppear:(BOOL)animated{

    [self requestToken];
}
-(void)loadQINiuPicture{
    for (int i = 0; i < qiNiuArray.count; i ++) {
        NSData*liuDate=[qiNiuArray objectAtIndex:i];
        NSString*  fileName = [NSString stringWithFormat:@"%@%@.jpg",[[Tostal sharTostal]getDateTimeString], [[Tostal sharTostal]randomStringWithLength:8]];
        NSLog(@"%@",fileName);
        [sendToHouArray addObject:fileName];
        [[QiNiuClassSend sharQiNiuClassSend]putData:liuDate key:fileName token:qiNiuToke complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            NSLog(@" --->> Info: %@  ", info);
            NSLog(@"%i",info.statusCode);
            if (info.statusCode==200) {
                
                if (i==qiNiuArray.count-1) {
                    [self gogoTrend];
                    
                    
                }
                NSLog(@"成功");
            }
            NSLog(@"-------------------");
            NSLog(@" --->> Response: %@,  ", resp);
        }
                                             option:nil];
    }
    
    
}
-(void)requestToken{
    NSString*str=[NSString stringWithFormat:@"%@/token/getQiniuToken",REQUESTURL];
    //创建参数字符串对象
    Request11001*request11001=[[Request11001 alloc]init];
    request11001.common.userid=LoginUserInfo.userId;
    request11001.common.userkey=LoginUserInfo.userKey;
    request11001.common.cmdid=11001;
    request11001.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request11001.common.platform=2;
    request11001.common.version=sportVersion;
    
    NSData*data2=[request11001 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response11001*response11001=[Response11001 parseFromData:dataString error:nil];
        if (response11001.common.code==0) {
            qiNiuToke=response11001.data_p.qiniuToken;
            backetName=response11001.data_p.bucketName;
        }
        
        
    }];
    
}

- (void)onclickImage:(UITapGestureRecognizer *)sender{
    [_textView resignFirstResponder];
    UIImageView *imageView = (UIImageView *)[sender view];
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:imageArray.count];
    for (int i = 0; i<imageArray.count; i++) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.image = [imageArray objectAtIndex:i];
        if(i == 0){
            photo.srcImageView = self.imageView1; // 来源于哪个UIImageView
        }else if (i == 1){
            photo.srcImageView = self.imageView2;
        }else if (i == 2){
            photo.srcImageView = self.imageView3;
        }else if (i == 3){
            photo.srcImageView = self.imageView4;
        }else if (i == 4){
            photo.srcImageView = self.imageView5;
        }else if (i == 5){
            photo.srcImageView = self.imageView6;
        }else if (i == 6){
            photo.srcImageView = self.imageView7;
        }else if (i == 7){
            photo.srcImageView = self.imageView8;
        }else if (i == 8){
            photo.srcImageView = self.imageView9;
        }
        [photos addObject:photo];
    }
    
    browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = imageView.tag-101; //弹出相册时显示的第一张图片
    browser.photos = photos; //设置所有的图片
    browser.showSaveBtn=NO;
    [browser show];
//    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [deleteButton setImage:[UIImage imageNamed:@"deleteButton.png"] forState:UIControlStateNormal];
//    [deleteButton addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
//    selectedPhoto = browser.currentPhotoIndex;
//    deleteButton.frame = CGRectMake(browser.view.frame.size.width - 50, browser.view.frame.size.height - 50, 40, 40);
//    [browser.view addSubview:deleteButton];

}


-(void)refreshWeiz:(NSNotification*)text{
    NSLog(@"%@",text.userInfo);
     NSLog(@"%@", text.userInfo[@"gymName"]);
    gymName=text.userInfo[@"gymName"];
    NSLog(@"%@",gymName);
    fromGymId=[text.userInfo[@"gymid"] intValue];
    howToWhere=1;
    [_tableView reloadData];

}
-(void)loadNav{
    
    //左侧按钮
    UIButton* leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 28, 20)];
    leftButton.backgroundColor = [UIColor clearColor];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setImage:[UIImage imageNamed:@"all_back.png"] forState:UIControlStateNormal];
    leftButton.titleLabel.font=[UIFont systemFontOfSize:16];
    UIBarButtonItem * leftitem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftitem;
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //右侧按钮
    UIButton*rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40 )];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [rightButton setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    [rightButton setTitle:@"发布" forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    UIBarButtonItem *  rightitem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightitem;
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)leftButtonClick{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButtonClick{
    
    if (isPutData==1) {
        [[Tostal sharTostal]showLoadingView:@"正在发布" view:self.view];
        [self loadQINiuPicture];
    }else{
        [[Tostal sharTostal]showLoadingView:@"正在发布" view:self.view];
        [self gogoTrend];
    
    }
    NSLog(@"发布");
}
-(void)gogoTrend{
    
    NSString*str=[NSString stringWithFormat:@"%@/trend/createTrend",REQUESTURL];
    //创建参数字符串对象
    Request12001*request12001=[[Request12001 alloc]init];
    request12001.common.userid=LoginUserInfo.userId;
    request12001.common.userkey=LoginUserInfo.userKey;
    request12001.common.cmdid=10016;
    request12001.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request12001.common.platform=2;
    request12001.common.version=sportVersion;
    request12001.params.content=_textView.text;
    request12001.params.imageKeysArray=sendToHouArray;
    request12001.params.bucketName=backetName;
    request12001.params.gymId=fromGymId;
    NSData*data2=[request12001 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response12001*response12001=[Response12001 parseFromData:dataString error:nil];
        if (response12001.common.code==0) {
            [[Tostal sharTostal]hiddenView];
        
            [self .navigationController popViewControllerAnimated:YES];
        
        }else{
            [[Tostal sharTostal]hiddenView];
            
        }
        
        
    }];
}
//动态控制九张图片
- (void)loadImages{

        if(imageArray.count == 0){
            self.imageView1.hidden = YES;
            self.imageView2.hidden = YES;
            self.imageView3.hidden = YES;
            self.imageView4.hidden = YES;
            self.imageView5.hidden = YES;
            self.imageView6.hidden = YES;
            self.imageView7.hidden = YES;
            self.imageView8.hidden = YES;
            self.imageView9.hidden = YES;
            self.imageViewAdd.center = self.imageView1.center;
        }else if (imageArray.count == 1){
            self.imageView1.image = [imageArray objectAtIndex:0];
            self.imageView1.hidden = NO;
            self.imageView2.hidden = YES;
            self.imageView3.hidden = YES;
            self.imageView4.hidden = YES;
            self.imageView5.hidden = YES;
            self.imageView6.hidden = YES;
            self.imageView7.hidden = YES;
            self.imageView8.hidden = YES;
            self.imageView9.hidden = YES;
            self.imageViewAdd.center = self.imageView2.center;
        }else if (imageArray.count == 2){
            self.imageView1.image = [imageArray objectAtIndex:0];
            self.imageView2.image = [imageArray objectAtIndex:1];
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = YES;
            self.imageView4.hidden = YES;
            self.imageView5.hidden = YES;
            self.imageView6.hidden = YES;
            self.imageView7.hidden = YES;
            self.imageView8.hidden = YES;
            self.imageView9.hidden = YES;
            self.imageViewAdd.center = self.imageView3.center;
        }else if (imageArray.count == 3){
            self.imageView1.image = [imageArray objectAtIndex:0];
            self.imageView2.image = [imageArray objectAtIndex:1];
            self.imageView3.image =[imageArray objectAtIndex:2];
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = YES;
            self.imageView5.hidden = YES;
            self.imageView6.hidden = YES;
            self.imageView7.hidden = YES;
            self.imageView8.hidden = YES;
            self.imageView9.hidden = YES;
            self.imageViewAdd.center = self.imageView4.center;
        }else if (imageArray.count == 4){
            self.imageView1.image =[imageArray objectAtIndex:0];
            self.imageView2.image =[imageArray objectAtIndex:1];
            self.imageView3.image =[imageArray objectAtIndex:2];
            self.imageView4.image =[imageArray objectAtIndex:3];
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            self.imageView5.hidden = YES;
            self.imageView6.hidden = YES;
            self.imageView7.hidden = YES;
            self.imageView8.hidden = YES;
            self.imageView9.hidden = YES;
            self.imageViewAdd.center = self.imageView5.center;
        }else if (imageArray.count == 5){
            self.imageView1.image =[imageArray objectAtIndex:0];
            self.imageView2.image = [imageArray objectAtIndex:1];
            self.imageView3.image = [imageArray objectAtIndex:2];
            self.imageView4.image = [imageArray objectAtIndex:3];
            self.imageView5.image = [imageArray objectAtIndex:4];
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            self.imageView5.hidden = NO;
            self.imageView6.hidden = YES;
            self.imageView7.hidden = YES;
            self.imageView8.hidden = YES;
            self.imageView9.hidden = YES;
            self.imageViewAdd.center = self.imageView6.center;
        }else if (imageArray.count == 6){
            self.imageView1.image = [imageArray objectAtIndex:0];
            self.imageView2.image = [imageArray objectAtIndex:1];
            self.imageView3.image = [imageArray objectAtIndex:2];
            self.imageView4.image = [imageArray objectAtIndex:3];
            self.imageView5.image = [imageArray objectAtIndex:4];
            self.imageView6.image = [imageArray objectAtIndex:5];
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            self.imageView5.hidden = NO;
            self.imageView6.hidden = NO;
            self.imageView7.hidden = YES;
            self.imageView8.hidden = YES;
            self.imageView9.hidden = YES;
            self.imageViewAdd.center = self.imageView7.center;
        }else if (imageArray.count == 7){
            self.imageView1.image = [imageArray objectAtIndex:0];
            self.imageView2.image = [imageArray objectAtIndex:1];
            self.imageView3.image = [imageArray objectAtIndex:2];
            self.imageView4.image =[imageArray objectAtIndex:3];
            self.imageView5.image = [imageArray objectAtIndex:4];
            self.imageView6.image = [imageArray objectAtIndex:5];
            self.imageView7.image = [imageArray objectAtIndex:6];
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            self.imageView5.hidden = NO;
            self.imageView6.hidden = NO;
            self.imageView7.hidden = NO;
            self.imageView8.hidden = YES;
            self.imageView9.hidden = YES;
            self.imageViewAdd.center = self.imageView8.center;
        }else if (imageArray.count == 8){
            self.imageView1.image = [imageArray objectAtIndex:0];
            self.imageView2.image = [imageArray objectAtIndex:1];
            self.imageView3.image = [imageArray objectAtIndex:2];
            self.imageView4.image = [imageArray objectAtIndex:3];
            self.imageView5.image = [imageArray objectAtIndex:4];
            self.imageView6.image = [imageArray objectAtIndex:5];
            self.imageView7.image = [imageArray objectAtIndex:6];
            self.imageView8.image = [imageArray objectAtIndex:7];
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            self.imageView5.hidden = NO;
            self.imageView6.hidden = NO;
            self.imageView7.hidden = NO;
            self.imageView8.hidden = NO;
            self.imageView9.hidden = YES;
            self.imageViewAdd.center = self.imageView9.center;
        }else if (imageArray.count == 9){
            self.imageView1.image = [imageArray objectAtIndex:0];
            self.imageView2.image = [imageArray objectAtIndex:1];
            self.imageView3.image = [imageArray objectAtIndex:2];
            self.imageView4.image = [imageArray objectAtIndex:3];
            self.imageView5.image = [imageArray objectAtIndex:4];
            self.imageView6.image = [imageArray objectAtIndex:5];
            self.imageView7.image = [imageArray objectAtIndex:6];
            self.imageView8.image = [imageArray objectAtIndex:7];
            self.imageView9.image = [imageArray objectAtIndex:8];
            self.imageView1.hidden = NO;
            self.imageView2.hidden = NO;
            self.imageView3.hidden = NO;
            self.imageView4.hidden = NO;
            self.imageView5.hidden = NO;
            self.imageView6.hidden = NO;
            self.imageView7.hidden = NO;
            self.imageView8.hidden = NO;
            self.imageView9.hidden = NO;
            self.imageViewAdd.hidden = YES;
        }
}
#pragma mark  tabelview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 46;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (howToWhere==0) {
        static   NSString *str=@"cell";
        //使用闲置池
        TakeFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        
        if (cell == nil) {
            NSArray*arry=[[NSBundle mainBundle]loadNibNamed:@"TakeFriendsTableViewCell" owner:self options:nil];
            cell=[arry objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        return  cell;
    }else{
    
        static   NSString *str=@"cell";
        //使用闲置池
        TakeFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        
        if (cell == nil) {
            NSArray*arry=[[NSBundle mainBundle]loadNibNamed:@"TakeFriendsTableViewCell" owner:self options:nil];
            cell=[arry objectAtIndex:0];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.lbWhere.text=gymName;
        
        return  cell;
    }
    
   

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    StatusWhereViewController*controller=[[StatusWhereViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];

    
}
-(IBAction)buttonClickMap:(UIButton*)sender{
    
  
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
