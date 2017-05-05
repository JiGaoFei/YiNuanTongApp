//
//  CustomButtonView.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/2/23.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BtnBlock) (NSInteger index);
@interface CustomButtonView : UIView
@property (nonatomic,copy) BtnBlock btnBlock;
- (void)btnClickBlock:(BtnBlock) btnBlock;
- (instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)array;
@end
