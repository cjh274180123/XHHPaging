//
//  ViewController.m
//  XHHPaging
//
//  Created by mac on 17/2/10.
//  Copyright © 2017年 CJH. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import <SVProgressHUD/SVProgressHUD.h>
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define SPRING_BACK 0.3

@interface ViewController ()

@end
@interface ViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic,strong)UIScrollView * scrollView;
@property (nonatomic,strong)UIWebView  * webView;
@property (nonatomic ,strong) UILabel   *middleLab;
@property (nonatomic,assign)CGFloat   offset;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UILayout];
}
-(void)UILayout
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.middleLab];
}
-(void)loadingWeb
{
    [self.webView.scrollView headerEndRefreshing];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.scrollView.contentOffset = CGPointMake(0,0);
        self.scrollView.contentSize = CGSizeMake(kScreenW, kScreenH + SPRING_BACK);
    } completion:^(BOOL finished) {
        self.scrollView.scrollEnabled = YES;
        self.webView.scrollView.scrollEnabled = NO;
    }];
    
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}
#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        _offset = scrollView.contentOffset.y;
    }
    
    NSLog(@"y = %f",scrollView.contentOffset.y);
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (scrollView == self.scrollView) {
        if (offsetY > 40) {
            self.middleLab.text = @"释放返回中间View";
        }else{
            self.middleLab.text = @"上拉显示底部View";
        }
    }
}
-(void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    if (_offset > 40) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            if (_webView == nil) {
                [SVProgressHUD showWithStatus:@"努力加载中..."];
            }
            [self.scrollView addSubview:self.webView];
            [self.webView.scrollView addHeaderWithTarget:self action:@selector(loadingWeb)];
            self.scrollView.contentSize = CGSizeMake(kScreenW, kScreenH * 2);
            self.scrollView.contentOffset = CGPointMake(0, kScreenH);
        } completion:^(BOOL finished) {
            self.scrollView.scrollEnabled = NO;
            self.webView.scrollView.scrollEnabled = YES;
        }];
        
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_offset < 40) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.scrollView.contentOffset = CGPointMake(0,0);
        } completion:^(BOOL finished) {
        }];
    }
}
#pragma mark - getter
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,kScreenW, kScreenH)];
        _scrollView.contentSize = CGSizeMake(kScreenW, kScreenH+SPRING_BACK);
        _scrollView.contentOffset = CGPointZero;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}
-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kScreenH, kScreenW, kScreenH)];
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        _webView.backgroundColor = [UIColor blueColor];
        [_webView loadRequest:request];
        _webView.scrollView.scrollEnabled = NO;
        _webView.delegate = self;
    }
    return _webView;
}
- (UILabel *)middleLab {
    if (!_middleLab)
    {
        _middleLab = [[UILabel alloc] initWithFrame:CGRectMake(0,kScreenH-40, kScreenW,40)];
        
        _middleLab.font = [UIFont systemFontOfSize:13.0f];
        
        _middleLab.textAlignment = NSTextAlignmentCenter;
        
        _middleLab.backgroundColor = [UIColor darkGrayColor];
        
        _middleLab.text = @"上拉显示底部View";
        
        _middleLab.textColor = [UIColor redColor];
    }
    return _middleLab;
}
@end
