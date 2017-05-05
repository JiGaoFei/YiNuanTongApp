//
//  PhoneListCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/21.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneListCell : UITableViewCell

/**
 *创建图片
 */
@property (nonatomic,strong) UIImageView *imgView;
/**titleLab*/
@property (nonatomic,strong) UILabel  * titleLab;
/**contentLab*/
@property (nonatomic,strong) UILabel  * contentLab;
/**拔打电话按钮*/
@property (nonatomic,strong) UIButton  * callBtn;
/**按钮的回调*/
@property (nonatomic,copy) void(^buttonClicked)(NSInteger index);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@end
