//
//  OrderNewTableViewCell.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderNewListModel;
@interface OrderNewTableViewCell : UITableViewCell
/**商品名称*/
@property (nonatomic,strong) UILabel  * goodName;
/**商品图片*/
@property (nonatomic,strong) UIImageView  *goodImageView;
/**商品数量lab*/
@property (nonatomic,strong) UILabel  * shopNumberLab;
/**价钱lab*/
@property (nonatomic,strong) UILabel  * orderMoneyLab;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setValeuWithModel:(OrderNewListModel *)model;
@end
