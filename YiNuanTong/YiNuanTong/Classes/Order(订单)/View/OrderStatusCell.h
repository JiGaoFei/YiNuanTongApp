//
//  OrderStatusCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/20.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderStatusCell : UITableViewCell
/**titleLab*/
@property (nonatomic,strong) UILabel  * titleLab;
/**公司名称*/
@property (nonatomic,strong) UILabel  * companyNamelLab;
/**订货 单号*/
@property (nonatomic,strong) UILabel  * orderNumberLab;
/**订单时间 */
@property (nonatomic,strong) UILabel  * orderTimeLab;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
