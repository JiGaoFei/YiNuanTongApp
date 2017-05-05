//
//  CommentProblemDetaiViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/18.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "CommentProblemDetaiViewController.h"
#import "YNTNetworkManager.h"
@interface CommentProblemDetaiViewController ()

@property (nonatomic,strong) UIWebView *webView;
/**数据*/
@property (nonatomic,strong) NSMutableDictionary *dataDic;

@end

@implementation CommentProblemDetaiViewController
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
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"问题详情";
    [self loadData];
    // 加载视图
  //  [self  setUpChildViews];
    
}
// 加载数据
- (void)loadData
{
    NSString *url = [NSString stringWithFormat:@"%@api/problem.php",baseUrl];
    NSDictionary *params = @{@"act":@"detail",@"id":@"22"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        self.dataDic = responseObject;
        NSLog(@"请求问题详情数据成功: %@",responseObject);
        [self setUpChildViews];
    } enError:^(NSError *error) {
        NSLog(@"请求问题详情数据失败%@",error);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
