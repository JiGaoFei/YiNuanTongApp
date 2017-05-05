//
//  OrderNewDetailTableHeadView.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewDetailTableHeadView.h"

@implementation OrderNewDetailTableHeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpChildrenViews];
    }
    return self;
}
// 创建视图
- (void)setUpChildrenViews
{
    
    // 订单编号
    self.orderSnLab = [[UILabel alloc]initWithFrame:CGRectMake(20 *kWidthScale, 10*kHeightScale, 200 *kWidthScale, 10 *kHeightScale)];
    self.orderSnLab.text = @"订单编号:2017040108520";
    self.orderSnLab.font = [UIFont systemFontOfSize:13*kHeightScale];
        [self addSubview:self.orderSnLab];
    // 线1
    UILabel *linlab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30 *kHeightScale, KScreenW, 2)];
    linlab1.backgroundColor = [UIColor grayColor];
    [self addSubview:linlab1];
    // 地址背景
    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, 35 *kHeightScale, KScreenW, 75 *kHeightScale)];
    
    [self addSubview:bagView];
    // 收件人:
    self.customerLab = [[UILabel alloc]initWithFrame:CGRectMake(42 *kWidthScale, 10 *kHeightScale, KScreenW-42 *kWidthScale, 15 *kHeightScale)];
    self.customerLab.text = @"收货人:李雪                               15838678830";
    self.customerLab.font = [UIFont systemFontOfSize:13*kHeightScale];
    [bagView addSubview:self.customerLab];
    
    // 创建箭头图标
    UIImageView *imgArrow = [[UIImageView alloc]initWithFrame:CGRectMake(330 *kWidthScale, 36*kHeightScale, 12 *kWidthScale, 24 *kHeightScale)];
    imgArrow.image = [UIImage imageNamed:@"arrow_address"];
    [bagView addSubview:imgArrow];
    // 地址
    self.addressLab = [[UILabel alloc]initWithFrame:CGRectMake(42 *kWidthScale, 36*kHeightScale, 280 *kWidthScale, 40 *kHeightScale)];
    self.addressLab.font = [UIFont systemFontOfSize:13*kHeightScale];
    self.addressLab.text = @"收货地址:河南省郑州市金水区三全路与丰庆路交叉口向西200米路南1暖通商城";
    self.addressLab.numberOfLines = 0;
    [bagView addSubview:self.addressLab];
    // 创建图标
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15 *kWidthScale, 40 *kHeightScale, 18 *kWidthScale,24 *kHeightScale)];
    img.image = [UIImage imageNamed:@"address"];
    [bagView addSubview:img];
    
    // 线2
    UILabel *linlab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 80 *kHeightScale, KScreenW, 2)];
    linlab2.backgroundColor = [UIColor grayColor];
    [bagView addSubview:linlab2];
    // 货品清单
    UILabel *goodTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale, 132 *kHeightScale, 80*kWidthScale, 20*kHeightScale)];
    goodTitleLab.font = [UIFont systemFontOfSize:16 *kHeightScale];
    goodTitleLab.text = @"货品清单";
    [self addSubview:goodTitleLab];
    // 拨打电话按钮
    self.callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.callBtn.frame = CGRectMake(KScreenW - 40*kWidthScale, 127 *kHeightScale, 28 *kWidthScale, 28 *kWidthScale);
    [_callBtn addTarget:self action:@selector(callBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_callBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self addSubview:_callBtn];
    
    // 提示文字
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(85 *kWidthScale, 138*kHeightScale, 200 *kWidthScale, 10*kHeightScale)];
    titleLab.font = [UIFont systemFontOfSize:10 *kHeightScale];
    titleLab.text = @"(如果有定制商品请联系客服)";
    [self addSubview:titleLab];
    
    
    // 添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
    
   
}
// 手势事件
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    if (self.tapActionBlock) {
        self.tapActionBlock();
    }
}
// 拨打电话事件
- (void)callBtnAction:(UIButton *)sender
{
    if (self.callBtnBloock) {
        self.callBtnBloock();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
