//
//  MinHeadReusableView.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/15.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "MinHeadReusableView.h"
#import "YNTUITools.h"
#import "UIImageView+WebCache.h"
@implementation MinHeadReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
           UserInfo *userInfo = [UserInfo currentAccount];
        
        // 创建背景图片
        UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 214 *kHeightScale)];
        backImageView.userInteractionEnabled = YES;
     

        backImageView.image = [UIImage imageNamed:@"mine-title背景"];
        [self addSubview:backImageView];
        
        // 创建公司lab
        UILabel *companyNameLab = [YNTUITools createLabel:CGRectMake(KScreenW / 2 - 100 *kWidthScale, 24 *kHeightScale, 200 *kWidthScale, 11 *kHeightScale) text:userInfo.realname textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:11];
        
        [backImageView addSubview:companyNameLab];
        
        
        //创建图片
        self.companyImageView = [YNTUITools createImageView:CGRectMake(KScreenW/2-40 *kWidthScale, 72 *kHeightScale, 80 *kWidthScale, 80 *kWidthScale) bgColor:nil imageName:@"头像图片"];
        
        [self.companyImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.avatar] placeholderImage:[UIImage imageNamed:@"头像图片"]];
        self.companyImageView.userInteractionEnabled = YES;
        _companyImageView.layer.cornerRadius = 40 *kWidthScale;
        _companyImageView.layer.masksToBounds = YES;
        [backImageView addSubview:_companyImageView];
        
        // 添加手势
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
        [self.companyImageView addGestureRecognizer:tapGestureRecognizer];
        
        
        // 创建账户名称
        UILabel *accounNameLab = [YNTUITools createLabel:CGRectMake(KScreenW/2-100 *kWidthScale, 159 *kHeightScale, 200 *kWidthScale, 14 *kHeightScale) text:@"" textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:14];
        accounNameLab.text = userInfo.phone;
        
        if (KScreenW == 320) {
            accounNameLab.font = [UIFont systemFontOfSize:12];
        }
        [backImageView addSubview:accounNameLab];
        
        //创建图片
        UIImageView *creditImageView = [YNTUITools createImageView:CGRectMake(256 *kPlus *kWidthScale, 181 *kHeightScale, KScreenW - 2 *256 *kPlus *kWidthScale, 23 *kHeightScale) bgColor:nil imageName:@"信用值"];
        creditImageView.userInteractionEnabled = YES;
  
        [backImageView addSubview:creditImageView];
        
        
        // 创建账户名称
        UILabel *creditNameLab = [YNTUITools createLabel:CGRectMake(35 *kWidthScale, 0, 80*kWidthScale, 23 *kHeightScale) text:@"0" textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:12];
        [creditImageView addSubview:creditNameLab];


    }
    return self;
}


#pragma makrk - 手势的点击事件
- (void)tapGestureAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"我要上传头像了") ;
    if (self.companyImageViewClicked) {
        self.companyImageViewClicked();
    }
    
}
@end
