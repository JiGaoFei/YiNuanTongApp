//
//  GFChooseOneView.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GFChooseOneView.h"
#import "UIImageView+WebCache.h"
#import "GFChooseOneViewCell.h"
#import "HomeShopListSizeModel.h"
@interface GFChooseOneView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
/**存放要添加到购物车的dic*/
@property (nonatomic,strong) NSMutableDictionary *shopCarGoodsDic;
/**数据源*/
@property (nonatomic,strong) NSMutableArray *modelArray;
/**总件数*/
@property (nonatomic,assign) double totalNumber;
/**总钱数*/
@property (nonatomic,assign) double totalMoney;

/**限制数量*/
@property (nonatomic,copy)    NSString *activitynum;
/**购买次数*/
@property (nonatomic,assign) NSInteger order_count;

@end
static NSString *identifier = @"GFChooseOneViewCell";
@implementation GFChooseOneView
- (NSMutableDictionary *)shopCarGoodsDic
{
    if (!_shopCarGoodsDic) {
        self.shopCarGoodsDic = [[NSMutableDictionary alloc]init];
    }
    return _shopCarGoodsDic;
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
    
    // 创建titleTableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 256*kHeightScale , KScreenW, 320*kHeightScale) style:UITableViewStylePlain];
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
    totallPriceLab.text = @"99";
    
    self.totallMoneyLab  = totallPriceLab;
    [bagView addSubview:totallPriceLab];
    
}
#pragma mark - tableView代理方法
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
    GFChooseOneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    HomeShopListSizeModel *model = self.modelArray[indexPath.row];
    [cell setValueWithModel:model];
    
 
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    __weak typeof(cell)CellSelf = cell;
    cell.addBtnBloock =  ^(NSString *str){
        NSLog(@"点击的是规格加号,数量为%@",str);
        
          //对数量没有限制
            if ([self.activitynum isEqualToString:@"-1"]) {
                // 重新为数量赋值
                model.num = str;
                
                // 更换数据源
                [self.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
                
                //添加数据源
                [self.shopCarGoodsDic setObject:model.num forKey:model.good_attid];
                
                
                
                // 计算价格
                [self countSizeTableViewAllShopGoodNums:self.modelArray];
                // 刷新该行数据源
                [self.tableView reloadData];
                

            }
        
        //对数量没有限制
        if ([self.activitynum integerValue]>0) {
            if (self.order_count >0) {
                [GFProgressHUD showInfoMsg:@"此商品只能购买一次"];
            }else{
                if ([self countSizeTableViewAllShopGoodNums:self.modelArray] >[self.activitynum integerValue]) {
                    
                    
                
                  
                }else{
                    // 重新为数量赋值
                    model.num = str;
                    
                    // 更换数据源
                    [self.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
                    
                    //添加数据源
                    [self.shopCarGoodsDic setObject:model.num forKey:model.good_attid];
                    
                    if ([self countSizeTableViewAllShopGoodNums:self.modelArray] == [self.activitynum integerValue]) {
                        NSDictionary *dic = @{@"addStop":@"1"};
                        //创建一个消息对象
                        NSNotification * notice = [NSNotification notificationWithName:@"addStop" object:nil userInfo:dic];
                        //  发送消息
                        [[NSNotificationCenter defaultCenter]postNotification:notice];
                        [GFProgressHUD showInfoMsg:[NSString stringWithFormat:@"此商品最多只能购买%@件",self.activitynum]];
                    }
                    // 计算价格
                    [self countSizeTableViewAllShopGoodNums:self.modelArray];
                    // 刷新该行数据源
                    [self.tableView reloadData];
            }
        }
        }
        
    };
    
    cell.cutBtnBloock =  ^(NSString *str){
        NSDictionary *dic = @{@"addStop":@"0"};
        //创建一个消息对象
        NSNotification * notice = [NSNotification notificationWithName:@"addStop" object:nil userInfo:dic];
        //  发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        NSLog(@"点击的是规格减号,数量为%@",str);
        
        // 重新为数量赋值
        model.num = str;
        // 更换数据源
        [self.modelArray replaceObjectAtIndex:indexPath.row withObject:model];

        if ([str isEqualToString:@"0"]) {
            // 数量为0时移除数据源
            [self.shopCarGoodsDic removeObjectForKey:model.good_attid];
        }else{
            //添加数据源
            [self.shopCarGoodsDic setObject:model.num forKey:model.good_attid];
        }
        // 计算价格
        [self countSizeTableViewAllShopGoodNums:self.modelArray];
        
        // 刷新该行数据源
        [self.tableView reloadData];
        
        
        
    };
    cell.confirmBtnBlock= ^(NSString *str){
        
        //对数量没有限制
        if ([self.activitynum isEqualToString:@"-1"]) {
            // 重新为数量赋值
            model.num = str;
            // 更换数据源
            [self.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
            
            if ([str isEqualToString:@"0"]) {
                // 数量为0时移除数据源
                [self.shopCarGoodsDic removeObjectForKey:model.good_attid];
            }else{
                //添加数据源
                [self.shopCarGoodsDic setObject:model.num forKey:model.good_attid];
            }
            // 计算价格
            [self countSizeTableViewAllShopGoodNums:self.modelArray];
            
            // 刷新该行数据源
            [self.tableView reloadData];
            

        }
        
        //对数量有限制
        if ([self.activitynum integerValue]>0) {
            if (self.order_count >0) {
            [GFProgressHUD showInfoMsg:@"此商品只能购买一次"];
            }else{
                
            if ([self countSizeTableViewAllShopGoodNums:self.modelArray] >[self.activitynum integerValue]) {
                [GFProgressHUD showInfoMsg:[NSString stringWithFormat:@"此商品最多只能购买%@件",self.activitynum]];
                // 重新为数量赋值
                model.num = @"0";
                // 更换数据源
                [self.modelArray removeObject:model];
                [self.modelArray insertObject:model atIndex:indexPath.row];
          
                
                // 刷新该行数据源
                [self.tableView reloadData];
            

                                        
                }else{
                    
                    if ([str integerValue] >[self.activitynum integerValue]) {
                        [GFProgressHUD showInfoMsg:[NSString stringWithFormat:@"此商品最多只能购买%@件",self.activitynum]];
                        // 重新为数量赋值
                        model.num = @"0";
                        // 更换数据源
                        [self.modelArray removeObject:model];
                        [self.modelArray insertObject:model atIndex:indexPath.row];
                        
                        
                        // 刷新该行数据源
                        [self.tableView reloadData];
                    }else{
                        
                        
                        
                        // 重新为数量赋值
                        model.num = str;
                        // 更换数据源
                        [self.modelArray replaceObjectAtIndex:indexPath.row withObject:model];
                        
                        if ([str isEqualToString:@"0"]) {
                            // 数量为0时移除数据源
                            [self.shopCarGoodsDic removeObjectForKey:model.good_attid];
                        }else{
                            //添加数据源
                            [self.shopCarGoodsDic setObject:model.num forKey:model.good_attid];
                        }
                        // 计算价格
                        [self countSizeTableViewAllShopGoodNums:self.modelArray];
                        
                        // 刷新该行数据源
                        [self.tableView reloadData];

                        
                    }
                    

                    
                }
                

                
                
            }

        }
        
      
    };

    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 63 *kHeightScale;
}

#pragma mark - 确定按钮点击事件
- (void)GFChooseConfirmBtnAction:(UIButton *)sender
{
    NSLog(@"确定按钮的点击事件");
   
    NSDictionary *dic = @{@"addStop":@"0"};
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"addStop" object:nil userInfo:dic];
    //  发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
 
    if ([self.delegate respondsToSelector:@selector(GFChooseOneViewClickConfirmBtnActionWithDic:)]) {
        [self.delegate GFChooseOneViewClickConfirmBtnActionWithDic:self.shopCarGoodsDic];
    }
}
#pragma mark - 取消按钮点击事件
- (void)cancelBtnAction:(UIButton *)sender
{
    NSLog(@"取消按钮点击事件");
    NSDictionary *dic = @{@"addStop":@"0"};
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"addStop" object:nil userInfo:dic];
    //  发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    if ([self.delegate respondsToSelector:@selector(GFChooseOneViewCancelBtn)]) {
        [self.delegate GFChooseOneViewCancelBtn];
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

// 传递限制数量
- (void)setActivityNumWithStr:(NSString *)activitynum andOrderCout:(NSInteger)orderCount
{
    self.activitynum = activitynum;
    self.order_count = orderCount;
}
#pragma mark - 计算单个sizeTableView列表的件数
- (NSInteger)countSizeTableViewAllShopGoodNums:(NSMutableArray *)arr
{
    self.totalNumber  = 0;
    self.totalMoney = 0;
    
    // 计算单项
    for (HomeShopListSizeModel *model in arr) {
        // 单项总数量
        self.totalNumber += [model.num doubleValue];
        // 单价
        double price = [model.price doubleValue];
        // 单项总钱数
        self.totalMoney += [model.num integerValue] *price;
        NSLog(@"%f",self.totalMoney);
    }
    

    // 为件数赋值
    [self setToatalNumberColor:self.goodsNumberLab andStr:[NSString stringWithFormat:@"共%ld件",(long)self.totalNumber]];
    // 为总价格赋值
    [self setToatalNumberColor:self.totallMoneyLab andStr:[NSString stringWithFormat:@"¥%.2f",self.totalMoney]];
    
    return self.totalNumber;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
