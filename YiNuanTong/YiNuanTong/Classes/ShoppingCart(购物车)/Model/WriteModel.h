//
//  WriteModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/20.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface WriteModel : YNTBaseModel
/**详细地址*/
@property (nonatomic,copy) NSString *address;
/**收货人*/
@property (nonatomic,copy) NSString *consignee;
/**手机号*/
@property (nonatomic,copy) NSString *mobile;
/**省市*/
@property (nonatomic,copy) NSString *shengshi;
/**地址id*/
@property (nonatomic,strong) NSString  * address_id;


@end
