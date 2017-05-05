//
//  AddAddressViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"

@interface AddAddressViewController : YNTBaseViewController
/**添加成功后的回调*/
@property (nonatomic,copy) void (^addSuccess)();

@end
