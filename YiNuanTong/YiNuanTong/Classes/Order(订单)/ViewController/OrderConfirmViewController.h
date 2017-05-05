//
//  OrderConfirmViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"

@interface OrderConfirmViewController : YNTBaseViewController
/**确认订单数据源*/
@property (nonatomic,strong) NSDictionary *confirmDataDic;
/**是否是直接购买*/
@property (nonatomic,copy) NSString *directbuy;

@end
