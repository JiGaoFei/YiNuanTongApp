//
//  AddressViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"
@class OrderShipModel;
@interface AddressViewController : YNTBaseViewController
/**是否直接购买*/
@property (nonatomic,copy) NSString *directbuy;
/**回调配送id*/
@property (nonatomic,copy) void (^confirmBlockShipiing_id)(OrderShipModel *model);

@end
