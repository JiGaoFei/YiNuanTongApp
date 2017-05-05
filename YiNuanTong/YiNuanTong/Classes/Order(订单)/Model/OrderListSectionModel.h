//
//  OrderListSectionModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface OrderListSectionModel : YNTBaseModel
/**商品id */
@property (nonatomic,copy) NSString *good_id;
/**订单编号*/
@property (nonatomic,copy) NSString *sn;
/**价格*/
@property (nonatomic,copy) NSString *price;
/**下单时间*/
@property (nonatomic,copy) NSString *done_time;
/**订单状态*/
@property (nonatomic,copy) NSString *status;
/**支付状态*/
@property (nonatomic,copy) NSString *pay_status;
/**物流状态*/
@property (nonatomic,copy) NSString *shipping_status;
/**种数*/
@property (nonatomic,copy) NSString *zhong_num;
/**总件数*/
@property (nonatomic,copy) NSString *all_num;
/**订单总状态*/
@property (nonatomic,copy) NSString *ord_status;
/**数据*/
@property (nonatomic,strong) NSMutableArray *goods;
/**存放分区中的model*/
@property (nonatomic,strong) NSMutableArray *modelArr;
/** 是否展开 */
@property (nonatomic,assign) BOOL isOpen;

- (instancetype)init;
@end
