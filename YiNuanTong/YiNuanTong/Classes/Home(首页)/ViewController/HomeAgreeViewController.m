//
//  HomeAgreeViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/28.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "HomeAgreeViewController.h"
#import "YNTNetworkManager.h"
#import "YNTUITools.h"
@interface HomeAgreeViewController ()
@property (nonatomic,strong) UIWebView *webView;
/**数据*/
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@end

@implementation HomeAgreeViewController

#pragma mark - 懒加载
- (NSMutableDictionary *)dataDic
{
    if (!_dataDic) {
        self.dataDic = [[NSMutableDictionary alloc]init];
    }
    return _dataDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册协议";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpNavChildrenViews];
    [self loadData];

}
/**
 *创建子视图
 */
- (void)setUpNavChildrenViews
{
    // 创建导航栏
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 64)];
    navView.backgroundColor = RGBA(18, 122, 203, 1);
    
    [self.view addSubview:navView];
    
    
    // 创建返回btn
    UIButton *backBtn = [YNTUITools createButton:CGRectMake(21.5, 20, 25, 32) bgColor: nil title:nil titleColor:nil action:@selector(backBtnAction:) vc:self];
    UIImage *backImg = [UIImage imageNamed:@"返回箭头"];
    backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    
    [self.view addSubview:backBtn];
    
    // 创建审核进度lab
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(KScreenW /2 -40, 20, 80, 40) text:@"注册协议" textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:17];
    [self.view addSubview:titleLab];
}
- (void)backBtnAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 加载数据
- (void)loadData
{
    NSString *url = [NSString stringWithFormat:@"%@api/problem.php",baseUrl];
    NSDictionary *params = @{@"id":@"25",@"act":@"detail"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        self.dataDic = responseObject;
        NSLog(@"请求订货流程数据成功: %@",responseObject);
        [self setUpChildViews];
    } enError:^(NSError *error) {
        NSLog(@"请求订货流程数据失败%@",error);
    }];
}
// 加载视图
- (void)setUpChildViews
{
    
    
    // 计算文字的高度
    CGSize size = [self.dataDic[@"title"] boundingRectWithSize:CGSizeMake(KScreenW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale, 74 , KScreenW - 80 *kWidthScale, size.height)];
    titleLab.numberOfLines = 0;
    titleLab.font = [UIFont fontWithName:@ "Helvetica-Bold"  size:(20.0)];
    titleLab.text = self.dataDic[@"title"];
    
    
    
    [self.view addSubview:titleLab];
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(10 *kWidthScale, 84 + size.height, KScreenW-20 *kWidthScale, kScreenH)];
    
    
    NSString *str1 = [NSString stringWithFormat:@"<style>*{margin:0; padding:0;} img{width:100%%;}</style>%@",self.dataDic[@"content"]];
    
    [self.view addSubview:_webView];
    _webView.scalesPageToFit = YES;
    
    [_webView loadHTMLString:str1 baseURL:nil];
}

@end
