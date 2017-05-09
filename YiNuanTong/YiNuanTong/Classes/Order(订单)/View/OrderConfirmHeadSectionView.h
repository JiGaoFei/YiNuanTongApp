//
//  OrderConfirmHeadSectionView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/5/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderConfirmHeadSectionView : UIView
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIButton *roateBtn;
/**旋转按钮的回调*/
@property (nonatomic,copy) void(^roateBtnBlock)();

- (instancetype)initWithFrame:(CGRect)frame;
@end
