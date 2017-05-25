//
//  HomeWebViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/17.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "HomeWebViewController.h"

@interface HomeWebViewController ()

@end

@implementation HomeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   self.title = self.titleStr;
    [self setUpWebView];
 
}
/**
*加载网页
*/
- (void)setUpWebView
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH)];
    
    webView.scrollView.showsVerticalScrollIndicator= NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
  
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
