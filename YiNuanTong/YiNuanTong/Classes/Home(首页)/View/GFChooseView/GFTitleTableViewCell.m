//
//  GFTitleTableViewCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/8.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GFTitleTableViewCell.h"
#import "YNTUITools.h"
#import "BadgeButton.h"
#import "HomeShopListSizeModel.h"

@interface GFTitleTableViewCell ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *titleBtnArray;
/** 选中的按钮*/
@property (nonatomic, weak) UIButton *selectBtn;
@end
@implementation GFTitleTableViewCell
- (NSMutableArray *)titleBtnArray
{
    if (!_titleBtnArray) {
        self.titleBtnArray = [[NSMutableArray alloc]init];
    }
    return _titleBtnArray;
}
 - (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       
        [self setUpChildrenViews];
    }
    return self;
}
- (void)setUpChildrenViews
{
    UIImageView *leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10*kWidthScale, 12 *kHeightScale , 16*kWidthScale, 24*kHeightScale)];
    leftImgView.image = [UIImage imageNamed:@"left"];
    [self addSubview:leftImgView];
    
    UIImageView *rightImgView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW - 20*kWidthScale, 12*kHeightScale, 16*kWidthScale, 24*kHeightScale)];
    rightImgView.image = [UIImage imageNamed:@"right"];
    [self addSubview:rightImgView];
    
    self.scrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(25 *kWidthScale, 0,KScreenW - 50 *kHeightScale , 44*kHeightScale)];
    [self addSubview:_scrollView];
    self.scrollView.delegate = self;
 
}
- (void)titleclick:(UIButton *)sender
{
    NSLog(@"开始点击了");
    [sender setTitleColor:[UIColor colorWithRed:52.0/255 green:162.0/255 blue:252.0/255 alpha:1] forState:UIControlStateNormal];
    //选中按钮
   [self selectBtn:sender];
    if (self.btnBlock) {
      self.btnBlock(sender.tag);
    }
    
}
#pragma mark - 选中的按钮
- (void)selectBtn:(UIButton *)btn{
    
    [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //选中的按钮居中显示  本质是: 设置偏移量
    CGFloat offsetX = btn.center.x - KScreenW * 0.5;
    
    //向右
    if (offsetX < 0) {
        
    }
    //最大偏移量
    CGFloat MaxOffsetX = self.scrollView.contentSize.width - KScreenW;
    
    //向左
    if (offsetX >MaxOffsetX) {
        offsetX = MaxOffsetX;
    }
    _selectBtn = btn;
}
// 创建title
- (void)setTitleBtnValueWith:(NSMutableArray *)dataArray
{
    self.titleBtnArray = dataArray;
    NSInteger count = dataArray.count;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = 120*kWidthScale;
    CGFloat btnH = 44*kHeightScale;
    // 设置按钮的间距
        for (int i = 0; i < count; i++) {
            HomeShopListSizeModel *model = dataArray[i];
        //创建按钮
        BadgeButton*btn =[[BadgeButton alloc]init];
            NSInteger selectNum = [model.select integerValue];
            if ( selectNum == 1) {
                [btn setTitleColor:[UIColor colorWithRed:52.0/255 green:162.0/255 blue:252.0/255 alpha:1] forState:UIControlStateNormal];
      
            }else{
                
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        //获取下标
        btn.tag = i;
        
        btnX = i * btnW ;
        
        btn.frame = CGRectMake(btnX , btnY,btnW, btnH);
      
        

        [btn setTitle:model.name forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        

                  
        [self.scrollView addSubview:btn];
        
            
        //监听按钮点击事件
        
        [btn addTarget:self action:@selector(titleclick:) forControlEvents:UIControlEventTouchUpInside];
        
        
    
    }
    
    _scrollView.contentSize = CGSizeMake(count * btnW, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    


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
