//
//  HomeReusableHeadView.h
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/17.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeReusableHeadView : UICollectionReusableView
/**接受外界传过来的数据*/
@property (nonatomic,strong) NSMutableArray *imgArr;
- (instancetype)initWithFrame:(CGRect)frame;

@end
