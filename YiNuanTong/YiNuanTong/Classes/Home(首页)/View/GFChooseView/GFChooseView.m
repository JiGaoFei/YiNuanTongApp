//
//  GFChooseView.m
//  弹出框
//
//  Created by 1暖通商城 on 2017/3/24.
//  Copyright © 2017年 1暖通商城. All rights reserved.
//

#import "GFChooseView.h"
#import "GFtableviewCell.h"
#import "BadgeButton.h"
#import "Model.h"
#import "HomeShopListSizeModel.h"
#import "UIImageView+WebCache.h"
#import "GFTitleTableViewCell.h"

#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH    [UIScreen mainScreen].bounds.size.height
// 屏幕宽的比例
#define kWidthScale [UIScreen mainScreen].bounds.size.width / 375
// 屏幕高的比例
#define kHeightScale [UIScreen mainScreen].bounds.size.height / 667
@interface GFChooseView ()<UITableViewDelegate,UITableViewDataSource>

/** 选中的按钮*/
@property (nonatomic, weak) UIButton *selectBtn;
// 当前按钮的宽度
@property (nonatomic,assign) CGFloat currentBtnWidth;

@property (nonatomic,strong) UITableView *sizeTableView;
@property (nonatomic,strong) UITableView *titleTableView;
@property (nonatomic,strong) NSMutableArray *modelArr;
@property (nonatomic,strong) UITableView *tableView;
/**总件数*/
@property (nonatomic,assign) NSInteger totalNumber;
/**总钱数*/
@property (nonatomic,assign) NSInteger totalMoney;
/**单项件数*/
@property (nonatomic,assign) NSInteger singleTotalNumber;
/**单项钱数*/
@property (nonatomic,assign) NSInteger singleTotalMoney;
/**规格选项数据源*/
@property (nonatomic,strong) NSMutableArray *titleBtnArray;
/**首级btnModelArray*/
@property (nonatomic,strong) NSMutableArray *firstBtnModelArray;
// 存放总下标
@property (nonatomic,assign) NSInteger totallIndex;

/**存放要添加到购物车的数组*/
@property (nonatomic,strong) NSMutableArray *shopCarGoodsArr;
/**存放要添加到购物车的dic*/
@property (nonatomic,strong) NSMutableDictionary *shopCarGoodsDic;



@end
static NSString *identifier = @"GFChooseCell";
static NSString *chooseCell = @"chooseCell";
@implementation GFChooseView
#pragma mark - 懒加载
 - (NSMutableDictionary *)shopCarGoodsDic
{
    if (!_shopCarGoodsDic) {
        self.shopCarGoodsDic = [[NSMutableDictionary alloc]init];
    }
    return _shopCarGoodsDic;
}
- (NSMutableArray *)shopCarGoodsArr
{
    if (!_shopCarGoodsArr) {
        self.shopCarGoodsArr = [[NSMutableArray alloc]init];
    }
    return _shopCarGoodsArr;
}
//首级btnModelArray
- (NSMutableArray *)firstBtnModelArray
{
    if (!_firstBtnModelArray) {
        self.firstBtnModelArray = [[NSMutableArray alloc]init];
    }
    return _firstBtnModelArray;
}
// 规格选项数据源
 - (NSMutableArray *)titleBtnArray
{
    if (!_titleBtnArray) {
        self.titleBtnArray = [[NSMutableArray alloc]init];
    }
    return _titleBtnArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        
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
        [_confirmBtn addTarget:self action:@selector(GFchooseConfirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_whiteView addSubview:_confirmBtn];
        
      
        [self setUpTableView];
        

    }
    return self;
}
#pragma mark - 加载数据
- (void)loadData
{
    
}
#pragma mark - tableView
- (void)setUpTableView
{
    
   // 创建titleTableView
    self.titleTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 256*kHeightScale , KScreenW, 170*kHeightScale) style:UITableViewStylePlain];
    self.titleTableView.backgroundColor = [UIColor redColor];
         self.titleTableView.delegate = self;
    self.titleTableView.dataSource = self;
    self.titleTableView.showsVerticalScrollIndicator = NO;
    self.titleTableView.showsHorizontalScrollIndicator = NO;
    self.titleTableView.scrollEnabled = NO;
    // 注册cell
    [self.titleTableView registerClass:[GFTitleTableViewCell class] forCellReuseIdentifier:chooseCell];
   
    [self addSubview:self.titleTableView];
    
    
    
    
    
    
    
    // 创建规格tableView
     self.sizeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 380*kHeightScale+44*kHeightScale*2, kScreenW, 100*kHeightScale) style:UITableViewStylePlain];
       _sizeTableView.delegate = self;
    _sizeTableView.dataSource = self;
    _sizeTableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [_sizeTableView registerClass:[GFtableviewCell class] forCellReuseIdentifier:identifier];
    [self addSubview:_sizeTableView];
    
    
    
    // 创建件数:
    self.goodsNumberLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW- 160 *kHeightScale, kScreenH - 100 *kHeightScale, 80*kWidthScale, 20*kHeightScale)];
    _goodsNumberLab.textColor = [UIColor redColor];
    [self addSubview:_goodsNumberLab];
    
    // 创建价格
    UILabel *totallPriceLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenW - 80*kWidthScale, kScreenH - 100 *kHeightScale, 80*kWidthScale, 20*kHeightScale)];
    
    totallPriceLab.textColor = [UIColor redColor];
 
    self.totallMoneyLab  = totallPriceLab;
    [self addSubview:totallPriceLab];
    
    }
