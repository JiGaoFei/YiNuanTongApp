//
//  OrderNewListSectionHeadView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderNewListSectionHeadView : UIView
// 创建订单编号
@property (nonatomic,strong)UILabel *orderSnLab;

// 创建交易时间
@property (nonatomic,strong)UILabel *orderTimeLab;
// 交易状态
@property (nonatomic,strong)UILabel *statuLab;
// 创建打开按钮
@property (nonatomic,strong) UIButton *openBtn;
/**打开按钮的回调*/
@property (nonatomic,copy) void (^openBtnBloock)(BOOL isOpen);
- (instancetype)initWithFrame:(CGRect)frame;
@end
