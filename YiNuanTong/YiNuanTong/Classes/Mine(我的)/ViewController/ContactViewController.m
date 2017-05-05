//
//  ContactViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系我们";
    self.view.backgroundColor = [UIColor whiteColor];
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
    NSString *str= @"http://zz.meituan.com";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
