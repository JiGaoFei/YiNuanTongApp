//
//  GFBageLable.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/22.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GFBageLable.h"
#import "Masonry.h"
@implementation GFBageLable
#pragma mark - 构造方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        // button属性设置
        self.clipsToBounds = NO;
        //------- 角标label -------//
        self.badgeLabel = [[UILabel alloc]init];
        [self addSubview:self.badgeLabel];
        self.badgeLabel.backgroundColor = RGBA(52, 162, 252, 1);
        self.badgeLabel.font = [UIFont systemFontOfSize:10];
        self.badgeLabel.textColor = [UIColor whiteColor];
        self.badgeLabel.layer.cornerRadius = 6;
        self.badgeLabel.clipsToBounds = YES;
        
    
        //        //------- 建立角标label的约束 -------//
        [self.badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.mas_top).mas_offset(15);
            make.height.mas_equalTo(12);
        }];
    }
    return self;
}
#pragma mark - 显示角标
/** 显示角标 @param badgeNumber 角标数量 */
- (void)showBadgeWithNumber:(NSInteger)badgeNumber{     self.badgeLabel.hidden = NO;
    // 注意数字前后各留一个空格，不然太紧凑
    self.badgeLabel.text = [NSString stringWithFormat:@" %ld ",badgeNumber]; }
#pragma mark - 隐藏角标
/** 隐藏角标 */
- (void)hideBadge{
    self.badgeLabel.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
