//
//  OrderModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/10.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface OrderModel : YNTBaseModel

/**下单时间*/
@property (nonatomic,strong) NSString  *add_time;
/**商品数量*/
@property (nonatomic,strong) NSString *goodsnum;
/**订单id*/
@property (nonatomic,strong) NSString  *order_id ;
/**订单编号*/
@property (nonatomic,strong) NSString * sn;
/**订单状态*/
@property (nonatomic,strong) NSString  *status ;
/**支付费用*/
@property (nonatomic,strong) NSString  * order_amount;
/**申请退换货处理状态*/
@property (nonatomic,copy) NSString * returnstatus;

@end
