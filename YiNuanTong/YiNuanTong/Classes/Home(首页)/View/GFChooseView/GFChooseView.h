//
//  GFChooseView.h
//  弹出框
//
//  Created by 1暖通商城 on 2017/3/24.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GFChooseViewDelegate <NSObject>
//点击加号事件
- (void)clickAddButtonAction:(NSString *)str;
//点击减号事件
- (void)clickReduceButtonAction:(NSString *)str;
// 文字改变事件
- (void)textChangeAction:(NSString *)str;
// 键盘完成事件
- (void)clickKeyBordCompleteAction:(NSString *)str;
//点击关闭事件
- (void)closeButtonAction;
// 点击确定事件
- (void)chooseViewConfirmButtonActionWithArr:(NSMutableDictionary *)dic;
// 规格参数
- (void)clickBtnIndexWithTag:(NSInteger)index;
/** @param  lineNumber  第lineNumber行
 * @param    index            第index个
 */
- (void)clickBtnLineNumber:(NSInteger)lineNumber andIndex:(NSInteger )index;
@end
@interface GFChooseView : UIView
@property (nonatomic,weak) id<GFChooseViewDelegate>delegate;
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
// 取消按钮的点击回调
@property (nonatomic,copy) void(^canceBtnBlock)();
// 确定按钮的点击回调
@property (nonatomic,copy) void(^confirmBtnBlock)();
/** 为图片赋值 */
- (void)setGFChooseViewWithURL:(NSString *)url andJiaGeQuJian:(NSString *)jigaequjian;
/** 首次为数据赋值 */
- (void)setGFChooseViewValueWithDic:(NSDictionary *)dic andCengji:(NSString *)cengji ;
- (void)setGFChooseTableViewValueWithArr:(NSMutableArray *)arr andCengji:(NSString *)cengji;
// 非首次点击赋值
- (void)setTitleBtnArrayWithModelArr:(NSMutableArray *)modelArr andWithCengji:(NSInteger )cengji andwithLine:(NSInteger)lineNumber;
- (void)setTitleBtnArrayWithModelArr:(NSMutableArray *)modelArr;
- (void)setTitleBtnArrayWithModelArr:(NSMutableArray *)modelArr andStr:(NSString *)str;
@end
