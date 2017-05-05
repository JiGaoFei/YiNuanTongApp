//
//  MessageWebViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "MessageWebViewController.h"

@interface MessageWebViewController ()

@end

@implementation MessageWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载子视图
    [self setUpChildrenViews];
    // Do any additional setup after loading the view.
}

/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH)];
    webView.scrollView.showsVerticalScrollIndicator = NO;
    webView.scrollView.showsHorizontalScrollIndicator = NO;
    NSString *str= self.titleUrl;
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
