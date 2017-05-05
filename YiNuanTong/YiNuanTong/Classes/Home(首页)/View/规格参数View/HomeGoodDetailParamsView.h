//
//  HomeGoodDetailParamsView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/20.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeGoodDetailParamsView : UIView
/**关闭按钮回调*/
@property (nonatomic,copy) void (^closeBtnBlock)();

- (instancetype)initWithFrame:(CGRect)frame;
- (void)setValueWithModelArray:(NSMutableArray *)modelArray;
@end
