//
//  PayOderViewController.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTBaseViewController.h"

@interface PayOderViewController : YNTBaseViewController
/**订单编号*/
@property (nonatomic,strong) NSString  * order_sn;
/**订单费用*/
@property (nonatomic,strong) NSString  * order_amount;
/**订单id*/
@property (nonatomic,copy) NSString *order_id;

/**创建tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**存放分区model*/
@property (nonatomic,strong) NSMutableArray  *sectionModelArr;
/**存取*/
@property (nonatomic,assign) NSInteger  section;
/**数量*/
@property (nonatomic,assign) NSNumber *zongnum;
/**总价*/
@property (nonatomic,assign) NSNumber *zongprice;
/**分区数量*/
@property (nonatomic,assign) NSInteger  sectionNum;
/**分区总价*/
@property (nonatomic,assign) NSInteger sectionPrice;
@end
static NSString *identifier = @"shopCell";
