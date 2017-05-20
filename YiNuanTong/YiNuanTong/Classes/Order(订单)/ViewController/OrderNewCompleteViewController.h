//
//  OrderNewCompleteViewController.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/8.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"

@interface OrderNewCompleteViewController : YNTBaseViewController
/**提交订单传值*/
@property (nonatomic,strong) NSDictionary  *payDic;
@property (nonatomic,copy) NSString *pay_id;
/**客服电话**/
@property (nonatomic,copy) NSString *kefu;
@end