#pragma mark - 点击确定按钮
- (void)GFchooseConfirmBtnAction:(UIButton *)sender
{
    
    if ([self.delegate respondsToSelector:@selector(chooseViewConfirmButtonActionWithArr:)]) {
        [self.delegate chooseViewConfirmButtonActionWithArr:self.shopCarGoodsDic];
    }
   // [self.shopCarGoodsArr removeAllObjects];
}
#pragma mark - 点击关闭按钮
- (void)cancelBtnAction:(UIButton *)sender
{
  
    if ([self.delegate respondsToSelector:@selector(closeButtonAction)]) {
        [self.delegate closeButtonAction];
    }
   }
#pragma mark -tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    if ([tableView isEqual:self.titleTableView]) {
        return self.titleBtnArray.count;
    }else{
         return self.modelArr.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  

    if ([tableView isEqual: self.sizeTableView]) {
        GFtableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        HomeShopListSizeModel *model = self.modelArr[indexPath.row];
        cell.sizeLab.text = model.name;
        cell.numberTextField.text =[NSString stringWithFormat:@"%@",model.num];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.addButtonBlock =  ^(NSString *str){
            NSLog(@"点击的是规格加号,数量为%@",str);
            // 重新为数量赋值
            model.num = str;
            
            // 更换数据源
            [self.modelArr replaceObjectAtIndex:indexPath.row withObject:model];
            // 计算价格
            [self countSizeTableViewAllShopGoodNums:self.modelArr];
            [self.shopCarGoodsDic setObject:model.num forKey:model.attrid];
     
//            NSDictionary *dic = @{@"good_attid":model.attrid,@"num":model.num};
          
          
//            if (self.shopCarGoodsArr.count == 0) {
//             [self.shopCarGoodsArr  addObject:dic];
//            }else{
//                // 获取所有key
//                for (NSDictionary *dic1 in self.shopCarGoodsArr) {
//                    if ([dic1.allKeys containsObject:model.attrid]) {
//                        [self.shopCarGoodsArr removeObject:dic1];
//                        [self.shopCarGoodsArr  addObject:dic];
//                    }else{
//                        [self.shopCarGoodsArr  addObject:dic];
//                    }
//                    
//                }
//             }
//          
            
            
            // 刷新该行数据源
            [self.sizeTableView reloadData];
            
        
           
        };
        
        cell.reduceButtonBlock =  ^(NSString *str){
            NSLog(@"点击的是规格减号,数量为%@",str);
            
            // 重新为数量赋值
            model.num = str;
            // 更换数据源
            [self.modelArr replaceObjectAtIndex:indexPath.row withObject:model];
            // 计算价格
            [self countSizeTableViewAllShopGoodNums:self.modelArr];
              [self.shopCarGoodsDic setObject:model.num forKey:model.attrid];
//            NSDictionary *dic = @{@"good_attid":model.attrid,@"num":model.num};
//            if (self.shopCarGoodsArr.count == 0) {
//                [self.shopCarGoodsArr  addObject:dic];
//            }else{
//                // 获取所有key
//                for (NSDictionary *dic1 in self.shopCarGoodsArr) {
//                    if ([dic1.allKeys containsObject:model.attrid]) {
//                        [self.shopCarGoodsArr removeObject:dic1];
//                         [self.shopCarGoodsArr  addObject:dic];
//                    }else{
//                    [self.shopCarGoodsArr  addObject:dic];
//                    }
//                }
//            }
//
            
            
     
            // 刷新该行数据源
            [self.sizeTableView reloadData];
            
            

        };

        
        
        
        
        return cell;
    }else{
        GFTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseCell forIndexPath:indexPath];
        
    
        // 为btn赋值
        [cell setTitleBtnValueWith:self.titleBtnArray[indexPath.row]];
        cell.btnBlock = ^(NSInteger index)
        {
            
            if ([self.delegate respondsToSelector:@selector(clickBtnLineNumber:andIndex:)]) {
                [self.delegate clickBtnLineNumber:indexPath.row andIndex:index];
            }
        };
        return cell;
    }
    
    return 0;
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44*kHeightScale;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:self.titleTableView]) {
    
    }
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
#pragma mark - 图片赋值
- (void)setGFChooseViewWithURL:(NSString *)url andJiaGeQuJian:(NSString *)jigaequjian
{
    NSURL *url1 = [NSURL URLWithString:url];
    self.priceLab.text = jigaequjian;
    
   [self.img  sd_setImageWithURL:url1];
 
   }
