//
//  OrderNewDetailSectionView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderNewDetailSectionView : UIView
/**商品图片*/
@property (nonatomic,strong) UIImageView *goodImgView;
/**商品名*/
@property (nonatomic,strong) UILabel *goodNameLab;

/**旋转按钮*/
@property (nonatomic,strong) UIButton *roateBtn;
/**旋转按钮点击事件*/
@property (nonatomic,copy) void (^roateBtnBloock)(BOOL isOpen);
- (instancetype)initWithFrame:(CGRect)frame;
@end
