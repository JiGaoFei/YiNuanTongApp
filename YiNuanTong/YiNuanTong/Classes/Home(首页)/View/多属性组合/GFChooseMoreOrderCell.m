//
//  GFChooseMoreOrderCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/5/11.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GFChooseMoreOrderCell.h"
#import "OrderCollectionViewCell.h"
#import "HomeShopListSizeModel.h"

@interface GFChooseMoreOrderCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)  UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong)  OrderCollectionViewCell *cell;
/**总件数*/
@property (nonatomic,assign) NSInteger alltotalNumber;
/**总钱数*/
@property (nonatomic,assign)  NSInteger alltotalMoney;
/**存放数据源*/
@property (nonatomic,strong) NSMutableArray  * modelArray;
@end
static NSString *identifierCollectionCell = @"orderCollectionViewCell";
@implementation GFChooseMoreOrderCell
#pragma mark - 懒加载
- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        self.modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建视图
        [self setUpChildrenViews];
    
    }
    return self;
}
- (void)setUpChildrenViews
{
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [_flowLayout setItemSize:CGSizeMake(90, 60)];
    [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    // flowLayout.sectionInset = UIEdgeInsetsMake(5, 5,0, 5);
    
    _flowLayout.minimumLineSpacing = 20;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width,40) collectionViewLayout:_flowLayout] ;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;

    [self.contentView addSubview:_collectionView];
}
#pragma mark -代理方法
//CollectionView的分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
   
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.modelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
NSString *str= [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    
    // 注册
    [self.collectionView registerClass:[OrderCollectionViewCell class] forCellWithReuseIdentifier:str];
     OrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: str forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[OrderCollectionViewCell alloc]init];
        
    }

    cell.cornerMarkLab.textAlignment = NSTextAlignmentCenter;
    
    // 设置颜色
      HomeShopListSizeModel *model = self.modelArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.nameLab.textColor = CGRBlue;
        cell.nameLab.layer.borderColor =[CGRBlue CGColor];
        cell.nameLab.layer.borderWidth = 1;
        cell.nameLab.layer.cornerRadius = 5;
        cell.nameLab.layer.masksToBounds = YES;
    }else{
        cell.nameLab.textColor =[UIColor grayColor];
        cell.nameLab.layer.borderColor =[RGBA(220, 220, 220, 1) CGColor];
        cell.nameLab.layer.borderWidth = 1;
        cell.nameLab.layer.cornerRadius = 5;
        cell.cornerMarkLab.backgroundColor = [UIColor grayColor];

    }
  
    cell.nameLab.text = model.name;
    self.alltotalNumber = 0;
    // 单项总数量
    self.alltotalNumber +=([model.num doubleValue]+[model.num1 doubleValue]+[model.num2 doubleValue] + [model.num3 doubleValue]);
    

    if (self.alltotalNumber == 0) {
        cell.cornerMarkLab.hidden = YES;
    }else{
        cell.cornerMarkLab.hidden = NO;
         cell.cornerMarkLab.text = [NSString stringWithFormat:@"%ld",(long)self.alltotalNumber];
    }
 


    
    
    // 动态计算
    CGRect rect = cell.nameLab.frame;
    rect.size.width = [self widthForLabel:model.name fontSize:15] +10;
    cell.nameLab.frame = rect;
    
    CGRect rect1 = cell.cornerMarkLab.frame;
    rect1.origin.x = [self widthForLabel:model.name fontSize:15] ;
    
    cell.cornerMarkLab.frame = rect1;
 
  
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
      HomeShopListSizeModel *model = self.modelArray[indexPath.row];

   return CGSizeMake( [self widthForLabel:model.name fontSize:15]+20, 50 *kHeightScale);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击的是什么%ld",(long)indexPath.row);
    
    for (int i = 0; i<self.modelArray.count; i++) {
            HomeShopListSizeModel *model = self.modelArray[i];
        model.isHave = NO;
        [self.modelArray replaceObjectAtIndex:i withObject:model];
    }
        HomeShopListSizeModel *model = self.modelArray[indexPath.row];
    // 回调出去
    if (self.clickedCollectionCellBlock) {
        self.clickedCollectionCellBlock(indexPath.row,model.attrid);
    }

    

    [self.modelArray removeObject:model];
    model.isHave = YES;
    [self.modelArray insertObject:model atIndex:0];
    
    [self.collectionView reloadData];

    
    
}
- (void)setValueWithModelArray:(NSMutableArray *)modelArray
{
    self.modelArray = modelArray;
    [self.collectionView reloadData];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/**
 *  计算文字长度
 */
- (CGFloat)widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    return size.width;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