#pragma mark- 给数组赋值
- (void)setTitleBtnArrayWithModelArr:(NSMutableArray *)modelArr andStr:(NSString *)str
{
    
    self.titleBtnArray = modelArr;
    [self.titleTableView removeFromSuperview];
    self.titleTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 256*kHeightScale , KScreenW, 170*kHeightScale) style:UITableViewStylePlain];
    self.titleTableView.backgroundColor = [UIColor redColor];
    self.titleTableView.delegate = self;
    self.titleTableView.dataSource = self;
    self.titleTableView.showsVerticalScrollIndicator = NO;
    self.titleTableView.showsHorizontalScrollIndicator = NO;
    self.titleTableView.scrollEnabled = NO;
    // 注册cell
    [self.titleTableView registerClass:[GFTitleTableViewCell class] forCellReuseIdentifier:chooseCell];
    
    [self addSubview:self.titleTableView];

    self.titleTableView.frame = CGRectMake(0, 256*kHeightScale , KScreenW, 44*kHeightScale *modelArr.count);
    self.sizeTableView.frame =CGRectMake(0, 380*kHeightScale+44*kHeightScale*2 -(4-modelArr.count)*44 *kHeightScale, kScreenW, 100*kHeightScale);
    
    [self.titleTableView reloadData];
    
 
}

#pragma mark - 为sizeTableView赋值
- (void)setGFChooseTableViewValueWithArr:(NSMutableArray *)arr andCengji:(NSString *)cengji
{
        self.modelArr =arr;
    [self.sizeTableView reloadData];
}
#pragma mark - 计算单个sizeTableView列表的件数
- (NSInteger)countSizeTableViewAllShopGoodNums:(NSMutableArray *)arr
{
    self.totalNumber  = 0;
    self.totalMoney = 0;
    
    // 计算单项
    for (HomeShopListSizeModel *model in arr) {
        // 单项总数量
        self.totalNumber += [model.num integerValue];
        // 单价
        NSInteger price = [model.price integerValue];
        // 单项总钱数
         self.totalMoney += [model.num integerValue] *price;
        NSLog(@"%ld",self.totalMoney);
        }
    

    // 为件数赋值
    [self setToatalNumberColor:self.goodsNumberLab andStr:[NSString stringWithFormat:@"共%ld件",(long)self.totalNumber]];
    // 为总价格赋值
     [self setToatalNumberColor:self.totallMoneyLab andStr:[NSString stringWithFormat:@"¥%ld",self.totalMoney]];
    
    return self.totalNumber;
}
@end
