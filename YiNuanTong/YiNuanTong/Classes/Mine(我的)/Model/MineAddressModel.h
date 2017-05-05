//
//  MineAddressModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/10.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface MineAddressModel : YNTBaseModel


/**用户id*/
@property (nonatomic,copy) NSString  *userid ;
/**收货人*/
@property (nonatomic,copy) NSString  *consignee ;
/**邮箱*/
@property (nonatomic,copy) NSString  *email ;

/**省*/
@property (nonatomic,copy) NSString  *province ;
/**城市*/
@property (nonatomic,copy) NSString  *city ;
/**区*/
@property (nonatomic,copy) NSString  *area ;
/**电话*/
@property (nonatomic,copy) NSString  *tel ;
/**手机*/
@property (nonatomic,copy) NSString  *mobile ;
/**是否是默认*/
@property (nonatomic,copy) NSString  *isdefault;
/***/
@property (nonatomic,copy) NSString  *zipcode;
/**地址*/
@property (nonatomic,copy) NSString  *address ;
/**地址id*/
@property (nonatomic,copy) NSString  * address_id;


@property (nonatomic,assign) BOOL  isSelected;

@end
