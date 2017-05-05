//
//  OrderProcessViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "OrderProcessViewController.h"
#import "YNTNetworkManager.h"
@interface OrderProcessViewController ()
@property (nonatomic,strong) UIWebView *webView;
/**数据*/
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@end

@implementation OrderProcessViewController
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
    self.title = @"订货流程";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
}

// 加载数据
- (void)loadData
{
    NSString *url = [NSString stringWithFormat:@"%@api/problem.php",baseUrl];
    NSDictionary *params = @{@"id":@"23",@"act":@"detail"};
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
    
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 84 + size.height, KScreenW, kScreenH)];
    
    
    NSString *str1 = [NSString stringWithFormat:@"<style>*{margin:0; padding:0;} img{width:100%%;}</style>%@",self.dataDic[@"content"]];
    
    [self.view addSubview:_webView];
    _webView.scalesPageToFit = YES;
    
    [_webView loadHTMLString:str1 baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
