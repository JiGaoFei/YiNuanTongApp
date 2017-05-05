//
//  YNTTabBarViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//
#import "YNTHomeViewController.h"
#import "YNTCustomerSerViceViewController.h"
#import "YNTShopingCarViewController.h"
#import "YNTMessageViewController.h"
#import "YNTMineViewController.h"
#import "YNTTabBarViewController.h"
#import "YNTNavigationViewController.h"
#import "SingLeton.h"

@interface YNTTabBarViewController ()<UITabBarControllerDelegate>
@property (nonatomic,strong)UIButton *button;
@end

@implementation YNTTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :RGBA(113, 114, 115, 1) } forState:UIControlStateNormal] ;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName :RGBA(18, 22, 203, 1)} forState:UIControlStateHighlighted] ;

    
   
    //添加子控制器
    [self setupChildVc:[[YNTHomeViewController alloc] init] title:@"首页" image:@"主页-未选中状态" selectedImage:@"主页-选中状态"];
 // [self setupChildVc:[[YNTCustomerSerViceViewController alloc] init] title:@"客服" image:@"home_customer_service_unchecked" selectedImage:@"home_customer_service_checked"];
    [self setupChildVc:[[YNTShopingCarViewController alloc] init] title:@"进货单" image:@"home_receipt_unchecked" selectedImage:@"home_receipt_checked"];
     [self setupChildVc:[[YNTMessageViewController alloc] init] title:@"消息" image:@"消息-未选中状态" selectedImage:@"消息-选中状态"];
     [self setupChildVc:[[YNTMineViewController alloc] init] title:@"我的" image:@"我的-未选中状态" selectedImage:@"我的-选中状态"];

}

//初始化子控制器
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    vc.tabBarItem.title = title;
    // 设置tabBar的字体颜色
    UIColor *titleHighlightedColor = [UIColor colorWithRed:50.0/255 green:160.0/255 blue:219.0/255 alpha:1];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    UIImage *img = [UIImage imageNamed:image];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.image =img ;
    
    UIImage *selImage = [UIImage imageNamed:selectedImage];
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = selImage;
   YNTNavigationViewController *nav = [[YNTNavigationViewController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
}




@end
