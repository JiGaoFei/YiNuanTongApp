//
//  AddressEditViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/2/16.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"
@class MineAddressModel;
@interface AddressEditViewController : YNTBaseViewController
/**用于属性传值*/
@property (nonatomic,strong) MineAddressModel  * model;
/**添加成功后的回调*/
@property (nonatomic,copy) void (^addSuccess)();
@end
