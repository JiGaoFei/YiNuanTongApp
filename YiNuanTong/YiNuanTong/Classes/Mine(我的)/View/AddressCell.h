//
//  AddressCell.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressCell : UITableViewCell
/**名字*/
@property (nonatomic,strong) UILabel  * nameLab;
/**phoneNum*/
@property (nonatomic,strong) UILabel  * phoneLab;
/**地址*/
@property (nonatomic,strong) UILabel  * addressLab;
/**默认btn*/
@property (nonatomic,strong) UIButton  * defaultBtn;
/**编辑btn*/
@property (nonatomic,strong) UIButton  * editBtn;
/**删除btn*/
@property (nonatomic,strong) UIButton  * deleteBtn;
/**按钮点击事件的回调*/
@property (nonatomic,copy) void(^buttonClicked)(NSInteger index) ;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
