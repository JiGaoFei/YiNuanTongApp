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
    linlab1.backgroundColor =  RGBA(241, 241, 241, 1);
    [self addSubview:linlab1];

    
    
    
    
    
    
    
    
    
    
    // 地址背景
    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, 35 *kHeightScale, KScreenW, 155 *kHeightScale)];

    
    [self addSubview:bagView];
    
    
    
    // 物流公司
    self.shippingLab= [[UILabel alloc]initWithFrame:CGRectMake(42 *kWidthScale, 10 *kHeightScale, KScreenW-42 *kWidthScale, 15 *kHeightScale)];
    self.shippingLab.text = @"物流公司:        德邦";
    self.shippingLab.font = [UIFont systemFontOfSize:13 *kHeightScale];
    [bagView addSubview:self.shippingLab];
    
     UILabel *phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(42 *kWidthScale, 35 *kHeightScale, 80 *kWidthScale, 15 *kHeightScale)];
    phoneLab.text = @"物流电话";
    phoneLab.font = [UIFont systemFontOfSize:13 *kHeightScale];
    
     [bagView addSubview:phoneLab];
    self.shippingPhone = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shippingPhone.frame =CGRectMake(110 *kWidthScale, 30 *kHeightScale, 200 *kHeightScale, 25 *kHeightScale);
   // [self.shippingPhone setTitleEdgeInsets:UIEdgeInsetsMake(5, -20, 5, 0)];
    self.shippingPhone.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.shippingPhone.titleLabel.font = [UIFont systemFontOfSize:13 *kHeightScale];
    [self.shippingPhone addTarget:self action:@selector(shipingPhoneAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.shippingPhone setTitleColor:CGRBlue forState:UIControlStateNormal];
   //  self.shippingPhone =  [[UITextView alloc]initWithFrame:CGRectMake(100 *kWidthScale, 25 *kHeightScale, 200 *kHeightScale, 25 *kHeightScale)];
//    self.shippingPhone.text = @"13838996789";
//    self.shippingPhone.textAlignment = NSTextAlignmentLeft;
//    self.shippingPhone.textColor = CGRBlue;
//    self.shippingPhone.font = [UIFont systemFontOfSize:13 *kHeightScale];
    [bagView addSubview:self.shippingPhone];
    
    UILabel *sn= [[UILabel alloc]initWithFrame:CGRectMake(42 *kWidthScale, 60 *kHeightScale, 80 *kWidthScale, 15 *kHeightScale)];
    sn.text = @"物流单号:";
    
   sn.font = [UIFont systemFontOfSize:13 *kHeightScale];
    [bagView addSubview:sn];
    self.shippingSn = [[UITextView alloc]initWithFrame:CGRectMake(100 *kWidthScale, 50 *kHeightScale, 200 *kHeightScale, 30 *kHeightScale)];
    self.shippingSn.text = @"13988889999939993";
    self.shippingSn.editable = NO;
    self.shippingSn.textAlignment = NSTextAlignmentLeft;
    self.shippingSn.textColor = CGRBlue;

    self.shippingSn.font = [UIFont systemFontOfSize:13 *kHeightScale];
    [bagView  addSubview:self.shippingSn];
    
    
    UIImageView *shipimg = [[UIImageView alloc]initWithFrame:CGRectMake(15 *kWidthScale, 55 *kHeightScale, 22 *kWidthScale,18 *kHeightScale)];
    shipimg.image = [UIImage imageNamed:@"logistics_car"];
    [bagView addSubview:shipimg];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 85 *kHeightScale, KScreenW, 2)];
    lab.backgroundColor =  RGBA(241, 241, 241, 1);
    [bagView addSubview:lab];
    
   
    
    
    
    
    
    
    
    
    // 收件人:
    self.customerLab = [[UILabel alloc]initWithFrame:CGRectMake(42 *kWidthScale, 90 *kHeightScale, KScreenW-42 *kWidthScale, 15 *kHeightScale)];
    self.customerLab.text = @"收货人:李雪                               ";
    self.customerLab.font = [UIFont systemFontOfSize:13*kHeightScale];
    [bagView addSubview:self.customerLab];
    
    // 创建箭头图标
    UIImageView *imgArrow = [[UIImageView alloc]initWithFrame:CGRectMake(330 *kWidthScale, 116*kHeightScale, 12 *kWidthScale, 24 *kHeightScale)];
    imgArrow.image = [UIImage imageNamed:@"arrow_address"];
    [bagView addSubview:imgArrow];
    // 地址
    self.addressLab = [[UILabel alloc]initWithFrame:CGRectMake(42 *kWidthScale, 106*kHeightScale, 360 *kWidthScale, 40 *kHeightScale)];
    self.addressLab.font = [UIFont systemFontOfSize:13*kHeightScale];
    self.addressLab.text = @"收货地址:河南省郑州市金水区三全路与丰庆路交叉口向西200米路南1暖通商城";
    self.addressLab.numberOfLines = 0;
    [bagView addSubview:self.addressLab];
    // 创建图标
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(15 *kWidthScale, 120 *kHeightScale, 18 *kWidthScale,24 *kHeightScale)];
    img.image = [UIImage imageNamed:@"address"];
    [bagView addSubview:img];
    
    // 线2
    UILabel *linlab2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 160 *kHeightScale, KScreenW, 2)];
    linlab2.backgroundColor =  RGBA(241, 241, 241, 1);
    [bagView addSubview:linlab2];
    // 货品清单
    UILabel *goodTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale, 212 *kHeightScale, 80*kWidthScale, 20*kHeightScale)];
    goodTitleLab.font = [UIFont systemFontOfSize:16 *kHeightScale];
    goodTitleLab.text = @"货品清单";
    [self addSubview:goodTitleLab];
    // 拨打电话按钮
    self.callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.callBtn.frame = CGRectMake(KScreenW - 40*kWidthScale, 207 *kHeightScale, 28 *kWidthScale, 28 *kWidthScale);
    [_callBtn addTarget:self action:@selector(callBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_callBtn setBackgroundImage:[UIImage imageNamed:@"phone"] forState:UIControlStateNormal];
    [self addSubview:_callBtn];
    
    // 提示文字
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(85 *kWidthScale, 218*kHeightScale, 200 *kWidthScale, 10*kHeightScale)];
    titleLab.font = [UIFont systemFontOfSize:10 *kHeightScale];
    titleLab.text = @"(如果有定制商品请联系客服)";
    [self addSubview:titleLab];
    
    
    // 添加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesture];
    
   
}
- (void)shipingPhoneAction:(UIButton *)sender
{
    if (self.shipingcallBtnBloock) {
        self.shipingcallBtnBloock();
    }
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
