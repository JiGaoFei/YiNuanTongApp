//
//  HomeGoodDetailParamsView.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/20.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "HomeGoodDetailParamsView.h"
#import "YNTUITools.h"
#import "HomeDetailParamViewCell.h"
#import "HomeGoodsDetailSizeModel.h"
@interface HomeGoodDetailParamsView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
/**数据源*/
@property (nonatomic,strong) NSMutableArray *modelArray;

@end
static NSString  *identifier = @"homeGoodParamViewCell";
@implementation HomeGoodDetailParamsView
#pragma mark - 懒加载
- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        self.modelArray  = [[NSMutableArray alloc]init];
    }
    
    return _modelArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 加载视图
        [self setUpChildrenViews];
    }
    return self;
}
- (void)setUpChildrenViews
{
   // 灰色背景
    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH)];
    bagView.backgroundColor = RGBA(0, 0, 0, 0.7);
    [self addSubview:bagView];
    // 白色背景
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 135 *kHeightScale, KScreenW, kScreenH - 135 *kHeightScale)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [bagView addSubview:whiteView];
    
    
    // 创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 46 *kHeightScale, KScreenW, 235 *kHeightScale)];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerClass:[HomeDetailParamViewCell class] forCellReuseIdentifier:identifier];
    [whiteView addSubview:_tableView];
    
    // 创建titleView
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(150 *kWidthScale, 15 *kHeightScale, KScreenW - 300 *kWidthScale, 16 *kHeightScale) text:@"规格参数" textAlignment:NSTextAlignmentCenter textColor:nil bgColor:nil font:16 *kHeightScale];
    [whiteView addSubview:titleLab];
    
    
    // 关闭按钮
    UIButton *closeBtn = [YNTUITools createButton:CGRectMake(0, kScreenH - 64 -48*kHeightScale, KScreenW, 48 *kHeightScale) bgColor:CGRBlue title:@"关闭" titleColor:[UIColor whiteColor] action:@selector(closeBtnAction:) vc:self];
    [self addSubview:closeBtn];
    
}
- (void)closeBtnAction:(UIButton *)sender
{
 //   NSLog(@"关闭");
    if (self.closeBtnBlock) {
        self.closeBtnBlock();
    }
}

#pragma  mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeDetailParamViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    HomeGoodsDetailSizeModel *model = self.modelArray[indexPath.row];
    cell.nameTitleLab.text = model.aname;
    cell.nameSubtitleLab.text = model.avalue;
    if (self.modelArray.count <7) {
        self.tableView.scrollEnabled = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33 *kHeightScale;
}
// 赋值
- (void)setValueWithModelArray:(NSMutableArray *)modelArray
{
    self.modelArray = modelArray;
    [self.tableView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
