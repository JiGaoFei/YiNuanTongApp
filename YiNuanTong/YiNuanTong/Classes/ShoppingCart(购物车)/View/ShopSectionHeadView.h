//
//  ShopSectionHeadView.h
//  1暖通购物车列表
//
//  Created by 1暖通商城 on 2017/4/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopSectionHeadView : UIView
/**商品图片*/
@property (nonatomic,strong) UIImageView *goodImgView;
/**商品名*/
@property (nonatomic,strong) UILabel *goodNameLab;
/**选中按钮*/
@property (nonatomic,strong) UIButton  *selectBtn;
/**旋转按钮*/
@property (nonatomic,strong) UIButton *roateBtn;
/** 加减背景 */
@property (nonatomic,strong) UIImageView *addImgView;
/**数字*/
@property (nonatomic,strong) UITextField  * numberTextField;
/**加号按钮*/
@property (nonatomic,strong)  UIButton *addBtn;
/**减号按钮*/
@property (nonatomic,strong)  UIButton *cutBtn;
/*删除按钮*/
@property (nonatomic,strong)  UIButton *deleteBtn;
/**加号按钮的回调*/
@property (nonatomic,copy) void (^addBtnBloock)(NSString *str);
/**减号按钮的回调*/
@property (nonatomic,copy) void (^cutBtnBloock)(NSString *str);
/**删除按钮点击回调*/
@property (nonatomic,copy) void (^deleteBtnBlock)();
/**完成按钮的回调事件*/
@property (nonatomic,copy) void (^confirmBtnBlock)(NSString *str);
/**把输入后的值传递出去*/
@property (nonatomic,copy) void (^numberTextFiledInputText)(NSString* str);
/**点击区头按钮选中回调*/
@property (nonatomic,copy) void(^shopSectionBtn)(NSInteger index);
/**旋转按钮*/
@property (nonatomic,copy) void (^roateSectionBtn)(BOOL isOpen);
- (instancetype)initWithFrame:(CGRect)frame;

@end
