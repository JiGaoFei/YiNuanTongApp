//
//  PayOderViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "PayOderViewController.h"
#import "YNTUITools.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "YNTNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "PayDetailViewController.h"



#define ALI_DEMO_BUTTON_WIDTH  (([UIScreen mainScreen].bounds.size.width) - 40.0f)
#define ALI_DEMO_BUTTON_HEIGHT (60.0f)
#define ALI_DEMO_BUTTON_GAP    (30.0f)


#define ALI_DEMO_INFO_HEIGHT (200.0f)



@interface PayOderViewController ()<WXApiDelegate>
/**是否选中alipay*/
@property (nonatomic,assign) BOOL isAlipay;
/**是否选中weChate*/
@property (nonatomic,assign) BOOL isWeChat;
/**alipayBtn*/
@property (nonatomic,strong) UIButton  * alipayBtn;
/**weChatBtn*/
@property (nonatomic,strong) UIButton  * weChatBtn;
@end

@implementation PayOderViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.tabBarController.tabBar.hidden = YES;
    self.isAlipay = NO;
    self.isWeChat = NO;
  
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单付款";
    self.view.backgroundColor = RGBA(249, 249, 249, 1);
    // 加载子视图
    [self setUpChildrenViews];
    // 创建底部视图
    [self setUpBottomViews];
}
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    //创建titleLab
    NSString *title = [NSString stringWithFormat:@"请您及时付款,以便尽快处理!在线支付金额:%@",self.order_amount];
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(42 *kPlus, 74, KScreenW - 42 * 2 *kPlus, 11) text:title textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:11];
    [self.view addSubview:titleLab];
    
    UIView *bigOneView = [[UIView alloc]initWithFrame:CGRectMake(0, 85, KScreenW, 100)];
    bigOneView.backgroundColor = [UIColor whiteColor];
    // 订单编号lab
    UILabel *orderLab = [YNTUITools createLabel:CGRectMake(42 *kPlus, 10, 80, 15) text:@"订单编号" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    [bigOneView addSubview:orderLab];
 
    UILabel *orderDetailLab = [YNTUITools createLabel:CGRectMake(42 *kPlus+80, 12, 200, 13) text:self.order_sn textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    [bigOneView addSubview:orderDetailLab];
    
    
    //支付方式lab
    UILabel *payLab = [YNTUITools createLabel:CGRectMake(42 *kPlus, 35, 80, 15) text:@"支付方式" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    
    [bigOneView addSubview:payLab];
    UILabel *payDetailLab = [YNTUITools createLabel:CGRectMake(42 *kPlus+80, 37, 150, 13) text:@"在线支付" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    [bigOneView addSubview:payDetailLab];
    
    //物流lab
    UILabel *transportLab = [YNTUITools createLabel:CGRectMake(42 *kPlus, 60, 80, 15) text:@"物  流" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    [bigOneView addSubview:transportLab];
    UILabel *transportDetailLab = [YNTUITools createLabel:CGRectMake(42 *kPlus+80, 62, 150, 13) text:@"德邦物流" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    [bigOneView addSubview:transportDetailLab];



    
    
    [self.view addSubview:bigOneView];
    
    
    
    
    
    // 创建第二个view
    UIView *bigTwoView = [[UIView alloc]initWithFrame:CGRectMake(0, 195, KScreenW, 105)];
    bigTwoView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bigTwoView];
    // 创建支付选择方式lab
    //创建titleLab
    UILabel *payTypeLab= [YNTUITools createLabel:CGRectMake(42 *kPlus, 20, 100, 15) text:@"选择支付方式" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    
    [bigTwoView addSubview:payTypeLab];
    //账户余额lab
    UIImageView *accountImgView = [YNTUITools createImageView:CGRectMake(42 *kPlus, 45, 15, 15) bgColor:nil imageName:@"余额"];
    [bigTwoView addSubview:accountImgView];
    UILabel *accountLab = [YNTUITools createLabel:CGRectMake(42 *kPlus + 17, 45, 60, 15) text:@"账户余额" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:14];
    [bigTwoView addSubview:accountLab];
    //信用币lab
    UIImageView *creditImgView = [YNTUITools createImageView:CGRectMake(42 *kPlus, 75, 15, 15) bgColor:nil imageName:@"信用币"];
    [bigTwoView addSubview:creditImgView];
    UILabel *creditLab = [YNTUITools createLabel:CGRectMake(42 *kPlus + 17, 75, 60, 15) text:@"信用币" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:14];
    [bigTwoView addSubview:creditLab];

    // 创建第三个view
    UIView *bigThreeView = [[UIView alloc]initWithFrame:CGRectMake(0, 310, KScreenW, 145)];
    bigThreeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bigThreeView];

    //创建titleLab
    UILabel *morePayTypeLab= [YNTUITools createLabel:CGRectMake(42 *kPlus, 20, 100, 15) text:@"更多支付选择" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    [bigThreeView addSubview:morePayTypeLab];
    //支付宝lab
    UIImageView *aliPayView = [YNTUITools createImageView:CGRectMake(42 *kPlus, 45, 15, 15) bgColor:nil imageName:@"支付宝"];
    [bigThreeView addSubview:aliPayView];
    UILabel *aliPayLab = [YNTUITools createLabel:CGRectMake(42 *kPlus + 17, 45, 60, 15) text:@"支付宝" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:14];
    [bigThreeView addSubview:aliPayLab];
    
    UIButton *aliPayBtn = [YNTUITools createButton:CGRectMake(335 *kWidthScale, 45, 32 *kPlus, 32 *kPlus) bgColor:nil title:nil titleColor:nil action:@selector(aliPayBtnAction:) vc:self];
    self.alipayBtn = aliPayBtn;
    UIImage *aliPayBtnImg = [UIImage imageNamed:@"未勾选"];
    aliPayBtnImg = [aliPayBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [aliPayBtn setImage:aliPayBtnImg forState:UIControlStateNormal];
    
    [bigThreeView addSubview:aliPayBtn];
    //微信lab
    UIImageView *weChatImgView = [YNTUITools createImageView:CGRectMake(42 *kPlus, 75, 15, 15) bgColor:nil imageName:@"微信"];
    [bigThreeView addSubview:weChatImgView];
    UILabel *weChatLab = [YNTUITools createLabel:CGRectMake(42 *kPlus + 17, 75, 60, 15) text:@"微信" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:14];
    [bigThreeView addSubview:weChatLab];
    
    
    UIButton *weChatBtn = [YNTUITools createButton:CGRectMake(335 *kWidthScale, 75, 32 *kPlus, 32 *kPlus) bgColor:nil title:nil titleColor:nil action:@selector(weChatBtnImgAction:) vc:self];
    self.weChatBtn = weChatBtn;
    UIImage *weChatBtnImg = [UIImage imageNamed:@"未勾选"];
    weChatBtnImg = [weChatBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [weChatBtn setImage:weChatBtnImg forState:UIControlStateNormal];
    
    [bigThreeView addSubview:weChatBtn];

    //银联lab
    UIImageView *yinLianImgView = [YNTUITools createImageView:CGRectMake(42 *kPlus, 105, 15, 15) bgColor:nil imageName:@"银行卡"];
    [bigThreeView addSubview:yinLianImgView];
    UILabel *yinLianLab = [YNTUITools createLabel:CGRectMake(42 *kPlus + 17, 105, 60, 15) text:@"银行卡" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:14];
    [bigThreeView addSubview:yinLianLab];

}

// 支付宝点击事件
- (void)aliPayBtnAction:(UIButton *)sender
{
    
       NSLog(@"支付宝被勾选");
    if (self.isAlipay) {
        UIImage *aliPayBtnImg = [UIImage imageNamed:@"未勾选"];
        aliPayBtnImg = [aliPayBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [sender setImage:aliPayBtnImg forState:UIControlStateNormal];
        self.isAlipay = NO;

    }else{
        UIImage *aliPayBtnImg = [UIImage imageNamed:@"勾选"];
        aliPayBtnImg = [aliPayBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [sender setImage:aliPayBtnImg forState:UIControlStateNormal
         ];
        self.isAlipay = YES;
        self.isWeChat = NO;
        UIImage *weChatBtnImg = [UIImage imageNamed:@"未勾选"];
        weChatBtnImg = [weChatBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.weChatBtn setImage:weChatBtnImg forState:UIControlStateNormal];

        

    }
    
    
}
// 微信支付的点击事件
- (void)weChatBtnImgAction:(UIButton *)sender
{
    NSLog(@"微信支付点击事件");
    if (self.isWeChat) {
        UIImage *weChatBtnImg = [UIImage imageNamed:@"未勾选"];
        weChatBtnImg = [weChatBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [sender setImage:weChatBtnImg forState:UIControlStateNormal];
        self.isWeChat = NO;

    }else{
        UIImage *weChatBtnImg = [UIImage imageNamed:@"勾选"];
        weChatBtnImg = [weChatBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [sender setImage:weChatBtnImg forState:UIControlStateNormal];
        self.isWeChat = YES;
        self.isAlipay = NO;
        UIImage *aliPayBtnImg = [UIImage imageNamed:@"未勾选"];
        aliPayBtnImg = [aliPayBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self.alipayBtn setImage:aliPayBtnImg forState:UIControlStateNormal];


    }
}
/**
 *创建底部视图
 */
- (void)setUpBottomViews
{
    NSLog(@"创建底部视图");
    UIButton *confirmBtn = [YNTUITools createButton:CGRectMake(0, kScreenH - 55 *kHeightScale, KScreenW, 55*kHeightScale) bgColor:CGRBlue title:@"确认支付" titleColor:[UIColor whiteColor] action:@selector(confirmBtnAction:) vc:self];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    if (KScreenW == 320) {
        confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17];

    }
    [self.view addSubview:confirmBtn];
}
#pragma mark - 发送按钮的点击事件
- (void)confirmBtnAction:(UIButton *)sender
{
    NSLog(@"我确认支付");
  
    
    if (!self.isAlipay &&!self.isWeChat) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"请选择一种支付方式!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
      
        
          }
    if (self.isAlipay) {
        
        
//        [self doAlipayPay:@"app_id=2017010204801650&biz_content=%7B%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22subject%22%3A+%22App%E6%94%AF%E4%BB%98%E6%B5%8B%E8%AF%95%22%2C%22out_trade_no%22%3A+%2220170125test1489221342%22%2C%22timeout_express%22%3A+%2230m%22%2C%22total_amount%22%3A+%220.01%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fwww.longxiangkeji.cn&sign_type=RSA&timestamp=2017-03-11+16%3A35%3A42&version=1.0&sign=VGvRkQ7z9cabBzjHXUc3gtFdy6iDs9PYGr%2BvUx2wxiEdJNWSr0iAEGHg6KPtwsRWKSnfxTO1LIBvBJDrl84A%2FK915K38BYw%2BqMWEPgiPM2bEycmoPfStonK8T3%2FSP%2BtaKCE5%2BJuoqquoG64Z3cesvOjMxrF6myTcpFbwgr0JNhI%3D"];
      //   [self doAlipayPay:@"app_id=2017010204801650&biz_content=%7B%22body%22%3A%22%E6%88%91%E6%98%AF%E6%B5%8B%E8%AF%95%E6%95%B0%E6%8D%AE%22%2C%22subject%22%3A+%22App%E6%94%AF%E4%BB%98%E6%B5%8B%E8%AF%95%22%2C%22out_trade_no%22%3A+%2220170125test1489221516%22%2C%22timeout_express%22%3A+%2230m%22%2C%22total_amount%22%3A+%220.01%22%2C%22product_code%22%3A%22QUICK_MSECURITY_PAY%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=http%3A%2F%2Fwww.longxiangkeji.cn&sign_type=RSA&timestamp=2017-03-11+16%3A38%3A36&version=1.0&sign=WZADxGcD6NsABND6aTm%2B9P3LKAOyHNcjpWH3hbp0DeQVX5WjAzUlIpUzDgziC8KEOJ3ptiic6kf0wfx4Vn1kduGEF0wLS3grdb5bh0WY3B5OkB4HLyj7HIz%2FL9bgO2%2FfsKue1KwbRswsKdmM%2FF9TYd2LNP96V2JayJ9Y6y%2BY3oo%3D"];

        
        NSString *appID = @"2017010204801650";
        
        /*
         *生成订单信息及签名
         */
        //将商品信息赋予AlixPayOrder的成员变量
        Order* order = [Order new];
        
        // NOTE: app_id设置
        order.app_id = appID;
        
        // NOTE: 支付接口名称
        order.method = @"alipay.trade.app.pay";
        
        // NOTE: 参数编码格式
        order.charset = @"utf-8";
        
        order.biz_content.seller_id = @"2088021865511731";
        // NOTE: 当前时间点
        NSDateFormatter* formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        order.timestamp = [formatter stringFromDate:[NSDate date]];
        
        // NOTE: 支付版本
        order.version = @"1.0";
        
        // NOTE: 商品数据
        order.biz_content = [BizContent new];
        order.biz_content.body = @"我是测试数据";
        order.biz_content.subject = @"1";
        order.biz_content.out_trade_no =self.order_sn; //订单ID（由商家自行制定）
        order.biz_content.timeout_express = @"30m"; //超时时间设置
        order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
        
        // 返回订单结果
        order.return_url = @"m.alipay.com";
        
        //将商品信息拼接成字符串
        NSString *orderInfo = [order orderInfoEncoded:NO];
        NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
        NSLog(@"orderSpec = %@",orderInfo);
        NSLog(@"orderSpec = %@",orderInfoEncoded);
        

        NSLog(@"选择的是支付宝支付");

        UserInfo *userInfo = [UserInfo currentAccount];
        NSString *url = [NSString stringWithFormat:@"%@alipay2/amount.php", baseUrl];
   
        NSDictionary *params = @{@"user_id":userInfo.user_id,@"order_id":self.order_id,@"goodinfo":orderInfo};
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
            
            NSLog(@"支付接口成功%@",responseObject);
            
            
            [self doAlipayPay:responseObject[@"sign"]];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        } enError:^(NSError *error) {
            NSLog(@"支付接口%@",error);
        }];
        

    }
    if (self.isWeChat) {
        NSLog(@"选择的是微信支付");
      
//        NSDictionary *data = @{
//                               @"appid": @"wxc4cf6018a3b7aacf",
//                               @"noncestr": @"9zy4v6oygufzflkresb7chqw8z9i3f6m",
//                               @"package": @"Sign=WXPay",
//                               @"partnerid": @"1441217802",
//                               @"prepayid": @"wx20170309105005cc9fa1ba090052911399",
//                               @"timestamp": @"1489027806",
//                               @"sign": @"d985e3a9d91038e786ab3051ba30f076"};
//        [self WXZhiFUWith:data];
//        

     //   [self WXPayWith:@"kjkjklj"];
    UserInfo *userInfo = [UserInfo currentAccount];
        // 记得要改
        NSString *url = [NSString stringWithFormat:@"%@api/wxpay/index.php",baseUrl];
       
   NSDictionary *params = @{@"user_id":userInfo.user_id,@"order_id":self.order_id};
        
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
    
            NSLog(@"微信支付请求数据成功%@",responseObject);
        

//            NSDictionary *data = @{
//                                   @"appid": @"wxd930ea5d5a258f4f",
//                                   @"noncestr": @"a462b76e7436e98e0ed6e13c64b4fd1c",
//                                   @"package": @"Sign=WXPay",
//                                   @"partnerid": @"10000100",
//                                   @"prepayid": @"1101000000140415649af9fc314aa427",
//                                   @"timestamp": @"1397527777",
//                                   @"sign": @"582282D72DD2B03AD892830965F428CB16E7A256"};
            //              NSString *code = responseObject[@"code"];
             NSString *code = responseObject[@"code"];
            
            if ( [code integerValue] == 1) {
                NSDictionary *data = responseObject;
                [self WXZhiFUWith:data];

           }else{
               [GFProgressHUD showFailure:@"微信支付出错!"];
                
            }

            } enError:^(NSError *error) {
            NSLog(@"微信支付请求数据失败%@",error);
        }];
        
        
    }

    
}




#pragma mark -
#pragma mark   ==============点击订单模拟支付行为==============
- (void)doAlipayPay:(NSString *)signedString
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2017010204801650";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqmDCjnR0Bwq7luyFAcobjc/43o6BlSld9GUb17jIXzFY7n82IRyI2J766KEt9h+MY7jJx7jLVlfSkrmFa8WWZKaS2xCvC5jTmI0GUcxp8PXjfQkBHRjqoL/9gY1njhGaThaoI6mXF2VEQAajNceJUDtMeGw0xjNxOzmS0JJycoYM5ei/XVh0XozrGmIwF3R6VEsZ47w/3HkWiap3Lqu4sWKOqPE/33nr/if/3shDq2xfPwTCGScOj9u17SIdLU5tKT/qM+abmiXNB4MLcQeB3uCZjOE67kDiKo0Ad0MlwGZ4wCb1K720TUbDkvfQTShQIHXnioqka4PYwwq1PT+n+wIDAQAB";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"缺少appId或者私钥" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
        
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    order.biz_content.seller_id = @"2088021865511731";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
     order.biz_content.out_trade_no =self.order_sn;//订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    // 返回订单结果
    order.return_url = @"m.alipay.com";
    
    //将商品信息拼接成字符串
//    NSString *orderInfo = [order orderInfoEncoded:NO];
//    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
//    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
   // NSString *signedString = nil;
//    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
//    if ((rsa2PrivateKey.length > 1)) {
//        signedString = [signer signString:orderInfo withRSA2:YES];
//    } else {
//        signedString = [signer signString:orderInfo withRSA2:NO];
//    }
// 
     // NOTE: 如果加签成功，则继续执行支付
     if (signedString != nil) {
     //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
     // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
     NSString *orderString = [NSString stringWithFormat:@"%@&sign",
   signedString];
         
         // NOTE: 调用支付结果开始支付
         [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"YiNuanTong" callback:^(NSDictionary *resultDic) {
             
             NSLog(@"支付页面reslut = %@",resultDic);
             
       
            // 提取支付结果字符串
             NSDictionary *returnDic =  [self stringToJson:resultDic[@"result"]];
         
          NSDictionary *dataDic = returnDic[@"alipay_trade_app_pay_response"];
             
          
             NSLog(@"支付码:%@",dataDic[@"code"]);
              NSLog(@"支付结果:%@",dataDic[@"msg"]);
              NSLog(@"支付appid:%@",dataDic[@"app_id"]);
              NSLog(@"支付授权auth_app_id:%@",dataDic[@"auth_app_id"]);
              NSLog(@"支付时间:%@",dataDic[@"timestamp"]);
              NSLog(@"支付费用:%@",dataDic[@"total_amount"]);
              NSLog(@"支付交易码trade_no:%@",dataDic[@"trade_no"]);
              NSLog(@"支付编号:%@",dataDic[@"out_trade_no"]);
              NSLog(@"支付seller_id:%@",dataDic[@"seller_id"]);
             
             //创建一个消息对象
             NSNotification * notice = [NSNotification notificationWithName:@"aliPayReslut" object:nil userInfo:dataDic];
             //发送消息
             [[NSNotificationCenter defaultCenter]postNotification:notice];
//             PayDetailViewController *payDetailViewVC = [[PayDetailViewController alloc]init];
//             // 没有商品名称
//             payDetailViewVC.shopName =@"测试数据";
//             payDetailViewVC.orderNumber =dataDic[@"out_trade_no"];
//             payDetailViewVC.tradingTime =dataDic[@"timestamp"];
//             payDetailViewVC.payStatus = @"已支付";
//             payDetailViewVC.payType = @"支付宝";
//             [[NSNotificationCenter defaultCenter]postNotificationName:@"aliPayReslut" object:nil userInfo:resultDic];
//             
          
             
  
         }];
         
     }
 
    
    
 
    
}





#pragma mark 微信支付方法
- (void)WXZhiFUWith:(id) data{
    
    //需要创建这个支付对象
    PayReq *req   = [[PayReq alloc] init];
    // 由用户微信号和AppID组成的唯一标识，用于校验微信用户
      req.openID = @"wxc4cf6018a3b7aacf";

    // 商家id，在注册的时候给的
    req.partnerId = [data objectForKey:@"partnerid"];
    

    
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId  = [data objectForKey:@"prepayid"];
    
    // 根据财付通文档填写的数据和签名
    //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
    req.package   = @"Sign=WXPay";
    
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr  = [data objectForKey:@"noncestr"];
    
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = [data objectForKey:@"timestamp"];
    req.timeStamp = stamp.intValue;
    
    // 这个签名也是后台做的
    req.sign = [data objectForKey:@"sign"];
      
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:req];
    
    NSDictionary *params = @{@"order_id":self.order_id};
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"wexinResult" object:nil userInfo:params];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];

    
}


#pragma mark - 微信支付代理

-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:{
                strMsg = @"恭喜您，支付成功!";
                
               // [MYNotificationCenter postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"success"}];
                
                break;
            }
            case WXErrCodeUserCancel:{
                strMsg = @"已取消支付!";
               // [MYNotificationCenter postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"cancle"}];
                break;
            }
            default:{
                
                strMsg = [NSString stringWithFormat:@"支付失败 !"];
             //   [MYNotificationCenter postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"cancle"}];
                break;
            }
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
    }

}



// 字典转json字符串方法

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
#pragma mark - 处理支付宝支付结果
- (NSDictionary *)stringToJson:(NSString *)str
{
  
    NSString *requestTmp = [NSString stringWithString: str];
    
    NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
    return resultDic;
    }
@end
