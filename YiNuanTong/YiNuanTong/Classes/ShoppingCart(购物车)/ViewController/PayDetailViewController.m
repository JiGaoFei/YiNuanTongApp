//
//  PayDetailViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/28.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "PayDetailViewController.h"
#import "YNTUITools.h"
#import "SingLeton.h"
#import "YNTNetworkManager.h"
#import "GFProgressHUD.h"
#import "YNTShopingCarViewController.h"
@interface PayDetailViewController ()

@end

@implementation PayDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];

    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
    self.tabBarController.tabBar.hidden = NO;
     NSNotification * notice = [NSNotification notificationWithName:@"paySuccess" object:nil userInfo:nil];

      [[NSNotificationCenter defaultCenter]postNotification:notice];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易详情";
    self.view.backgroundColor =RGBA(249, 249, 249, 1);
    // 加载子视图
    [self setUpChildrenViews];
    // 加载底部视图
    [self setUpBottomViews];
   
}
- (void)setUpChildrenViews
{
    // 创建底部视图
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 74*kHeightScale, KScreenW, 180 *kHeightScale)];
    bigView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bigView];
    // 创建图标
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW/ 2 - 20*kWidthScale, 20*kHeightScale, 40*kWidthScale, 40*kWidthScale)];
    imgView.image = [UIImage imageNamed:@"对勾"];
    [bigView addSubview:imgView];
    
    // 创建lab
    UILabel *creatOrderLab = [YNTUITools createLabel:CGRectMake(KScreenW/ 2  - 60 *kWidthScale , CGRectGetMaxY(imgView.frame) + 10*kHeightScale, 120 *kWidthScale, 18*kHeightScale) text:@"支付成功" textAlignment:NSTextAlignmentCenter textColor:nil bgColor:nil font:18];
    if (KScreenW == 320) {
        creatOrderLab.font = [UIFont systemFontOfSize:16];
    }
    [bigView addSubview:creatOrderLab];
    
    // 创建支付方式lab
    UILabel *orderGoodsLab = [YNTUITools createLabel:CGRectMake(116 *kPlus *kWidthScale, CGRectGetMaxY(creatOrderLab.frame) +15*kHeightScale , KScreenW - 2 *kPlus *116 *kWidthScale, 16 *kHeightScale) text:[NSString stringWithFormat:@"¥%@",self.money] textAlignment:NSTextAlignmentCenter textColor:nil bgColor:nil font:16];
    orderGoodsLab.textColor  = [UIColor redColor];
    if (KScreenW == 320) {
        orderGoodsLab.font = [UIFont systemFontOfSize:14];
    }
    [bigView addSubview:orderGoodsLab];
    
    
    // 创建即将发货lab
    UILabel *moneyLab = [YNTUITools createLabel:CGRectMake(162 *kPlus *kWidthScale   ,CGRectGetMaxY(orderGoodsLab.frame) +15 *kHeightScale , KScreenW - 2 *kPlus *162 *kWidthScale, 13 *kHeightScale) text:@"您已成功付款,我们即将为您发货!" textAlignment:NSTextAlignmentCenter textColor:CGRGray bgColor:nil font:13];
    if (KScreenW == 320) {
        moneyLab.font =[UIFont systemFontOfSize:11];
    }
    [bigView addSubview:moneyLab];
    
    
    // 创建twoBigView
    UIView *bigTwoview = [[UIView alloc]initWithFrame:CGRectMake(0, 262 *kHeightScale, KScreenW, 160 *kHeightScale)];
    bigTwoview.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bigTwoview];
      
    
    //创建订货单号lab
    UILabel *goodsOrderNameLab = [YNTUITools createLabel:CGRectMake(46 * kPlus *kWidthScale, 45 *kHeightScale, 70 *kWidthScale, 15*kHeightScale) text:@"订货单号:" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];

    if (KScreenW == 320) {
        goodsOrderNameLab.font = [UIFont systemFontOfSize:13];
    }
    [bigTwoview addSubview:goodsOrderNameLab];
    
    UILabel *goodsOrderDetailNameLab = [YNTUITools createLabel:CGRectMake((46 * kPlus+80) *kWidthScale, 45 *kHeightScale, KScreenW - (2 * kPlus*46+ 80)*kWidthScale, 14 *kHeightScale) text:@"" textAlignment:NSTextAlignmentRight textColor:CGRGray bgColor:nil font:14];
    goodsOrderDetailNameLab.text = self.orderNumber;
    if (KScreenW == 320) {
        goodsOrderDetailNameLab.font = [UIFont systemFontOfSize:12];
    }
    [bigTwoview addSubview:goodsOrderDetailNameLab];

    // 创建交易时间lab
    UILabel *goodsTimeNameLab = [YNTUITools createLabel:CGRectMake(46 * kPlus *kWidthScale, 70 *kHeightScale, 70 *kWidthScale, 15 *kHeightScale) text:@"交易时间:" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
  
    if (KScreenW == 320) {
        goodsTimeNameLab.font = [UIFont systemFontOfSize:13];
    }
    [bigTwoview addSubview:goodsTimeNameLab];
    
    UILabel *goodsTimeDetailNameLab = [YNTUITools createLabel:CGRectMake((46 * kPlus+80) *kWidthScale, 70 *kHeightScale, KScreenW -( 2 * kPlus*46 +80) *kWidthScale, 14 *kHeightScale) text:@"" textAlignment:NSTextAlignmentRight textColor:CGRGray bgColor:nil font:14];
    goodsTimeDetailNameLab.text = [self getCurrenTime];

    if (KScreenW == 320) {
        goodsTimeNameLab.font = [UIFont systemFontOfSize:12];
    }
    [bigTwoview addSubview:goodsTimeDetailNameLab];

    // 创建当前状况lab
    UILabel *goodsStatusNameLab = [YNTUITools createLabel:CGRectMake(46 * kPlus *kWidthScale, 95 *kHeightScale, 70 *kWidthScale, 15 *kHeightScale) text:@"当前状况:" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];

    if (KScreenW == 320) {
        goodsStatusNameLab.font = [UIFont systemFontOfSize:13];
    }
    [bigTwoview addSubview:goodsStatusNameLab];
    
    UILabel *goodsStatusDetailNameLab = [YNTUITools createLabel:CGRectMake((46 * kPlus+80) *kWidthScale, 95 *kHeightScale, KScreenW - (2 * kPlus*46 +80) *kWidthScale, 14 *kHeightScale) text:@"" textAlignment:NSTextAlignmentRight textColor:CGRGray bgColor:nil font:14];
    goodsStatusDetailNameLab.text = self.payStatus;
    if (KScreenW == 320) {
        goodsStatusDetailNameLab.font = [UIFont systemFontOfSize:12];
    }
    [bigTwoview addSubview:goodsStatusDetailNameLab];
    // 创建支付方式lab
    UILabel *goodsPayTypeNameLab = [YNTUITools createLabel:CGRectMake(46 * kPlus *kWidthScale, 120 *kHeightScale, 70 *kWidthScale, 15 *kHeightScale) text:@"支付方式:" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    if (KScreenW == 320) {
        goodsPayTypeNameLab.font = [UIFont systemFontOfSize:13];
    }
    [bigTwoview addSubview:goodsPayTypeNameLab];
    
    UILabel *goodsPayTypeDetailNameLab = [YNTUITools createLabel:CGRectMake((46 * kPlus+80) *kWidthScale, 120 *kHeightScale, KScreenW - (2 * kPlus*46 + 80) *kWidthScale, 14 *kHeightScale) text:@"" textAlignment:NSTextAlignmentRight textColor:CGRGray bgColor:nil font:14];
    goodsPayTypeDetailNameLab.text = self.payType;
    if (KScreenW == 320) {
        goodsPayTypeDetailNameLab.font = [UIFont systemFontOfSize:12];
    }
    [bigTwoview addSubview:goodsPayTypeDetailNameLab];

    
    

}
/**
 *创建底部视图
 */
- (void)setUpBottomViews
{
    NSLog(@"创建底部视图");
    UIButton *buyBtn = [YNTUITools createButton:CGRectMake(0, kScreenH - 55 *kHeightScale, KScreenW, 55 *kHeightScale) bgColor:CGRBlue title:@"再次购买" titleColor:[UIColor whiteColor] action:@selector(buyBtnAction:) vc:self];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    if (KScreenW == 320) {
        buyBtn.titleLabel.font = [UIFont systemFontOfSize:17];

    }
    [self.view addSubview:buyBtn];
}
#pragma mark - 发送按钮的点击事件
- (void)buyBtnAction:(UIButton *)sender
{
    NSLog(@"再次购买");
    NSString *url = [NSString stringWithFormat:@"%@api/order.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":self.order_id,@"act":@"zaimai"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [GFProgressHUD showSuccess:responseObject[@"msg"]];
            YNTShopingCarViewController *shopCarVC = [[YNTShopingCarViewController alloc]init];
            [self.navigationController pushViewController:shopCarVC animated:YES];
        }
       
        NSLog(@"支付完成再次购买请求成功%@",responseObject);
        
        
    } enError:^(NSError *error) {
        NSLog(@"支付完成再次购买请求失败%@",error);


    }];
    
}
- (NSString *)getCurrenTime
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
