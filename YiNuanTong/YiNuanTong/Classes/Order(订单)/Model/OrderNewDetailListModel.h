//
//  OrderNewDetailListModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/4/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface OrderNewDetailListModel : YNTBaseModel
/**商品多属性id*/
@property (nonatomic,copy) NSString *aid;
/**商品多属性信息*/
@property (nonatomic,copy) NSString *namestr;
/**商品多属性单价*/
@property (nonatomic,copy) NSString *attrprice;
/**商品多属性数量*/
@property (nonatomic,copy) NSString *num;
/**商品多属性总价*/
@property (nonatomic,copy) NSString *xiaoprice;
@end
