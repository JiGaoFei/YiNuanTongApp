//
//  ShopCartModel.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/17.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface ShopCartModel : YNTBaseModel
/**商品id*/
@property (nonatomic,copy) NSString *good_id;
/**商品编号*/
@property (nonatomic,copy) NSString *psn;
/**商品名*/
@property (nonatomic,copy) NSString *name;

/**货号id*/
@property (nonatomic,copy) NSString *huo_id;
@property (nonatomic,copy) NSString *shortname;
/**销售价*/
@property (nonatomic,copy) NSString *saleprice;
/**市场价*/
@property (nonatomic,copy) NSString *marketprice;
/**购买数量*/
@property (nonatomic,assign)NSInteger buynum;
/**品牌*/
@property (nonatomic,copy) NSString *brands_name;
@property (nonatomic,copy) NSString *state;
/**规格*/
@property (nonatomic,copy) NSString *size;
/**图片路径 */
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *addtime;
@property (nonatomic,copy) NSString *type_id;
/**库存量*/
@property (nonatomic,copy) NSString *stocknum;
/**购买商品量*/
@property (nonatomic,copy) NSString *goodsNum;
@property (nonatomic,assign) BOOL isSelect;


//
@property (nonatomic,copy) NSString *sizeStr;
@property (nonatomic,copy) NSString *nameStr;
@property (nonatomic,assign) NSInteger number;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,retain)UIImage *image;

@end
