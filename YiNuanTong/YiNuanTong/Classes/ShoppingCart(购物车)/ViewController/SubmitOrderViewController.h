//
//  SubmitOrderViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"

@interface SubmitOrderViewController : YNTBaseViewController
/**订单编号*/
@property (nonatomic,strong) NSString  * order_sn;
/**订单id*/
@property (nonatomic,strong) NSString  * order_id;
/**订单金额*/
@property (nonatomic,strong) NSString  * order_amount;
@end
