//
//  PayDetailViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/28.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"

@interface PayDetailViewController : YNTBaseViewController
/**商品名称*/
@property (nonatomic,copy) NSString *shopName;
/**订货单号*/
@property (nonatomic,copy) NSString *orderNumber;
/**交易时间*/
@property (nonatomic,copy) NSString * tradingTime;
/**支付状态*/
@property (nonatomic,copy) NSString * payStatus;
/**支付方式*/
@property (nonatomic,copy) NSString * payType;
/**支付方金额*/
@property (nonatomic,copy) NSString * money;
/**订单id*/
@property (nonatomic,copy) NSString *order_id;


@end
