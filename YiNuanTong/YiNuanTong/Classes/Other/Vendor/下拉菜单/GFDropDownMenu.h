//
//  GFDropDownMenu.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/19.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFDropDownMenu : UIView
/**动画持续时间*/
@property (nonatomic,assign) CGFloat  GFAnimationTime;
// 点击按钮的回调
@property (nonatomic,copy) void(^bttonClicked)(NSInteger index);
/**品牌*/
@property (nonatomic,strong) UIButton *oneBtn;
/**价格*/
@property (nonatomic,strong) UIButton *twoBtn;
/**更多*/
@property (nonatomic,strong) UIButton *threeBtn;
/**筛选*/
@property (nonatomic,strong) UIButton *fourBtn;

-(instancetype)initWithFrame:(CGRect)frame;
@end
