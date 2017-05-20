//
//  OrderNewCompleteViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/8.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewCompleteViewController.h"
#import "YNTUITools.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "PayDetailViewController.h"
#import "HomeGoodListSingLeton.h"
@interface OrderNewCompleteViewController ()

@end

@implementation OrderNewCompleteViewController
#pragma mark -生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 加载自定义视图
    [self setUpChildrenViews];
   

    // Do any additional setup after loading the view.
}

#pragma mark - 自定义视图
- (void)setUpChildrenViews
{
    // 创建navView
    UIView *navtitleView = [[UIView alloc]initWithFrame:CGRectMake(74 *kWidthScale, 0, 170 *kWidthScale, 13 *kHeightScale)];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 170 *kWidthScale, 13 *kHeightScale)];
    imgView.image = [UIImage imageNamed:@"succeed"];
    [navtitleView addSubview:imgView];
    self.navigationItem.titleView = navtitleView;
    // 创建订单编号:
    UILabel *orderSnLab = [YNTUITools createLabel:CGRectMake(16 *kWidthScale, 80 *kHeightScale, 240 *kWidthScale, 16*kHeightScale) text:[NSString stringWithFormat:@"订单编号: %@" ,self.payDic[@"sn"]] textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:16*kHeightScale];
    [self.view addSubview:orderSnLab];
    
    // 创建订单金额:
    UILabel *orderMoneyLab = [YNTUITools createLabel:CGRectMake(16 *kWidthScale, 105 *kHeightScale, 240 *kWidthScale, 16*kHeightScale) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:16*kHeightScale];
    
    double money = [self.payDic[@"price"]  doubleValue];
    orderMoneyLab.text = [NSString stringWithFormat:@"应付金额:  %.2f",money];
    
    [self.view addSubview:orderMoneyLab];
    // 创建订单支付方式:
    UILabel *orderPayLab = [YNTUITools createLabel:CGRectMake(16 *kWidthScale, 131 *kHeightScale, 240 *kWidthScale, 16*kHeightScale) text:[NSString stringWithFormat:@"支付方式: %@",self.payDic[@"payname"]] textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:16*kHeightScale];
    [self.view addSubview:orderPayLab];
    // 创建线
    UILabel *linLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 161 *kHeightScale, KScreenW, 1)];
    linLab.backgroundColor = [UIColor grayColor];
    [self.view addSubview:linLab];
    
    // 付款按钮
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(15 *kWidthScale, 175 *kHeightScale, KScreenW - 30 *kWidthScale, 45 *kHeightScale);
    [payBtn setBackgroundImage:[UIImage imageNamed:@"pay_now"] forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    
    
    // 图片
    UIImageView *bagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15 *kWidthScale, 235 *kHeightScale, KScreenW - 30 *kWidthScale, 148 *kHeightScale)];
    bagImageView.image = [UIImage imageNamed:@"attention"];
    [self.view addSubview:bagImageView];
    
    // 客服电话
    UILabel *customLab = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 390 *kHeightScale, KScreenW - 30 *kWidthScale, 17*kHeightScale) text:[NSString stringWithFormat:@"客服电话:%@",self.kefu] textAlignment:NSTextAlignmentLeft textColor:RGBA(49, 49, 49, 1) bgColor:nil font:15 *kHeightScale];
    [self.view addSubview:customLab];
    
}
- (void)payBtnAction:(UIButton *)sender
{
    HomeGoodListSingLeton *singLetong = [HomeGoodListSingLeton shareHomeGoodListSingLeton];
    singLetong.dic = self.payDic;
    PayDetailViewController *payDetailVC = [[PayDetailViewController alloc]init];
    
    payDetailVC.orderNumber = self.payDic[@"sn"];
    if ([[NSString stringWithFormat:@"%@",self.payDic[@"status"]] isEqualToString:@"1"]) {
        payDetailVC.payStatus = @"支付成功";
    }
    payDetailVC.payType = self.payDic[@"payname"];
    payDetailVC.money = self.payDic[@"price"];
    payDetailVC.order_id = self.payDic[@"order_id"];
    NSLog(@"立即付款");
           if ([self.pay_id isEqualToString:@"2"]) {
        // 支付宝支付
        NSString *sign = self.payDic[@"sign"];
               
              [self doAlipayPay:sign];
          //  [self.navigationController popViewControllerAnimated:YES];
         
         //      [self.navigationController pushViewController:payDetailVC animated:YES];
               
   

    }
    if ([self.pay_id isEqualToString:@"1"]) {
        // 微信支付
        NSDictionary *data = self.payDic[@"sign"];

        [self WXZhiFUWith:data];
                 //  [self.navigationController popViewControllerAnimated:YES];

       
    }

    
 
}


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

  
   
    
    
}

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
    order.biz_content.body = @"1暖通商城订单支付";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no =self.payDic[@"sn"];//订单ID（由商家自行制定）
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
            
          
    
            
            
            
            
        }];
        
    }
    
    
    
    
    
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
