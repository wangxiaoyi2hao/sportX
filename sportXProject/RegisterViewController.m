//
//  RegisterViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/18.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "RegisterViewController.h"
#import "MyAlertView.h"
#import "UIImage+ResizeMagick.h"
#import "QiNiuClassSend.h"
extern UserInfo*LoginUserInfo;
@interface RegisterViewController ()
{

    NSString*qiNiuToke;
    NSString*backetName;
    NSData* imageData;

}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNav];
    [AppDelegate matchAllScreenWithView:self.view];

    _imageHead.layer.cornerRadius=40;
    _imageHead.layer.masksToBounds=YES;
       [self requestToken];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
 


}
-(void)loadNav{
    self.title=@"注册";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
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
-(IBAction)imageClick:(UIButton*)sender{
    UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"相机", nil];
    [sheet showInView:self.view];



}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{//这里是显示的那个是相册的地方
        if (buttonIndex==0) {
                //相册
                UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
                imgPicker.delegate=self;
                imgPicker.allowsEditing=YES;
                imgPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imgPicker animated:YES completion:nil];
            }
            if (buttonIndex==1) {
                //拍照
                UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
                imagePicker.delegate=self;
                imagePicker.allowsEditing=YES;//设置是否可编辑。
                imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;//设置以哪种方式取照片，是从本地相册取，还是从相机拍照取。
                [self presentViewController:imagePicker animated:YES completion:nil];
            }

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    //给图片转化成data  为了上传七牛
   imageData = [image resizedAndReturnData];
    [_imageHead setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
 
}
-(void)loadQINiuPicture{
        NSString*  fileName = [NSString stringWithFormat:@"%@%@.jpg",[[Tostal sharTostal]getDateTimeString], [[Tostal sharTostal]randomStringWithLength:8]];
        NSLog(@"%@",fileName);

        [[QiNiuClassSend sharQiNiuClassSend]putData:imageData key:fileName token:qiNiuToke complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            NSLog(@" --->> Info: %@  ", info);
            NSLog(@"%i",info.statusCode);
            if (info.statusCode==200) {
                NSLog(@"成功");
                [self requestRegirse];
            }
            NSLog(@"-------------------");
            NSLog(@" --->> Response: %@,  ", resp);
        }
                                             option:nil];
 
    
    
}
-(void)requestRegirse{
    
    NSString*str=[NSString stringWithFormat:@"%@/pilot/register",REQUESTURL];
    //创建参数字符串对象
    Request10001*request10001=[[Request10001 alloc]init];
    request10001.common.userid=LoginUserInfo.userId;
    request10001.common.userkey=LoginUserInfo.userKey;
    request10001.common.cmdid=10001;
    request10001.common.  timestamp=[[NSDate date]timeIntervalSince1970];
    request10001.common.platform=2;
    request10001.common.version=sportVersion;
    request10001.params.phone=@"15939865871";
    request10001.params.username=_tfName.text;
    request10001.params.avatarKey=qiNiuToke;
    request10001.params.bucketName=backetName;
    request10001.params.password=[HelperUtil md532BitUpper:_tfPwd.text];
    if ([_lbSex.text isEqualToString:@"男"]) {
        request10001.params.sex=Sex_Male;
    }else{
        request10001.params.sex=Sex_Female;
    }
    NSData*data2=[request10001 data];
    [SendInternet httpNsynchronousRequestUrl:str postStr:data2 finshedBlock:^(NSData *dataString) {
        Response10001*response10001=[Response10001 parseFromData:dataString error:nil];
        if (response10001.common.code==0) {
            UserInfo*user=[[UserInfo alloc]init];
            user.userId=response10001.data_p.userId;
            user.userKey=response10001.data_p.userKey;
            LoginUserInfo=user;
            [NSKeyedArchiver archiveRootObject:user toFile:[MyFile fileByDocumentPath:@"/isUserAll.archiver"]];
            [[Tostal sharTostal]hiddenView];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
        
        
    }];
    
}

-(IBAction)selectSex:(UIButton*)sender{
#pragma mark 倒入alter封装好的浮窗。
  
    MyAlertView *alertView = [[MyAlertView alloc]
                              initWithTitle:@"请选择性别"
                              message:@""
                              cancelButtonTitle:@"女"
                              otherButtonTitles:@"男"
                              clickBlock:^(NSInteger index, UIAlertView *alertView) {
                                  if (index == 0) {
                                    _lbSex.text=@"性别：女";
                                 
                                  }else if (index == 1) {
                                  _lbSex.text=@"性别：男";
                                  }
                              }];
    [alertView show];


}
-(IBAction)regtiseClick:(UIButton*)sender{
    [[Tostal sharTostal]showLoadingView:@"正在注册" view:self.view];
    [self  loadQINiuPicture];
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
