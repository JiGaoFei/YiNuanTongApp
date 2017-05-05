//
//  HomeGoodDetailModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface HomeGoodDetailModel : YNTBaseModel
/**存放规格的数组*/
@property (nonatomic,strong) NSMutableArray  * attr;
/**存放图片的数组*/
@property (nonatomic,strong) NSMutableArray  * pics;
/**商品名*/
@property (nonatomic,strong) NSString  * name;
/**库存量*/
@property (nonatomic,strong) NSString  * stocknum;
/**售价*/
@property (nonatomic,strong) NSString  * saleprice;
/**市场价*/
@property (nonatomic,strong) NSString  * marketprice;
/**货id*/
@property (nonatomic,strong) NSString  * huo_id;
/**商品id*/
@property (nonatomic,strong) NSString  * good_id;
/**产品介绍*/
@property (nonatomic,strong) NSString  * tuwen;
/**相关参数*/
@property (nonatomic,strong) NSString  * xiangguancanshu;

@end
