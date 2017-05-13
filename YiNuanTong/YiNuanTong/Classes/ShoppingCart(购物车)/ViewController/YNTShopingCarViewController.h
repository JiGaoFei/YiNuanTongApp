//
//  YNTShopingCarViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 17/4/6.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"
#import "GFShopTableViewCell.h"
#import "ShopSectionHeadView.h"
#import "ShopSectionFooterView.h"
#import "ShopBottomView.h"
#import "YNTNetworkManager.h"
#import "ShopCarModel.h"
#import "ShopSectionModel.h"
#import "UIImageView+WebCache.h"
@interface YNTShopingCarViewController : YNTBaseViewController
/**判断是否是从详情页中进的 1是*/
@property (nonatomic,strong) NSString  * isFromdetail;
@end
