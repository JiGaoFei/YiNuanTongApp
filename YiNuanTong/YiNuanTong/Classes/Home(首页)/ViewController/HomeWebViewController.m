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
    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
