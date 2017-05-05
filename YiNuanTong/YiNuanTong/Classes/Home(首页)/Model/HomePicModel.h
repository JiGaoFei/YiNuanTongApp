//
//  HomePicModel.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/5/4.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseModel.h"

@interface HomePicModel : YNTBaseModel
/**id*/
@property (nonatomic,copy) NSString *cat_id;
/**分类名字*/
@property (nonatomic,copy) NSString *catname;
/**图片路径*/
@property (nonatomic,copy) NSString *image;

@end
