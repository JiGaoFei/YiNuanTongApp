//
//  GFChooseOneView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GFChooseOneViewDelegate <NSObject>
// 确定按钮点击事件
- (void)GFChooseOneViewClickConfirmBtnActionWithDic:(NSMutableDictionary *)dic;
// 取消按钮点击事件
- (void)GFChooseOneViewCancelBtn;
@end
@interface GFChooseOneView : UIView
@property (nonatomic,assign)id<GFChooseOneViewDelegate>delegate;
// 透明视图
@property(nonatomic, strong)UIView *alphaiView;
// 白色背景视图
@property(nonatomic, strong)UIView *whiteView;
// 商品图片
@property(nonatomic, strong)UIImageView *img;
// 商品价格
@property(nonatomic, strong)UILabel *priceLab;
// 商品名字
@property(nonatomic, strong)UILabel *nameLab;
// 商品总价
@property (nonatomic,strong) UILabel *totallMoneyLab;
// 商品总件数
@property (nonatomic,strong) UILabel *goodsNumberLab;
// 提示
@property (nonatomic,strong) UILabel *alertLab;
// 线条
@property(nonatomic, strong)UILabel *lineLab;
// 确定按钮
@property(nonatomic, strong)UIButton *confirmBtn;
// 取消按钮
@property(nonatomic,strong)UIButton *cancelBtn;

- (instancetype)initWithFrame:(CGRect)frame;
// 传递限制数量
- (void)setActivityNumWithStr:(NSString *)activitynum andOrderCout:(NSInteger)orderCount;
- (void)setGFChooseOneViewValueWithModelArray:(NSMutableArray *)modelArray andParams:(NSMutableDictionary *)params;
@end
