//
//  HomeGoodsDetailSizeModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/2/10.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface HomeGoodsDetailSizeModel : YNTBaseModel
/**规格id*/
@property (nonatomic,strong) NSString  * attr_id;
/**规格型号*/
@property (nonatomic,strong) NSString  * attrvalue;
/**副标题*/
@property (nonatomic,strong) NSString  * avalue;
/**主标题*/
@property (nonatomic,strong) NSString  * aname;

@end
