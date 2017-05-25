//
//  CycleDetailViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/3/6.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "CycleDetailViewController.h"
#import <Masonry/Masonry.h>
#import <WebKit/WebKit.h>
@interface CycleDetailViewController ()<WKNavigationDelegate>
@property (nonatomic,strong)  WKWebView *webView ;
/**进度条*/
@property (nonatomic,strong) UIProgressView *progressView;

@end

@implementation CycleDetailViewController
/** 懒加载 */
- (UIProgressView *)progressView
{
    if (!_progressView)
    {
        UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, 10)];
        progressView.tintColor =RGBA(59, 198, 90, 1);
        progressView.trackTintColor = [UIColor grayColor];
        [self.view addSubview:progressView];
        self.progressView = progressView;
    }
    return _progressView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    // 视图将要出现的时候隐藏tabBar
     self.tabBarController.tabBar.hidden =YES;
 
        [self setUpChildrenViews];
    
  }
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    // 视图将要消失的时候显示tabBar
    
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];



    // Do any additional setup after loading the view.
}

// 加载视图
- (void)setUpChildrenViews
{
  
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0,0, KScreenW,kScreenH)];
      _webView.navigationDelegate = self;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;

    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

    
    NSURL *url = [NSURL URLWithString:self.link];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    [self.view insertSubview:_webView belowSubview:_progressView];
   
}
#pragma mark ——— 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        
        CGFloat newProgress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        
        if (newProgress ==1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else{
            self.progressView.hidden = NO;
            [self.progressView setProgress:newProgress animated:YES];
        }
    }
}
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
