//
//  UserPhotoViewController.m
//  sportXProject
//
//  Created by Yao.zhou on 16/5/16.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "UserPhotoViewController.h"
#import "UIImage+ResizeMagick.h"
#import "QiNiuClassSend.h"
extern UserInfo*LoginUserInfo;
@interface UserPhotoViewController ()
{
    NSData*imageData;
    NSString*qiNiuToke;
    NSString*backetName;
    NSString*fileName;
//    qiNiuToke=response11001.data_p.qiniuToken;
//    backetName=response11001.data_p.bucketName;
   
    
}
@end

@implementation UserPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",LoginUserInfo.userAvata]] placeholderImage:[UIImage imageNamed:@""]];
    [self loadNav];
}
-(void)viewWillAppear:(BOOL)animated{

    [self requestToken];

}
-(void)loadNav{
     self.title = @"个人头像";
    
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
    UIButton*rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 20 )];
    rightButton.backgroundColor = [UIColor clearColor];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:16];
    UIBarButtonItem *  rightitem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightitem;
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)leftButtonClick{

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightButtonClick{
//调
    [self xiangce];
}
-(void)xiangce{

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectFromAlbum];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self takingPhoto];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)  {
    }]];
    
    [self presentViewController:alertController animated:YES completion:NULL];

}
//从相册选择
- (void)selectFromAlbum{
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.delegate=self;
    imgPicker.allowsEditing=YES;
    imgPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imgPicker animated:YES completion:nil];
}
//拍照
- (void)takingPhoto{
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;
    imagePicker.allowsEditing=YES;//设置是否可编辑。
    imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;//设置以哪种方式取照片，是从本地相册取，还是从相机拍照取。
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    //给图片转化成data  为了上传七牛
    imageData = [image resizedAndReturnData];
    [_photoImageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self loadQINiuPicture];
    
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
//更新个人信息
-(void)requestUpdatePerson{
    NSString*str=[NSString stringWithFormat:@"%@/pilot/updateMyInfo",REQUESTURL];
    //创建参数字符串对象
    Request10004*request10004=[[Request10004 alloc]init];
    request10004.common.userid=LoginUserInfo.userId;
    request10004.common.userkey=LoginUserInfo.userKey;
    request10004.common.cmdid=11001;
    request10004.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request10004.common.platform=2;
    request10004.common.version=sportVersion;
    request10004.params.avatarKey=fileName;
    request10004.params.bucketName=backetName;

    
    NSData*data2=[request10004 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response10004*response10004=[Response10004 parseFromData:dataString error:nil];
        if (response10004.common.code==0) {
            [[Tostal sharTostal]tostalMesg:@"修改成功" tostalTime:1];
            LoginUserInfo.userAvata=response10004.data_p.avatarURL;
            NSLog(@"%@",LoginUserInfo.userAvata);
            [NSKeyedArchiver archiveRootObject:LoginUserInfo toFile:[MyFile fileByDocumentPath:@"/isUserAll.archiver"]];
            RCUserInfo*rcc=[[RCUserInfo alloc]init];
            rcc.userId=[NSString stringWithFormat:@"%i",LoginUserInfo.userId];
            rcc.name=LoginUserInfo.userName;
            rcc.portraitUri=LoginUserInfo.userAvata;
            [[RCIM sharedRCIM]refreshUserInfoCache:rcc withUserId:[NSString stringWithFormat:@"%i",LoginUserInfo.userId]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
           
        }
        
        
    }];
    
}

-(void)loadQINiuPicture{
    fileName = [NSString stringWithFormat:@"%@%@.jpg",[[Tostal sharTostal]getDateTimeString], [[Tostal sharTostal]randomStringWithLength:8]];
    NSLog(@"%@",fileName);
    
    [[QiNiuClassSend sharQiNiuClassSend]putData:imageData key:fileName token:qiNiuToke complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@" --->> Info: %@  ", info);
        NSLog(@"%i",info.statusCode);
        if (info.statusCode==200) {
            [self requestUpdatePerson];
            NSLog(@"成功");
        }
        NSLog(@"-------------------");
        NSLog(@" --->> Response: %@,  ", resp);
    }
                                         option:nil];
    
    
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
