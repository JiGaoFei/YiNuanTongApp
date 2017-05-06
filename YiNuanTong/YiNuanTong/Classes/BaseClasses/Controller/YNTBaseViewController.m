//
//  YNTBaseViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"
#import "UserInfo.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "SingLeton.h"
@interface YNTBaseViewController ()
@property (nonatomic,strong) MBProgressHUD *hud;
@end

@implementation YNTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条的背景颜色
    [self.navigationController.navigationBar setBarTintColor:CGRBlue];
    // 设置导航条上的文字大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 设置返回箭头的颜色
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];

    // Do any additional setup after loading the view.
}
#pragma mark - 显示加载圈,
- (void)showHUD:(NSString *)title
{
    [self.hud show:YES];
    self.hud.labelText = title;
}
#pragma mark - 隐藏加载圈
- (void)hiddenHUD
{
    [self.hud hide:YES];
}

#pragma makr - 加载占位图
- (void)setUpPlaceholdViews
{
    SingLeton *singLeton = [SingLeton shareSingLetonHelper];
    if (singLeton.isLogin) {
        NSLog(@"有网占位图已经隐藏");
    }else{
        NSLog(@"无网占位图已经出现");
    }
}
#pragma mark 计算文字宽度
/**
  *  计算文字长度
  */
- (CGFloat)widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    return size.width;
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
