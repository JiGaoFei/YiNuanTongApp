//
//  AccountModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/3/14.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface AccountModel : YNTBaseModel
/**支付时间*/
@property (nonatomic,copy) NSString *add_time;
/**支付金额*/
@property (nonatomic,copy) NSString *amount;
/**订单编号*/
@property (nonatomic,copy) NSString *sn;
/**订单id*/
@property (nonatomic,copy) NSString *order_id;

@end
