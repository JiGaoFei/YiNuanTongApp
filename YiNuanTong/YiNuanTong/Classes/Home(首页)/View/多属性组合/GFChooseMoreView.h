//
//  GFChooseMoreView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GFChooseMoreViewDelegate <NSObject>
// 确定按钮点击事件
- (void)GFChooseMoreViewClickConfirmBtnActionWithDic:(NSMutableDictionary *)dic;
// 取消按钮点击事件
- (void)GFChooseMoreViewCancelBtn;
- (void)GFChooseMoreViewLine:(NSInteger )LineNumber andWithGoodIDs:(NSString *)good_ids;
@end
@interface GFChooseMoreView : UIView
@property (nonatomic,assign)id<GFChooseMoreViewDelegate>delegate;
//透明视图
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
// 为多级赋值
- (void)setGFChooseMoreViewValueWithParams:(NSMutableDictionary *)params andWithAttrtypeArr:(NSMutableArray *)modelArray;
// 为规格赋值
- (void)setGFChooseMoreViewValueWithModelArray:(NSMutableArray *)modelArray andParams:(NSMutableDictionary *)params;
// 动态为多级赋值
- (void)setGFChooseMoreViewValueWithParams:(NSDictionary *)params andWithAttrtypeArr:(NSMutableArray *)modelArray andWithIndex:(NSInteger)index;


@end
