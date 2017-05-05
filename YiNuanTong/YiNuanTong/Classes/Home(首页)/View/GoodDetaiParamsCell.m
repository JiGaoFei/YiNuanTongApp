//
//  GoodDetaiParamsCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/19.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GoodDetaiParamsCell.h"
#import "YNTUITools.h"
#import "UIImageView+WebCache.h"
#import "HomeGoodDetailRecommandModel.h"
@interface GoodDetaiParamsCell ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
/**recModel数组*/
@property (nonatomic,strong) NSMutableArray *recModelArray;


@end
@implementation GoodDetaiParamsCell
 - (NSMutableArray *)recModelArray
{
    if (!_recModelArray) {
        self.recModelArray = [[NSMutableArray alloc]init];
    }
    return _recModelArray;
}
 - (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpChildrenViews];
        [self setUpRecommendViews];
    }
    return self;
}

// 加载视图
- (void)setUpChildrenViews
{
   self.imgView = [YNTUITools createImageView:CGRectMake(148 *kWidthScale, 10 *kHeightScale, 84 *kWidthScale, 20 *kHeightScale) bgColor:nil imageName:@"specification"];
    [self.contentView addSubview:_imgView];
    
    // 创建材质
    self.materialLab = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 35 *kHeightScale, 80 *kWidthScale, 12 *kHeightScale) text:@"" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:12 *kHeightScale];
    [self.contentView addSubview:self.materialLab];
    self.materialContentLab = [YNTUITools createLabel:CGRectMake(124 *kWidthScale, 35 *kHeightScale, 150 *kWidthScale, 12 *kHeightScale) text:@"" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:12 *kHeightScale];
    [self.contentView addSubview:self.materialContentLab];
    
    // 创建产地
    self.originLab = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 57 *kHeightScale, 80 *kWidthScale, 12 *kHeightScale) text:@"" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:12 *kHeightScale];
    [self.contentView addSubview:self.originLab];
    self.originlContentLab = [YNTUITools createLabel:CGRectMake(124 *kWidthScale, 57 *kHeightScale, 150 *kWidthScale, 12 *kHeightScale) text:@"" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:12 *kHeightScale];
    [self.contentView addSubview:self.originlContentLab];
    // 创建品牌
    self.brandLab = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 80 *kHeightScale, 80 *kWidthScale, 12 *kHeightScale) text:@"" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:12 *kHeightScale];
    [self.contentView addSubview:self.brandLab];
    self.brandContentLab = [YNTUITools createLabel:CGRectMake(124 *kWidthScale, 80 *kHeightScale, 150 *kWidthScale, 12 *kHeightScale) text:@"" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:12 *kHeightScale];
    [self.contentView addSubview:self.brandContentLab];
    
    
    
    
}
// 创建推荐view
- (void)setUpRecommendViews
{
    self.bagView = [[UIView alloc]initWithFrame:CGRectMake(0, 125 *kHeightScale, KScreenW, 193 *kHeightScale)];
    _bagView.backgroundColor  = RGBA(102, 102, 102, 1);
    
    [self.contentView addSubview:_bagView];
    //  创建产品推荐
    UILabel *recommandLab = [YNTUITools createLabel:CGRectMake(15*kWidthScale, 10 *kHeightScale, 80 *kWidthScale, 15 *kHeightScale) text:@"产品推荐" textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] bgColor:nil font:15 *kHeightScale];
    [_bagView addSubview:recommandLab];
    
    // 创建scrollView
    self.scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(15 *kWidthScale, 35 *kHeightScale, KScreenW - 30 *kWidthScale, 144 *kHeightScale)];
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [_bagView addSubview:self.scrollView];
    
    
    // 创建继续上拉查看商品详情
    
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(125*kWidthScale, 333 *kHeightScale, KScreenW - 250*kWidthScale, 12 *kHeightScale) text:@"继续上拉查看商品详情" textAlignment:NSTextAlignmentCenter textColor:CGRGray bgColor:nil font:12 *kHeightScale];
    [self.contentView addSubview:titleLab];
}
// 创建图片
- (UIView *)setUpPicsViewWithTag:(NSInteger )tag withModel:(HomeGoodDetailRecommandModel *)recModel
{  UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(tag *125*kWidthScale , 0, 110 *kWidthScale, 154 *kHeightScale)];
    bagView.backgroundColor = [UIColor whiteColor];
    // 创建图片
    UIImageView *imgViews = [YNTUITools createImageView:CGRectMake(5 *kWidthScale, 5 *kHeightScale, 100 *kWidthScale, 100 *kWidthScale) bgColor:nil imageName:@""];
    // 为图片赋值
    [imgViews sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",recModel.cover_img]]];

    
    [bagView addSubview:imgViews];
    // 创建name
    UILabel *contentLab = [YNTUITools createLabel:CGRectMake(5 *kWidthScale, 113 *kHeightScale, 100 *kWidthScale, 12 *kHeightScale) text:recModel.name textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:12 *kHeightScale];
    [bagView addSubview:contentLab];
    // 创建价格
    UILabel *priceLab = [YNTUITools createLabel:CGRectMake(10 *kWidthScale, 130 *kHeightScale, 100 - 20 *kWidthScale, 12 *kHeightScale) text:recModel.price textAlignment:NSTextAlignmentCenter textColor:CGRRed bgColor:nil font:12 *kHeightScale];
    [bagView addSubview:priceLab];

    // 创建手势
    UITapGestureRecognizer *tapgest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [bagView addGestureRecognizer:tapgest];
    bagView.tag = tag;
    return bagView;
  }
- (void)setSizeViewsFrame
{

        self.bagView.frame = CGRectMake(0, 10 *kHeightScale, KScreenW, 193 *kHeightScale);
 

}
#pragma mark - 创建推荐商品
// 推荐商品数据赋值
- (void)setValueWithModelArray:(NSMutableArray *)modelArray
{
    self.recModelArray = modelArray;
    for (int i = 0; i<modelArray.count; i++) {
        HomeGoodDetailRecommandModel *model = modelArray[i];
        UIView *view =  [self setUpPicsViewWithTag:i withModel:model];
        [self.scrollView addSubview:view];
        _scrollView.contentSize = CGSizeMake(i*130*kWidthScale +110*kWidthScale , 144*kHeightScale);
        }
}
#pragma mark - btn按钮的点击事件
- (void)tapGestureAction:(UITapGestureRecognizer *)sender
{  UIView *view = (UIView *)[sender view];
    NSLog(@"点击第%ld个",(long)view.tag);
    HomeGoodDetailRecommandModel *model = self.recModelArray[view.tag];
    if (self.tapBtnActionBlock) {
        self.tapBtnActionBlock(model);
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
