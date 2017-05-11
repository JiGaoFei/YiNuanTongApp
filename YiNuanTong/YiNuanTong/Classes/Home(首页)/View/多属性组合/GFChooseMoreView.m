//
//  GFChooseMoreView.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GFChooseMoreView.h"
#import "UIImageView+WebCache.h"
#import "GFChooseOneViewCell.h"
#import "HomeShopListSizeModel.h"
#import "GFChooseMoreTitleCell.h"
#import "GFChooseMoreOrderCell.h"
#import "GoodDetailAttrtypeModel.h"

@interface GFChooseMoreView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *titleOnetableView;
@property (nonatomic,strong) UITableView *titleTwotableView;
@property (nonatomic,strong) UITableView *titleThreetableView;
@property (nonatomic,strong) UITableView *titleFouretableView;
@property (nonatomic,strong) UILabel *titleOneLab;
@property (nonatomic,strong) UILabel *titleTwoLab;
@property (nonatomic,strong) UILabel *titleThreeLab;
@property (nonatomic,strong) UILabel *titleFourLab;
@property (nonatomic,strong ) GFChooseMoreTitleCell *oneSelectCell;
@property (nonatomic,strong ) GFChooseMoreTitleCell *twoSelectCell;
@property (nonatomic,strong ) GFChooseMoreTitleCell *threeSelectCell;
@property (nonatomic,strong ) GFChooseMoreTitleCell *fourSelectCell;
/**单项总件数*/
@property (nonatomic,assign) double totalNumber;
/**单项总钱数*/
@property (nonatomic,assign) double totalMoney;
/**总件数*/
@property (nonatomic,assign) double alltotalNumber;
/**总钱数*/
@property (nonatomic,assign) double alltotalMoney;
/**存放要添加到购物车的dic*/
@property (nonatomic,strong) NSMutableDictionary *shopCarGoodsDic;
/**数据源*/
@property (nonatomic,strong) NSMutableArray *modelArray;
/** 一级规格尺寸数据 */
@property (nonatomic,strong) NSMutableArray *sizeDataOneArr;
/** 二级规格尺寸 */
@property (nonatomic,strong) NSMutableArray *sizeDataTwoArr;
/** 三级规格尺寸 */
@property (nonatomic,strong) NSMutableArray *sizeDataThreeArr;
/**四级规格尺寸*/
@property (nonatomic,strong) NSMutableArray * sizeDataFourArr;
/**类型名字*/
@property (nonatomic,strong) NSMutableArray *attrtypeDataArr;

/** selectStatus 控制为model数量赋值*/
@property (nonatomic,assign) NSInteger  selectStatus;


@end
static NSString *identifier = @"GFChooseOneViewCell1";
static NSString *identifierTitle1 = @"GFChooseOneViewCellTitle1";
static NSString *identifierTitle2 = @"GFChooseOneViewCellTitle2";
static NSString *identifierTitle3 = @"GFChooseOneViewCellTitl3";
static NSString *identifierTitle4 = @"GFChooseOneViewCellTitl4";
static NSString *identifierTitleOrder = @"GFChooseOneViewCellTitlOrder";
@implementation GFChooseMoreView
 - (NSMutableDictionary *)shopCarGoodsDic
{
    if (!_shopCarGoodsDic) {
        self.shopCarGoodsDic = [[NSMutableDictionary alloc]init];
    }
    return _shopCarGoodsDic;
}
- (UITableView *)titleOnetableView
{
    if (!_titleOnetableView) {
        self.titleOnetableView = [[UITableView alloc]init];
    }
    return _titleOnetableView;
}
- (UITableView *)titleTwotableView
{
    if (!_titleTwotableView) {
        self.titleTwotableView = [[UITableView alloc]init];
    }
    return _titleTwotableView;
}

- (UITableView *)titleThreetableView
{
    if (!_titleThreetableView) {
        self.titleThreetableView = [[UITableView alloc]init];
    }
    return _titleThreetableView;
}
- (UITableView *)titleFouretableView
{
    if (!_titleFouretableView) {
        self.titleFouretableView = [[UITableView alloc]init];
    }
    return _titleFouretableView;
}
- (NSMutableArray *)attrtypeDataArr
{
    if (!_attrtypeDataArr) {
        self.attrtypeDataArr = [[NSMutableArray alloc]init];
        
    }
    return _attrtypeDataArr;
}
/** 五级商品数据源 */
- (NSMutableArray *)sizeDataOneArr
{
    if (!_sizeDataOneArr) {
        self.sizeDataOneArr = [[NSMutableArray alloc]init];
    }
    return _sizeDataOneArr;
}
- (NSMutableArray *)sizeDataTwoArr
{
    if (!_sizeDataTwoArr) {
        self.sizeDataTwoArr = [[NSMutableArray alloc]init];
    }
    return _sizeDataTwoArr;
}
- (NSMutableArray *)sizeDataThreeArr
{
    if (!_sizeDataThreeArr) {
        self.sizeDataThreeArr =[[NSMutableArray alloc]init];
    }
    return _sizeDataThreeArr;
}
- (NSMutableArray*)sizeDataFourArr
{
    if (!_sizeDataFourArr) {
        self.sizeDataFourArr = [[NSMutableArray alloc]init];
    }
    return _sizeDataFourArr;
}

- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        self.modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.selectStatus = 0;
        
        self.backgroundColor = [UIColor clearColor];
        //半透明视图
        self.alphaiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _alphaiView.backgroundColor = [UIColor blackColor];
        _alphaiView.alpha = 0.8;
        [self addSubview:_alphaiView];
        //装载商品信息的视图
        self.whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 125*kHeightScale, self.frame.size.width, self.frame.size.height-125*kHeightScale)];
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteView];
        //商品图片
        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(10*kWidthScale, -18*kHeightScale, 108*kWidthScale, 108*kWidthScale)];
        _img.image = [UIImage imageNamed:@"4"];
        _img.backgroundColor = [UIColor yellowColor];
        _img.layer.cornerRadius = 4;
        _img.layer.borderColor = [UIColor whiteColor].CGColor;
        _img.layer.borderWidth = 5;
        [_img.layer setMasksToBounds:YES];
        [_whiteView addSubview:_img];
        
        
        self.cancelBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(_whiteView.frame.size.width-38*kWidthScale, 10*kHeightScale,28*kWidthScale, 28*kWidthScale);
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_whiteView addSubview:_cancelBtn];
        
        //商品价格
        
        self.priceLab = [[UILabel alloc] initWithFrame:CGRectMake(125*kWidthScale, 55*kHeightScale, 200*kWidthScale, 20*kHeightScale)];
        self.priceLab.textColor = RGBA(247, 69, 49, 1);
        _priceLab.font = [UIFont systemFontOfSize:15];
        _priceLab.text = @"¥10";
        [_whiteView addSubview:_priceLab];
        //商品库存
        self.nameLab = [[UILabel alloc] initWithFrame:CGRectMake(125*kWidthScale, 30*kHeightScale, 200*kWidthScale, 20*kHeightScale)];
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.font = [UIFont systemFontOfSize:15*kHeightScale];
        _nameLab.text = @"你想要刘亦菲吗?";
        [_whiteView addSubview:_nameLab];
        
        //分界线
        self.lineLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _img.frame.origin.y+_img.frame.size.height+20*kHeightScale, _whiteView.frame.size.width, 0.5)];
        _lineLab.backgroundColor = [UIColor lightGrayColor];
        [_whiteView addSubview:_lineLab];
        
        self.confirmBtn= [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmBtn.frame = CGRectMake(0, self.frame.size.height-175*kHeightScale,_whiteView.frame.size.width, 50*kHeightScale);
        
        [_confirmBtn setBackgroundColor:  [UIColor colorWithRed:52.0/255 green:162.0/255 blue:252.0/255 alpha:1]];
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:0];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:20*kHeightScale];
        
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(GFChooseConfirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_whiteView addSubview:_confirmBtn];
        
        
        [self setUpTableView];
        
        
    }
    return self;
}
#pragma mark - tableView
- (void)setUpTableView
{
    // 创建titleView
  
  // 创建一级
    self.titleOneLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 245 *kHeightScale, 95 *kWidthScale, 45 *kHeightScale)];
    _titleOneLab.text = @"上进下出:";
 _titleOneLab.font = [UIFont fontWithName:@ "Helvetica-Bold"  size:(17.0)];
    [self addSubview:_titleOneLab];
      self.titleOnetableView = [[UITableView alloc]initWithFrame:CGRectMake(100 *kWidthScale, 245*kHeightScale  ,KScreenW - 98 *kWidthScale, 45 *kHeightScale)];

    self.titleOnetableView.backgroundColor = [UIColor greenColor];
      self.titleOnetableView.delegate = self;
   self.titleOnetableView.dataSource = self;
   self.titleOnetableView.separatorStyle = NO;
   self.titleOnetableView.showsVerticalScrollIndicator  = NO;
    [self.titleOnetableView registerClass:[GFChooseMoreOrderCell class] forCellReuseIdentifier:identifierTitleOrder];

    [self addSubview: self.titleOnetableView];
    
    
    
    
   // 创建二级
    self.titleTwoLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 290 *kHeightScale, 95 *kWidthScale, 45 *kHeightScale)];
    _titleTwoLab.text = @"上进下出:";
    _titleTwoLab.font = [UIFont fontWithName:@ "Helvetica-Bold"  size:(17.0)];
    [self addSubview:_titleTwoLab];
    self.titleTwotableView = [[UITableView alloc]initWithFrame:CGRectMake(330 *kWidthScale, 65*kHeightScale ,45 *kHeightScale, 500 *kHeightScale)];

    //  self.titleOnetableView.backgroundColor = [UIColor blueColor];
    self.titleTwotableView .transform = CGAffineTransformMakeRotation(-M_PI / 2);
   self.titleTwotableView.delegate = self;
   self.titleTwotableView.dataSource = self;
    self.titleTwotableView.separatorStyle = NO;
   self.titleTwotableView.showsVerticalScrollIndicator  = NO;
    [self.titleTwotableView  registerClass:[GFChooseMoreTitleCell class] forCellReuseIdentifier:identifierTitle2];
  [self addSubview: self.titleTwotableView];
    
     // 创建三级
    self.titleThreeLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 335 *kHeightScale, 95 *kWidthScale, 45 *kHeightScale)];
    _titleThreeLab.text = @"上进下出:";
    _titleThreeLab.font = [UIFont fontWithName:@ "Helvetica-Bold"  size:(17.0)];
    [self addSubview:_titleThreeLab];
    self.titleThreetableView = [[UITableView alloc]initWithFrame:CGRectMake(330 *kWidthScale, 110*kHeightScale ,45 *kHeightScale, 500 *kHeightScale)];
 
    //  self.titleOnetableView.backgroundColor = [UIColor blueColor];
    self.titleThreetableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    self.titleThreetableView.delegate = self;
    self.titleThreetableView.dataSource = self;
    self.titleThreetableView.separatorStyle = NO;
    self.titleThreetableView.showsVerticalScrollIndicator  = NO;
    [self.titleThreetableView  registerClass:[GFChooseMoreTitleCell class] forCellReuseIdentifier:identifierTitle3];
   [self addSubview: self.titleThreetableView];

     // 创建四级
    self.titleFourLab = [[UILabel alloc]initWithFrame:CGRectMake(5, 380 *kHeightScale, 95 *kWidthScale, 45 *kHeightScale)];
    _titleFourLab.text = @"上进下出:";
    _titleFourLab.font = [UIFont fontWithName:@ "Helvetica-Bold"  size:(17.0)];
    [self addSubview:_titleFourLab];
    self.titleFouretableView = [[UITableView alloc]initWithFrame:CGRectMake(330 *kWidthScale, 155*kHeightScale ,45 *kHeightScale, 500 *kHeightScale)];
   
    //  self.titleOnetableView.backgroundColor = [UIColor blueColor];
     self.titleFouretableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
     self.titleFouretableView.delegate = self;
     self.titleFouretableView.dataSource = self;

     self.titleFouretableView.separatorStyle = NO;
     self.titleFouretableView.showsVerticalScrollIndicator  = NO;
    [self.titleFouretableView  registerClass:[GFChooseMoreTitleCell class] forCellReuseIdentifier:identifierTitle4];
    [self addSubview:  self.titleFouretableView];


    
    

    
    // 创建titleTableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 450*kHeightScale , KScreenW, 150*kHeightScale) style:UITableViewStylePlain];
    self.backgroundColor = [UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    // 注册cell
    [self.tableView registerClass:[GFChooseOneViewCell class] forCellReuseIdentifier:identifier];
    [self addSubview:self.tableView];
    
    
    
    
    
    
    
    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-84 *kHeightScale, KScreenW, 34 *kHeightScale)];
    bagView.backgroundColor = RGBA(249, 249, 249, 1);
    
    
    [self addSubview:bagView];
    
    // 创建件数:
    self.goodsNumberLab = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW- 160 *kHeightScale,10 *kHeightScale, 80*kWidthScale, 20*kHeightScale)];
    _goodsNumberLab.textColor = [UIColor redColor];
    self.goodsNumberLab.text = @"共0件";
    [bagView addSubview:_goodsNumberLab];
    
    // 创建价格
    UILabel *totallPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW - 80*kWidthScale, 10 *kHeightScale, 80*kWidthScale, 20*kHeightScale)];
    
    totallPriceLab.textColor = [UIColor redColor];
    totallPriceLab.text = @"0";
    
    self.totallMoneyLab  = totallPriceLab;
    [bagView addSubview:totallPriceLab];
    
    [self bringSubviewToFront:self.titleOnetableView];
    
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.titleOnetableView]) {
        return    self.sizeDataOneArr.count;
    }
    if ([tableView isEqual:self.titleTwotableView]) {
        return self.sizeDataTwoArr.count;
    }

    if ([tableView isEqual:self.titleThreetableView]) {
        return self.sizeDataThreeArr.count;
    }

    if ([tableView isEqual:self.titleFouretableView]) {
        return self.sizeDataFourArr.count;
    }
    if ([tableView isEqual:self.tableView]) {
        return self.modelArray.count;
    }

    return 8;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView]) {
        GFChooseOneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        HomeShopListSizeModel *model = self.modelArray[indexPath.row];
       GoodDetailAttrtypeModel *attrtypeModel = self.attrtypeDataArr[4];
        
       [cell setValueWithModel:model andWithAttryModel:attrtypeModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.addBtnBloock =  ^(NSString *str){
            NSLog(@"点击的是规格加号,数量为%@",str);
               // 重新为数量赋值
                  model.num = str;
//            switch (self.selectStatus) {
//                case 0:
//                {
//                    // 重新为数量赋值
//                    model.num = str;
//                }
//                    break;
//                    
//                case 1:
//                {
//                    // 重新为数量赋值
//                    model.num1 = str;
//                }
//                    break;
//                case 2:
//                {
//                    // 重新为数量赋值
//                    model.num2 = str;
//                }
//                    break;
//                case 3:
//                {
//                    // 重新为数量赋值
//                    model.num3 = str;
//                }
//                    break;
//                    
//                default:
//                    break;
//            }
//          
            
            // 更换数据源
            [self.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
             NSInteger number = [model.num integerValue];
            if (number == 0) {
                return ;
            }else{
                [self.shopCarGoodsDic setObject:model.num forKey:model.good_attid];
                // 计算价格
                [self countSizeTableViewAllShopGoodNums:self.modelArray];
                
                // 刷新该行数据源
                [self.tableView reloadData];
            }
            
           
        
            
            
            
        };
        
        cell.cutBtnBloock =  ^(NSString *str){
            NSLog(@"点击的是规格减号,数量为%@",str);
            // 重新为数量赋值
                model.num = str;
            
//            switch (self.selectStatus) {
//                case 0:
//                {
//                    // 重新为数量赋值
//                    model.num = str;
//                }
//                    break;
//                    
//                case 1:
//                {
//                    // 重新为数量赋值
//                    model.num1 = str;
//                }
//                    break;
//                case 2:
//                {
//                    // 重新为数量赋值
//                    model.num2 = str;
//                }
//                    break;
//                case 3:
//                {
//                    // 重新为数量赋值
//                    model.num3 = str;
//                }
//                    break;
//                    
//                default:
//                    break;
//            }

            // 更换数据源
            [self.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
            NSInteger number = [model.num integerValue];
            if (number == 0) {
                //数据源
                [self.shopCarGoodsDic removeObjectForKey:model.good_attid];
              
            }else{
                // 添加数据源
                [self.shopCarGoodsDic setObject:model.num forKey:model.good_attid];
                
                // 计算价格
                [self countSizeTableViewAllShopGoodNums:self.sizeDataOneArr];
                
                // 刷新该行数据源
                [self.tableView reloadData];
                
            }
            
    
            
            
        };

        cell.confirmBtnBlock = ^(NSString *str){
            
            // 重新为数量赋值
            model.num = str;
            // 更换数据源
            [self.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
            if ([str isEqualToString:@""]||[str isEqualToString:@"0"]) {
              // 数据为空时移除
                [self.shopCarGoodsDic removeObjectForKey:model.good_attid];
                
            }else{
                // 数据不为空时添加数据源
                 [self.shopCarGoodsDic setObject:model.num forKey:model.good_attid];
            }
           
            // 计算价格
            [self countSizeTableViewAllShopGoodNums:self.modelArray];
            
            // 刷新该行数据源
            [self.tableView reloadData];
        };
   
             return cell;
    
    }
    if ([tableView isEqual:self.titleOnetableView]) {
        NSString *str = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        GFChooseMoreOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        
        if (!cell) {
            cell = [[GFChooseMoreOrderCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
            
        }
        cell.selectionStyle = UITableViewCellAccessoryNone;
        
        
       //  HomeShopListSizeModel *model = self.sizeDataOneArr[indexPath.row];
        [cell setValueWithModelArray:self.sizeDataOneArr];
       // cell.nameLab.text = model.name;
//        if (indexPath.row == 0) {
////         cell.nameLab.textColor = CGRBlue;
////            cell.nameLab.layer.borderColor =[CGRBlue CGColor];
////            cell.nameLab.layer.borderWidth = 1;
////            cell.nameLab.layer.cornerRadius = 5;
////            cell.nameLab.layer.masksToBounds = YES;
//        }

      //  [cell setValueWithModel:model];
        return cell;

     
        
    }

    if ([tableView isEqual:self.titleTwotableView]) {
        NSString *str = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        GFChooseMoreTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        
        if (!cell) {
            cell = [[GFChooseMoreTitleCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        }        self.twoSelectCell = cell;
        cell.selectionStyle = UITableViewCellAccessoryNone;
        
        HomeShopListSizeModel *model = self.sizeDataTwoArr[indexPath.row];
        cell.nameLab.text = model.name;
        if (indexPath.row == 0) {
           cell.nameLab.textColor = CGRBlue;
            cell.nameLab.layer.borderColor =[CGRBlue CGColor];
            cell.nameLab.layer.borderWidth = 1;
            cell.nameLab.layer.cornerRadius = 5;
            cell.nameLab.layer.masksToBounds = YES;
        }

           [cell setValueWithModel:model];
        return cell;
        
    }

    if ([tableView isEqual:self.titleThreetableView]) {
        
        NSString *str = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        GFChooseMoreTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        
        if (!cell) {
            cell = [[GFChooseMoreTitleCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellAccessoryNone;
        HomeShopListSizeModel *model = self.sizeDataThreeArr[indexPath.row];
        cell.nameLab.text = model.name;
        
        
        
        if (indexPath.row == 0) {
            cell.nameLab.textColor = CGRBlue;
            cell.nameLab.layer.borderColor =[CGRBlue CGColor];
            cell.nameLab.layer.borderWidth = 1;
            cell.nameLab.layer.cornerRadius = 5;
            cell.nameLab.layer.masksToBounds = YES;
        }
        [cell setValueWithModel:model];
        return cell;
    }
    
    if ([tableView isEqual:self.titleFouretableView]) {
    
        NSString *str = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        GFChooseMoreTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
 
        if (!cell) {
            cell = [[GFChooseMoreTitleCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellAccessoryNone;
        HomeShopListSizeModel *model = self.sizeDataFourArr[indexPath.row];
           cell.nameLab.text = model.name;
        self.fourSelectCell = cell;
     
     
        if (indexPath.row == 0) {
            cell.nameLab.textColor = CGRBlue;
            cell.nameLab.layer.borderColor =[CGRBlue CGColor];
            cell.nameLab.layer.borderWidth = 1;
            cell.nameLab.layer.cornerRadius = 5;
            cell.nameLab.layer.masksToBounds = YES;
        }
        [cell setValueWithModel:model];
        return cell;
        
    }

    return [[UITableViewCell alloc]init];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.titleOnetableView]) {
        HomeShopListSizeModel *model = self.sizeDataOneArr[indexPath.row];
        [self.sizeDataOneArr removeObject:model];
     
        if ([self.delegate respondsToSelector:@selector(GFChooseMoreViewLine:andWithGoodIDs:)]) {
            [self.delegate GFChooseMoreViewLine:0 andWithGoodIDs:model.attrid];
        }
        
        
        [self.sizeDataOneArr insertObject:model atIndex:0];
        [self.titleOnetableView reloadData];
        self.titleOnetableView.contentOffset = CGPointMake(0, 0);
        
    
        self.selectStatus = 0;
    }
    
    if ([tableView isEqual:self.titleTwotableView]) {
       
        HomeShopListSizeModel *model = self.sizeDataTwoArr[indexPath.row];
        [self.sizeDataTwoArr removeObject:model];
        if ([self.delegate respondsToSelector:@selector(GFChooseMoreViewLine:andWithGoodIDs:)]) {
            HomeShopListSizeModel *model1 = self.sizeDataOneArr[0];
            NSString *good_id = [NSString stringWithFormat:@"%@,%@",model1.attrid,model.attrid];
            [self.delegate GFChooseMoreViewLine:1 andWithGoodIDs:good_id];
        }
        

        [self.sizeDataTwoArr insertObject:model atIndex:0];
        [self.titleTwotableView reloadData];
        self.titleTwotableView.contentOffset = CGPointMake(0, 0);
        
             self.selectStatus = 1;
    }
    
    if ([tableView isEqual:self.titleThreetableView]) {
     
        HomeShopListSizeModel *model = self.sizeDataThreeArr[indexPath.row];
        [self.sizeDataThreeArr removeObject:model];
        
        if ([self.delegate respondsToSelector:@selector(GFChooseMoreViewLine:andWithGoodIDs:)]) {
            HomeShopListSizeModel *model1 = self.sizeDataOneArr[0];
            HomeShopListSizeModel *model2 = self.sizeDataTwoArr[0];
            NSString *good_id = [NSString stringWithFormat:@"%@,%@,%@",model1.attrid,model2.attrid,model.attrid];
            [self.delegate GFChooseMoreViewLine:2 andWithGoodIDs:good_id];
        }

        [self.sizeDataThreeArr insertObject:model atIndex:0];
        [self.titleThreetableView reloadData];
        self.titleThreetableView.contentOffset = CGPointMake(0,0);
             self.selectStatus = 2;
    }
    
    if ([tableView isEqual:self.titleFouretableView]) {
        HomeShopListSizeModel *model = self.sizeDataFourArr[indexPath.row];
        [self.sizeDataFourArr removeObject:model];
      
        if ([self.delegate respondsToSelector:@selector(GFChooseMoreViewLine:andWithGoodIDs:)]) {
            HomeShopListSizeModel *model1 = self.sizeDataOneArr[0];
            HomeShopListSizeModel *model2 = self.sizeDataTwoArr[0];
            HomeShopListSizeModel *model3 = self.sizeDataThreeArr[0];
            NSString *good_id = [NSString stringWithFormat:@"%@,%@,%@,%@",model1.attrid,model2.attrid,model3.attrid,model.attrid];
            [self.delegate GFChooseMoreViewLine:3 andWithGoodIDs:good_id];
        }

        
        [self.sizeDataFourArr insertObject:model atIndex:0];
        [self.titleFouretableView reloadData];
        self.titleFouretableView.contentOffset = CGPointMake(0,0);
             self.selectStatus = 3;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if ([tableView isEqual:self.tableView]) {
        return 63 *kHeightScale;
    }
    if ([tableView isEqual:self.titleOnetableView]) {
        HomeShopListSizeModel *model = self.sizeDataOneArr[indexPath.row];
     CGFloat  H =    [self widthForLabel:model.name fontSize:15 *kHeightScale];
        return H +30 *kHeightScale;
    }
    if ([tableView isEqual:self.titleTwotableView]) {
        HomeShopListSizeModel *model = self.sizeDataTwoArr[indexPath.row];
    CGFloat  H =       [self widthForLabel:model.name fontSize:15 *kHeightScale];
          return H+30 *kHeightScale;
    }

    if ([tableView isEqual:self.titleThreetableView]) {
        HomeShopListSizeModel *model = self.sizeDataThreeArr[indexPath.row];
      CGFloat  H =     [self widthForLabel:model.name fontSize:15 *kHeightScale];
        return H+30 *kHeightScale;
    }
    if ([tableView isEqual:self.titleFouretableView]) {
        HomeShopListSizeModel *model = self.sizeDataFourArr[indexPath.row];
       CGFloat  H =    [self widthForLabel:model.name fontSize:15 *kHeightScale];
          return H+30 *kHeightScale;
    }

    return 0;
}
/**
 *  计算文字长度
 */
- (CGFloat)widthForLabel:(NSString *)text fontSize:(CGFloat)font
{
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    return size.width;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  

   
    NSLog(@"%f",self.titleOnetableView.frame.size.width);

}
#pragma mark - 确定按钮点击事件
- (void)GFChooseConfirmBtnAction:(UIButton *)sender
{
    NSLog(@"确定按钮的点击事件");
    if ([self.delegate respondsToSelector:@selector(GFChooseMoreViewClickConfirmBtnActionWithDic:)]) {
        [self.delegate GFChooseMoreViewClickConfirmBtnActionWithDic:self.shopCarGoodsDic];
    }
}
#pragma mark - 取消按钮点击事件
- (void)cancelBtnAction:(UIButton *)sender
{
    NSLog(@"取消按钮点击事件");
    if ([self.delegate respondsToSelector:@selector(GFChooseMoreViewCancelBtn)]) {
        [self.delegate GFChooseMoreViewCancelBtn];
    }
}
#pragma mark - 赋值
- (void)setGFChooseOneViewValueWithModelArray:(NSMutableArray *)modelArray andParams:(NSMutableDictionary *)params
{
    
    self.modelArray = modelArray;
    
    NSURL *urlStr = [NSURL URLWithString:[NSString stringWithFormat:@"%@",params[@"url"]]];
    
    [self.img sd_setImageWithURL:urlStr];
    
    self.nameLab.text = params[@"name"];
    self.priceLab.text = params[@"price"];
    [self.tableView reloadData];
    
    
}

#pragma mark -创建titleView
- (void)setUpTitleViewWith:(UITableView *)titleTableView andWithIndex:(NSInteger )index
{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(5, 245 *kHeightScale + 45 *kHeightScale *index, 95 *kWidthScale, 45 *kHeightScale)];
    lab.text = @"上进下出:";
    lab.font = [UIFont fontWithName:@ "Helvetica-Bold"  size:(20.0)];
    [self addSubview:lab];
   titleTableView = [[UITableView alloc]initWithFrame:CGRectMake(330 *kWidthScale, 20*kHeightScale + 45 *kHeightScale *index,45 *kHeightScale, 500 *kHeightScale)];
    titleTableView.backgroundColor = [UIColor greenColor];
    //  self.titleOnetableView.backgroundColor = [UIColor blueColor];
     titleTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
     titleTableView.delegate = self;
     titleTableView.dataSource = self;
    titleTableView.separatorStyle = NO;
     titleTableView.showsVerticalScrollIndicator  = NO;
//    [ titleTableView registerClass:[GFChooseMoreTitleCell class] forCellReuseIdentifier:identifierTitle];
    [self addSubview: titleTableView];

}
// 为多级赋值
- (void)setGFChooseMoreViewValueWithParams:(NSMutableDictionary *)params andWithAttrtypeArr:(NSMutableArray *)modelArray
{
    
    // 清空数据源
    [self.sizeDataOneArr removeAllObjects];
    [self.sizeDataTwoArr removeAllObjects];
    [self.sizeDataThreeArr removeAllObjects];
    [self.sizeDataFourArr removeAllObjects];
    
//    self.sizeDataOneArr = params[@"a0"];
//    self.sizeDataTwoArr=params[@"a1"];
//    self.sizeDataThreeArr=params[@"a2"];
//    self.sizeDataFourArr = params[@"a3"];
//    self.attrtypeDataArr = params[@"a4"];
    for (HomeShopListSizeModel *model in params[@"a0"] ) {
        [self.sizeDataOneArr addObject:model];
        NSLog(@"传过来的值:%@",model.name);
    }
    for (HomeShopListSizeModel *model in params[@"a1"] ) {
        [self.sizeDataTwoArr addObject:model];
        NSLog(@"传过来的值:%@",model.name);
    }
    for (HomeShopListSizeModel *model in params[@"a2"] ) {
        [self.sizeDataThreeArr addObject:model];
        NSLog(@"传过来的值:%@",model.name);
    }
    
    for (HomeShopListSizeModel *model in params[@"a3"] ) {
        [self.sizeDataFourArr addObject:model];
        NSLog(@"传过来的值:%@",model.name);
    }
    
    for (HomeShopListSizeModel *model in params[@"a4"] ) {
        [self.attrtypeDataArr addObject:model];
        NSLog(@"传过来的值:%@",model.name);
    }

    HomeShopListSizeModel *model1 = self.attrtypeDataArr[0];
      HomeShopListSizeModel *model2 = self.attrtypeDataArr[1];
      HomeShopListSizeModel *model3 = self.attrtypeDataArr[2];
      HomeShopListSizeModel *model4 = self.attrtypeDataArr[3];
    self.titleOneLab.text =[NSString stringWithFormat:@"%@:",model1.name];
    self.titleTwoLab.text = [NSString stringWithFormat:@"%@:",model2.name];
    self.titleThreeLab.text = [NSString stringWithFormat:@"%@:",model3.name];
    self.titleFourLab.text = [NSString stringWithFormat:@"%@:",model4.name];

    [self.titleOnetableView reloadData];
    [self.titleTwotableView reloadData];
    [self.titleThreetableView reloadData];
    [self.titleFouretableView reloadData];
    [self.tableView reloadData];
}
- (void)setGFChooseMoreViewValueWithModelArray:(NSMutableArray *)modelArray andParams:(NSMutableDictionary *)params
{
       [self.modelArray removeAllObjects];
    for (HomeShopListSizeModel *model in modelArray) {
        [self.modelArray addObject:model];
    }
 
    
    NSURL *urlStr = [NSURL URLWithString:[NSString stringWithFormat:@"%@",params[@"url"]]];
    
    [self.img sd_setImageWithURL:urlStr];
    
    self.nameLab.text = params[@"name"];
    self.priceLab.text = params[@"price"];
    [self.tableView reloadData];
    
    
}

// 动态为多级赋值
// 动态为多级赋值
- (void)setGFChooseMoreViewValueWithParams:(NSDictionary *)params andWithAttrtypeArr:(NSMutableArray *)modelArray andWithIndex:(NSInteger)index
{
 
    switch (index) {
        case 0:
        {
            // 清空数据源
            
            [self.sizeDataTwoArr removeAllObjects];
            [self.sizeDataThreeArr removeAllObjects];
            [self.sizeDataFourArr removeAllObjects];
            [self.modelArray removeAllObjects];
            
            for (HomeShopListSizeModel *model in params[@"a1"] ) {
                [self.sizeDataTwoArr addObject:model];
                NSLog(@"传过来的值:%@",model.name);
            }
            for (HomeShopListSizeModel *model in params[@"a2"] ) {
                [self.sizeDataThreeArr addObject:model];
                NSLog(@"传过来的值:%@",model.name);
            }

            for (HomeShopListSizeModel *model in params[@"a3"] ) {
                [self.sizeDataFourArr addObject:model];
                NSLog(@"传过来的值:%@",model.name);
            }

            for (HomeShopListSizeModel *model in params[@"a4"] ) {
                [self.modelArray addObject:model];
                NSLog(@"传过来的值:%@",model.name);
            }



            [self.titleTwotableView reloadData];
            [self.titleThreetableView reloadData];
            [self.titleFouretableView reloadData];
            [self.tableView reloadData];
        }
            break;
        case 1:
        {
          
            [self.sizeDataThreeArr removeAllObjects];
            [self.sizeDataFourArr removeAllObjects];
             [self.modelArray removeAllObjects];
        
            for (HomeShopListSizeModel *model in params[@"a2"] ) {
                [self.sizeDataThreeArr addObject:model];
                NSLog(@"传过来的值:%@",model.name);
            }
            
            for (HomeShopListSizeModel *model in params[@"a3"] ) {
                [self.sizeDataFourArr addObject:model];
                NSLog(@"传过来的值:%@",model.name);
            }
            
            for (HomeShopListSizeModel *model in params[@"a4"] ) {
                [self.modelArray addObject:model];
                NSLog(@"传过来的值:%@",model.name);
            }

            [self.titleThreetableView reloadData];
            [self.titleFouretableView reloadData];
            [self.tableView reloadData];
        }
            break;

        case 2:
        {
            
            [self.sizeDataFourArr removeAllObjects];
             [self.modelArray removeAllObjects];
     
          
            
            for (HomeShopListSizeModel *model in params[@"a3"] ) {
                [self.sizeDataFourArr addObject:model];
                NSLog(@"传过来的值:%@",model.name);
            }
            
            for (HomeShopListSizeModel *model in params[@"a4"] ) {
                [self.modelArray addObject:model];
                NSLog(@"传过来的值:%@",model.name);
            }
            

 
            [self.titleFouretableView reloadData];
            [self.tableView reloadData];
        }
            break;

        case 3:
        {
          [self.modelArray removeAllObjects];
         
            for (HomeShopListSizeModel *model in params[@"a4"] ) {
                [self.modelArray addObject:model];
                NSLog(@"传过来的值:%@",model.name);
            }
            
            [self.tableView reloadData];


        }
            break;

            
        default:
            break;
    }
    


}

#pragma mark - 计算单个sizeTableView列表的件数
- (NSInteger)countSizeTableViewAllShopGoodNums:(NSMutableArray *)arr
{
    self.alltotalNumber  = 0;
    self.alltotalMoney = 0;
    self.totalMoney = 0;
    self.totalNumber = 0;

    for (HomeShopListSizeModel *model in self.modelArray) {
                // 单项总数量
                self.totalNumber +=[model.num doubleValue];
                // 单价
                double price = [model.price doubleValue];
                // 单项总钱数
                self.totalMoney += [model.num integerValue] *price;
                NSLog(@"%f",self.totalMoney);
    }
    

    HomeShopListSizeModel *oneModel = self.sizeDataOneArr[0];
    
    
    switch (self.selectStatus) {
        case 0:
        {
            oneModel.num =[NSString stringWithFormat:@"%f",self.totalNumber];
            oneModel.price = [NSString stringWithFormat:@"%f",self.totalMoney];
            
            [self.sizeDataOneArr replaceObjectAtIndex:0 withObject:oneModel];
            
        }
            break;
        case 1:
        {
            oneModel.num1 =[NSString stringWithFormat:@"%f",self.totalNumber];
            oneModel.price1 = [NSString stringWithFormat:@"%f",self.totalMoney];
            [self.sizeDataOneArr replaceObjectAtIndex:0 withObject:oneModel];
        }
            break;
        case 2:
        {
            oneModel.num2 =[NSString stringWithFormat:@"%f",self.totalNumber];
            oneModel.price2 = [NSString stringWithFormat:@"%f",self.totalMoney];
            [self.sizeDataOneArr replaceObjectAtIndex:0 withObject:oneModel];
        }
            break;
        case 3:
        {
            oneModel.num3 =[NSString stringWithFormat:@"%f",self.totalNumber];
            oneModel.price3 = [NSString stringWithFormat:@"%f",self.totalMoney];
            [self.sizeDataOneArr replaceObjectAtIndex:0 withObject:oneModel];
        }
            break;
            
        default:
            break;
    }

    
    
    
    // 计算总的
    for (HomeShopListSizeModel *model in self.sizeDataOneArr) {
        // 单项总数量
        self.alltotalNumber +=([model.num doubleValue]+[model.num1 doubleValue]+[model.num2 doubleValue] + [model.num3 doubleValue]);
       
        // 单项总钱数
        self.alltotalMoney +=([model.price doubleValue] + [model.price1 doubleValue] +[model.price2 doubleValue]+[model.price3 doubleValue]) ;
        NSLog(@"%f",self.totalMoney);
    }
   
    
    // 为件数赋值
    [self setToatalNumberColor:self.goodsNumberLab andStr:[NSString stringWithFormat:@"共%ld件",(long)self.alltotalNumber]];
    // 为总价格赋值
    [self setToatalNumberColor:self.totallMoneyLab andStr:[NSString stringWithFormat:@"¥%.2f",self.alltotalMoney]];
    [self.titleOnetableView reloadData];
    
    return self.alltotalNumber;
}
#pragma mark - 设置字体颜色
- (void)setToatalNumberColor:(UILabel *)lab andStr:(NSString *)str
{
    
    NSRange Range1 = NSMakeRange([str rangeOfString:@"共"].location, [str rangeOfString:@"共"].length);
    NSRange Range2 = NSMakeRange([str rangeOfString:@"件"].location, [str rangeOfString:@"件"].length);
    NSMutableAttributedString *textLabelStr =
    [[NSMutableAttributedString alloc]
     initWithString:str];
    [textLabelStr
     setAttributes:@{NSForegroundColorAttributeName :
                         [UIColor grayColor], NSFontAttributeName :
                         [UIFont systemFontOfSize:17]} range:Range1];
    
    [textLabelStr setAttributes:@{NSForegroundColorAttributeName :
                                      [UIColor grayColor], NSFontAttributeName :
                                      [UIFont systemFontOfSize:17]} range:Range2];
    lab.attributedText = textLabelStr;
}
@end
