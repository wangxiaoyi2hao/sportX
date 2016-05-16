//
//  LookUpPicViewController.m
//  sportXProject
//
//  Created by lsp's mac pro on 16/5/15.
//  Copyright © 2016年 lsp's mac pro. All rights reserved.
//

#import "LookUpPicViewController.h"
#import "YockPhotoImgView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface LookUpPicViewController ()
{


    int page;
    BOOL isShow;
    YockPhotoImgView*_imageView;
    NSMutableArray*_imageArray;
    int _index;
}
@end

@implementation LookUpPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma mark  测试
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showViewTap)];
    [_scrollView addGestureRecognizer:tap];
    //    //创建显示进度的视图
    //    _progressView = [[DDProgressView alloc] initWithFrame:CGRectMake(10, (KScreenHeight-40)/2.0, KScreenWidth-20, 1)];
    //    _progressView.outerColor = [UIColor clearColor];
    //    _progressView.innerColor = [UIColor lightGrayColor];
    //    _progressView.emptyColor = [UIColor darkGrayColor];
    //    _progressView.hidden = YES;
//    _pageControl.numberOfPages=_imageArray.count;
    _scrollView.contentSize=CGSizeMake(_imageArray.count*WIDTH, _scrollView.frame.size.height);
//    InviteImages*invite=[_imageArray objectAtIndex:_index];
    _imageView=[[YockPhotoImgView alloc] initWithFrame:CGRectMake(WIDTH*_index, -30, WIDTH, _scrollView.bounds.size.height+200)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView setImage:[UIImage imageNamed:@"0006.png"]];
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:invite.detailedimages] placeholderImage:[UIImage imageNamed:@"default"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        //创建显示进度的视图
//        _imageView.backgroundColor = [UIColor whiteColor];
//        //判断子视图是否加在父视图上了
//        BOOL needAddToViewFlag = YES;
//        for(UIView *view in _imageView.subviews){
//            if([view isKindOfClass:[LoadingView class]]){
//                needAddToViewFlag = NO;
//            }
//        }
//        if (needAddToViewFlag) {
//            [_imageView addSubview:[[LoadingView shareLoadingView] findOut]];
//            
//        }
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [[LoadingView shareLoadingView] hidden];
//    }];
    
    [_scrollView addSubview:_imageView];
    [_scrollView setContentOffset:CGPointMake(WIDTH*_index, 0) animated:YES];
}


-(void)showViewTap{
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(IBAction)backeClick:(UIButton*)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int nowPage=scrollView.contentOffset.x/WIDTH;
//    _pageControl.currentPage=nowPage;
//    InviteImages*invite=[_imageArray objectAtIndex:nowPage];
    [_imageView setFrame:CGRectMake(WIDTH*nowPage, 0, WIDTH, _scrollView.bounds.size.height)];
        [_imageView setImage:[UIImage imageNamed:@"0006.png"]];
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:invite.detailedimages] placeholderImage:[UIImage imageNamed:@"default"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        _imageView.backgroundColor = [UIColor whiteColor];
//        //判断子视图是否加在父视图上了
//        BOOL needAddToViewFlag = YES;
//        for(UIView *view in _imageView.subviews){
//            if([view isKindOfClass:[LoadingView class]]){
//                needAddToViewFlag = NO;
//            }
//        }
//        if (needAddToViewFlag) {
//            [_imageView addSubview:[[LoadingView shareLoadingView] findOut]];
//        }
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        [[LoadingView shareLoadingView] hidden];
//    }];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    int nowPage=scrollView.contentOffset.x/WIDTH;
//    _pageControl.currentPage=nowPage;
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
