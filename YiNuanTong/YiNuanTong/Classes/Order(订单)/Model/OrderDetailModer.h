//
//  OrderDetailModer.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/14.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface OrderDetailModer : YNTBaseModel
/**公司名字*/
@property (nonatomic,strong) NSString  * companyname;
/**订单id*/
@property (nonatomic,strong) NSString  * order_id;
/**订单编号*/
@property (nonatomic,strong) NSString  * sn;
/**用户id*/
@property (nonatomic,strong) NSString  * userid;
/**订单状态*/
@property (nonatomic,strong) NSString  * status;
/**支付状态*/
@property (nonatomic,strong) NSString  * pay_status;
/**物流状态*/
@property (nonatomic,strong) NSString  * shipping_status;
/**快递名字*/
@property (nonatomic,strong) NSString  *shipping_name;
/**快递单号*/
@property (nonatomic,strong) NSString  *shipping_sn;
/**物流费用*/
@property (nonatomic,strong) NSString  *shipping_fee;
/**物流时间*/
@property (nonatomic,strong) NSString  *shipping_time;
/**收货人名字*/
@property (nonatomic,strong) NSString  * consignee;
/**地址*/
@property (nonatomic,strong) NSString  * address;
/**邮编*/
@property (nonatomic,strong) NSString  * zipcode;
/**固定电话*/
@property (nonatomic,strong) NSString  * tel;
/**手机*/
@property (nonatomic,strong) NSString  *mobile;

/**支付方式(如微信支付宝)id*/
@property (nonatomic,strong) NSString  *pay_id;
/**支付方式名称*/
@property (nonatomic,strong) NSString  *pay_name;
/**下单时间*/
@property (nonatomic,strong) NSString  *add_time;
/**商品总额 */
@property (nonatomic,strong) NSString  *amount;
/**支付金额*/
@property (nonatomic,strong) NSString  *pay_fee;

/**确认收货时间*/
@property (nonatomic,strong) NSString  *accept_time;
/**提交确认时间*/
@property (nonatomic,strong) NSString  *confirm_time;
/**订单总额(以这个为主支付)*/
@property (nonatomic,strong) NSString  *order_amount;
/**下单时间*/
@property (nonatomic,strong) NSString  *pay_code;
/**打折*/
@property (nonatomic,strong) NSString  *discount;
/**积分*/
@property (nonatomic,strong) NSString  *point;
/**备注*/
@property (nonatomic,strong) NSString  *note;

/**商品数量*/
@property (nonatomic,strong) NSString  *goodsnum;
/**是否评论*/
@property (nonatomic,strong) NSString  *iscomment;

@end
