//
//  MinHeadReusableView.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/15.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MinHeadReusableView : UICollectionReusableView
/**公司名字*/
@property (nonatomic,strong)  UILabel *companyNameLab;
/**公司图片*/
@property (nonatomic,strong) UIImageView  *companyImageView;
@property (nonatomic,copy) void(^companyImageViewClicked)();
- (instancetype)initWithFrame:(CGRect)frame;

@end
