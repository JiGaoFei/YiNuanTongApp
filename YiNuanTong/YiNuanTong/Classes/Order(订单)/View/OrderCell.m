//
//  OrderCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/16.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "OrderCell.h"
#import "YNTUITools.h"
#import "OrderModel.h"
@interface OrderCell ()


@end
@implementation OrderCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //加载子视图
       
        [self setUpChildrenViews];
        self.secondTimeBtn .tag = 2200;
        self.immediatelyBtn.tag = 2201;
        self.remindSendGoodBtn.tag = 2202;
    }
    return self;
}
// 创建子视图
- (void)setUpChildrenViews
{      
    // 创建订单号
    self.orderNumberLab = [YNTUITools createLabel:CGRectMake(10, 7, 260, 17) text:nil textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:16];
    [self.contentView addSubview:self.orderNumberLab];
    
    // 创建订单完成状态
    self.orderCompleteStatusLab = [YNTUITools createLabel:CGRectMake(KScreenW - 70, 5,60, 20) text:nil textAlignment:NSTextAlignmentLeft textColor:RGBA(0, 158, 249, 1) bgColor:nil font:13];
    [self.contentView addSubview:self.orderCompleteStatusLab];
    // 创建商品数量
    self.shopNumberLab = [YNTUITools createLabel:CGRectMake(10, 34, 200, 13) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    [self.contentView addSubview:self.shopNumberLab];
    // 创建订单时间
    self.orderTimeLab = [YNTUITools createLabel:CGRectMake(10, 55, 280, 13) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    [self.contentView addSubview:self.orderTimeLab];
    // 创建订单金额
    self.orderMoneyNumberLab = [YNTUITools createLabel:CGRectMake(10, 76, 200, 13) text:nil textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    [self.contentView addSubview:self.orderMoneyNumberLab];
    
    // 提醒发货
    self.remindSendGoodBtn = [YNTUITools createButton:CGRectMake(KScreenW - 94, 60, 80, 32) bgColor:nil title:nil  titleColor:nil action:@selector(btnAction:) vc:self];
    UIImage *remindImg = [UIImage imageNamed:@"提醒发货"];
   remindImg = [remindImg  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.remindSendGoodBtn setImage:remindImg forState:UIControlStateNormal];
    [self.contentView addSubview:self.remindSendGoodBtn];

    
    // 再次购买
    self.secondTimeBtn = [YNTUITools createButton:CGRectMake( KScreenW - 94,93, 80, 32) bgColor:nil title:nil  titleColor:nil action:@selector(btnAction:) vc:self];
    UIImage *secondImg = [UIImage imageNamed:@"order-再次购买"];
    secondImg = [secondImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.secondTimeBtn setImage:secondImg forState:UIControlStateNormal];
    [self.contentView addSubview:self.secondTimeBtn];
    // 立刻购买 KScreenW - 94,93, 80, 32
    self.immediatelyBtn = [YNTUITools createButton:CGRectMake(KScreenW - 94-80 - 18, 93, 80, 32) bgColor:nil title:nil titleColor:nil action:@selector(btnAction:) vc:self];
    UIImage *immediatelyImg = [UIImage imageNamed:@"立即付款"];
   immediatelyImg = [immediatelyImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.immediatelyBtn setImage:immediatelyImg forState:UIControlStateNormal];

    [self.contentView addSubview:self.immediatelyBtn];
    
}

- (void)btnAction:(UIButton *)sender
{
    
    if (self.buttonClicked) {
        self.buttonClicked(sender.tag);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
