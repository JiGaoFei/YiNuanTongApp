//
//  GoodDetaiParamsCell.h
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/19.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeGoodDetailRecommandModel;
@interface GoodDetaiParamsCell : UITableViewCell
/**材质*/
@property (nonatomic,strong) UILabel *materialLab;
/**材质内容*/
@property (nonatomic,strong) UILabel *materialContentLab;
/**产地*/
@property (nonatomic,strong) UILabel *originLab;
/**产地内容*/
@property (nonatomic,strong) UILabel *originlContentLab;
/**品牌*/
@property (nonatomic,strong) UILabel *brandLab;
/**品牌内容*/
@property (nonatomic,strong) UILabel *brandContentLab;
/**图片规格参数*/
@property (nonatomic,strong)  UIImageView *imgView;
@property (nonatomic,strong)UIView *bagView;
/**点击传递事件*/
@property (nonatomic,copy) void (^tapBtnActionBlock)(HomeGoodDetailRecommandModel *model);

// 推荐商品数据赋值
- (void)setValueWithModelArray:(NSMutableArray *)modelArray;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setSizeViewsFrame;

@end
