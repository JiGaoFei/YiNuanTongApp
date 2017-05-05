//
//  OptionListViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"

@interface OptionListViewController : YNTBaseViewController
/**编辑成功回调*/
@property (nonatomic,copy) void(^editSuccessBlock)();

@end
