//
//  OrderNewDetailViewController.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"

@interface OrderNewDetailViewController : YNTBaseViewController
/**属性传值*/
@property (nonatomic,copy) NSString *good_id;
/**订单状态用来控制是否可以修改地址*/
@property (nonatomic,copy) NSString *orderPostStatus;
/**回调刷新*/
@property (nonatomic,copy) void(^operationSuccessBlock)();
/**常购回调设置尺寸*/
@property (nonatomic,copy) void(^oftenSettingTableBlock)();
@end
