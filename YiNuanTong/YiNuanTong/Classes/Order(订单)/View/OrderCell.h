//
//  OrderCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/16.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderModel;
@interface OrderCell : UITableViewCell
/**订单号*/
@property (nonatomic,strong) UILabel  * orderNumberLab;
/**订单完成状态*/
@property (nonatomic,strong) UILabel  * orderCompleteStatusLab;
/**商品数量lab*/
@property (nonatomic,strong) UILabel  * shopNumberLab;
/**订单时间lab*/
@property (nonatomic,strong) UILabel  * orderTimeLab;
/**订单moneylab*/
@property (nonatomic,strong) UILabel  * orderMoneyNumberLab;
/**再次购买*/
@property (nonatomic,strong) UIButton  * secondTimeBtn;
/**立刻购买*/
@property (nonatomic,strong) UIButton  * immediatelyBtn;
/**提醒发货*/
@property (nonatomic,strong) UIButton  * remindSendGoodBtn;
/**点击按钮的回调*/
@property (nonatomic,copy) void(^buttonClicked)(NSInteger index);

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
