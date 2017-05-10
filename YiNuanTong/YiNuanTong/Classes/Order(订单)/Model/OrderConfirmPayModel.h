//
//  OrderConfirmPayModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/5/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderConfirmPayModel : NSObject
/**支付id*/
@property (nonatomic,strong) NSString *payid;
/**支付名称*/
@property (nonatomic,strong) NSString *name;
/**支付图标*/
@property (nonatomic,strong) NSString *logo;
/**是否选中*/
@property (nonatomic,assign) BOOL isSelect;
/** 是否勾选 */
@property (nonatomic,assign) BOOL check;


@end
