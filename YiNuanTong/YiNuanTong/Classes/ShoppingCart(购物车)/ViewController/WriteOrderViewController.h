//
//  WriteOrderViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"
@class WriteModel;
@interface WriteOrderViewController : YNTBaseViewController
/**地址model*/
@property (nonatomic,strong) WriteModel  * model;
/**order_Id*/
@property (nonatomic,strong) NSString  * order_id;
/**总金额*/
@property (nonatomic,strong) NSString  * totalMoney;
/**商品件数*/
@property (nonatomic,strong) NSString  * goodsnum;
/**物流信息*/
@property (nonatomic,strong) NSMutableDictionary  * arrwuliuDic;
@end
