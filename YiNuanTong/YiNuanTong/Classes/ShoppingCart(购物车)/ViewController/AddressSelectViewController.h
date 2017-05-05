//
//  AddressSelectViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/2/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"
@class MineAddressModel;
@interface AddressSelectViewController : YNTBaseViewController
/**用于传值*/
@property (nonatomic,copy) void(^settingAdress)(MineAddressModel *model);
@end
