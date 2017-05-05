//
//  AddressSwitchCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressSwitchCell : UITableViewCell
/**开关的回调*/
@property (nonatomic,copy) void(^swichBtnClick) (NSInteger index);
/**'nameLab*/
@property (nonatomic,strong) UILabel  * nameLab;
/**uiswichBtn*/
@property (nonatomic,strong) UISwitch  * swithBtn;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
