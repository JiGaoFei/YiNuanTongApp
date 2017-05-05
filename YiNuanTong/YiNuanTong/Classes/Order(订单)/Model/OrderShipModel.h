//
//  OrderShipModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/4/10.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface OrderShipModel : YNTBaseModel
/**用户id*/
@property (nonatomic,copy) NSString * userid;
/**收货人*/
@property (nonatomic,copy) NSString * consignee;
/**省*/
@property (nonatomic,copy) NSString * province;
/**市*/
@property (nonatomic,copy) NSString * city;
/**区*/
@property (nonatomic,copy) NSString * area;
/**地址*/
@property (nonatomic,copy) NSString * address;
/**手机*/
@property (nonatomic,copy) NSString * mobile;
/**手机*/
@property (nonatomic,copy) NSString * address_id;
/*是否默认*/
@property (nonatomic,copy) NSString * isdefault;
@end
