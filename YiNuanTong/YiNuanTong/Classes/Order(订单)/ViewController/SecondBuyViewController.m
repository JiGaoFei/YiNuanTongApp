//
//  SecondBuyViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/17.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "SecondBuyViewController.h"
#import "ShopCarCell.h"
#import <Masonry/Masonry.h>
#import "SingLeton.h"
#import "ShopCartModel.h"
#import "WriteOrderViewController.h"
#import "YNTNetworkManager.h"
#import "WriteModel.h"
#import <MJRefresh/MJRefresh.h>
@interface SecondBuyViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**全选按钮*/
@property (nonatomic,strong) UIButton  * selectAllBtn;
/**展示数据源数组*/
@property (nonatomic,strong) NSMutableArray  * dataArr;
/**已选商品集合*/
@property (nonatomic,strong) NSMutableArray  * selectGoodsArr;
/**已选商品的总价*/
@property (nonatomic,strong) UILabel  * priceLabel;
@property (nonatomic,assign) BOOL isSelected;
/**writeModel*/
@property (nonatomic,strong) WriteModel  * model;
/**网络数量*/
@property (nonatomic,copy) NSString *netNumber;
/**本地数量*/
@property (nonatomic,copy) NSString *localNuber;
@end
static NSString *shopCar = @"shopcarCell";
@implementation SecondBuyViewController
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        self.dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}
- (NSMutableArray *)selectGoodsArr
{
    if (!_selectGoodsArr) {
        self.selectGoodsArr = [[NSMutableArray alloc]init];
    }
    return _selectGoodsArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.tabBarController.tabBar.hidden = YES;
    // 每次进入购物车的时候把选择的置空
    [self.selectGoodsArr removeAllObjects];
    [self.dataArr removeAllObjects];
    
    self.priceLabel.text = @"0.00";
    [self creatData];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"再次购买";
    self.view.backgroundColor = [UIColor grayColor];
    [self setUpRightItem];
    // 创建子视图
    [self setUpChildrenViews];
    
}
/**
 *创建右item
 */
- (void)setUpRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame= CGRectMake(0, 0, 40, 40);
    [rightBtn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"清空" forState:UIControlStateNormal];

    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark - 购物车清空的点击事件

- (void)rightBarButtonItemAction:(UIButton *)sender
{
    // 这个是清空列表数据   ******VVIP
    
    UserInfo *userInfo = [UserInfo currentAccount];
    NSString *url = [NSString stringWithFormat:@"%@api/shoppingcarclass.php",baseUrl];
    NSDictionary *param  = @{@"user_id":userInfo.user_id,@"act":@"clear"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"清空列表数据请求成功%@",responseObject);
        self.priceLabel.text = @"0.00";
        [self creatData];
    } enError:^(NSError *error) {
        NSLog(@"清空列表数据请求失败%@",error);
    }];
    
    
    NSLog(@"我是再次购买清空事件");
    
}

/**
 *计算已选中的商品金额
 */

-(void)countPrice
{
    double totlePrice = 0.0;
    
    for (ShopCartModel *model in self.selectGoodsArr) {
        
        double price = [model.saleprice doubleValue];
        
        totlePrice += price*model.buynum;
    }
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",totlePrice];
}



/**
 *创建数据源
 */
-(void)creatData
{
    // 显示加载圈
    [GFProgressHUD showLoading:@"正在加载数据"];
    UserInfo *userInfo = [UserInfo currentAccount];
    // 先清空数据源
    [self.dataArr removeAllObjects];
    NSString *url = [NSString stringWithFormat:@"%@api/shoppingcarclass.php",baseUrl];
    NSDictionary *param = @{@"act":@"buyagain",@"user_id":userInfo.user_id,@"order_id":self.order_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        // 隐藏加载圈
        [GFProgressHUD hide];
        NSLog(@"再次购买列表请求数据成功%@",responseObject);
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *arr = returnDic[@"data"];
        self.model = [[WriteModel alloc]init];
        [self.model setValuesForKeysWithDictionary:responseObject[@"arraddress"]];
        for (NSDictionary *dic in arr) {
            ShopCartModel *model = [[ShopCartModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArr addObject:model];
        }
        
        
        if (self.tableView) {
            [self.tableView reloadData];
        }else{
            [self setUpChildrenViews];
        }
    } enError:^(NSError *error) {
        NSLog(@"再次购买列表请求数据失败%@",error);
        // 隐藏加载圏
        [GFProgressHUD hide];
        
    }];
    
    
    
    
   }

/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH) style:UITableViewStylePlain];
    
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    
    
    // 注册cell
    [self.view addSubview:self.tableView];
    // 创建表尾视图
    UIView *fooderView = [self setupBottomView];
    [self.view addSubview:fooderView];

}
/**
 *设置底部视图
 */
#pragma mark - 设置底部视图
-(UIView *)setupBottomView
{
    //底部视图的 背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - 50, KScreenW,50)];
    bgView.backgroundColor = RGBA(249, 249, 249, 1);
    [self.view addSubview:bgView];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenW ,1)];
    
    [bgView addSubview:line];
    
    //合计
    UILabel *label = [[UILabel alloc]init];
    label.text = @"合计: ";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentRight;
    [bgView addSubview:label];
    
    //价格
    self.priceLabel = [[UILabel alloc]init];
    _priceLabel.text = @"￥0.00";
    _priceLabel.font = [UIFont boldSystemFontOfSize:16];
    _priceLabel.textColor = [UIColor redColor];
    [bgView addSubview:_priceLabel];
    
    //结算按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = CGRBlue;
    [btn setTitle:@"下单" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goPayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btn];
    
    //结算按钮
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.right.equalTo(bgView);
        make.bottom.equalTo(bgView);
        make.width.equalTo(@100);
        
    }];
    
    //价格显示
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_left).offset(-10);
        make.top.equalTo(bgView).offset(10);
        make.bottom.equalTo(bgView).offset(-10);
        make.left.equalTo(label.mas_right);
    }];
    
    //合计
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(10);
        make.bottom.equalTo(bgView).offset(-10);
        make.right.equalTo(_priceLabel.mas_left);
        make.width.equalTo(@60);
    }];
    return bgView;
}
#pragma mark- 计算已选中商品的金额

#pragma mark - 结算点击事件
- (void)goPayBtnClick:(UIButton *)sender
{
    NSLog(@"我要去结算了");
    UserInfo *userInfo = [UserInfo currentAccount];
    // 拼接所有商品id
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (ShopCartModel *model in _selectGoodsArr) {
        [arr addObject:model.good_id];
    }
    NSString *good_id = [arr componentsJoinedByString:@","];
    NSLog(@"这是商品拼接后的id:%@",good_id);

    // 下单
    NSString *url = [NSString stringWithFormat:@"%@api/orderclass.php",baseUrl];
    NSDictionary *params = @{@"act":@"add",@"user_id":userInfo.user_id,@"good_id":good_id};
    WriteOrderViewController *writeOrderVC = [[WriteOrderViewController alloc]init];
    writeOrderVC.model = self.model;
 

    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"下单接口请求成功%@",responseObject);
        writeOrderVC.order_id = responseObject[@"order_id"];
        writeOrderVC.totalMoney = responseObject[@"amount"];
        writeOrderVC.goodsnum = responseObject[@"goodsnum"];
        writeOrderVC.arrwuliuDic = responseObject[@"arrwuliu"];
        
        [self.navigationController pushViewController:writeOrderVC animated:YES];

    } enError:^(NSError *error) {
        NSLog(@"下单接口请求失败%@",error);
    }];
    
    
   }
#pragma mark -tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.dataArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ShopCarCell *cell = [tableView dequeueReusableCellWithIdentifier:shopCar];
    
    if (!cell) {
        cell = [[ShopCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopCar];
    }
    cell.isSelected = self.isSelected;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ShopCartModel *model = [self.dataArr objectAtIndex:indexPath.row];

    cell.deleteBtnBlock = ^(){
        UserInfo *userInfo = [UserInfo currentAccount];
        NSString *url = [NSString stringWithFormat:@"%@api/shoppingcarclass.php",baseUrl];
        NSDictionary *param = @{@"act":@"del",@"good_id":model.good_id,@"user_id":userInfo.user_id};
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
            NSLog(@"删除购物车数据请求成功%@",responseObject);
        } enError:^(NSError *error) {
            NSLog(@"删除购物车数据接口请求失败%@",error);
        }];
    };
    
    //是否被选中
    if ([self.selectGoodsArr containsObject:[self.dataArr objectAtIndex:indexPath.row]]) {
        cell.isSelected = YES;
    }
    
    //选择回调
    cell.carBlock = ^(BOOL isSelec){
        
        if (isSelec) {
            [self.selectGoodsArr addObject:[self.dataArr objectAtIndex:indexPath.row]];
        }
        else
        {
            [self.selectGoodsArr removeObject:[self.dataArr objectAtIndex:indexPath.row]];
        }
        
        
        [self countPrice];
    };
    __block ShopCarCell *weakCell = cell;
    cell.numberAddBlock=^(){
           NSInteger count = [weakCell.numberTextField.text integerValue];
    
        count++;
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        
        weakCell.numberTextField.text = numStr;
        model.buynum = count;
        
        
        
        
        UserInfo *userInfo = [UserInfo currentAccount];
        // 加入购物车接口
        NSString *url = [NSString stringWithFormat:@"%@api/shoppingcarclass.php",baseUrl];
        
        NSDictionary *param = @{@"act":@"add",@"user_id":userInfo.user_id,@"buynum":@"1",@"good_id":model.good_id};
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
            NSLog(@"购物车列表加1请求成功%@",responseObject);
        } enError:^(NSError *error) {
            NSLog(@"购物车列表加1请求失败%@",error);
        }];
        

        
        [self.dataArr replaceObjectAtIndex:indexPath.row withObject:model];
        if ([self.selectGoodsArr containsObject:model]) {
            [self.selectGoodsArr removeObject:model];
            [self.selectGoodsArr addObject:model];
            
            [self countPrice];
        }
    };
    
    cell.numberCuttBlock =^(){
        
        NSInteger count = [weakCell.numberTextField.text integerValue];
        count--;
        if(count <= 0){
            return ;
        }
        NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
        
        ShopCartModel *model = [self.dataArr objectAtIndex:indexPath.row];
        
        weakCell.numberTextField.text = numStr;
        
        model.buynum = count;
        
        
        UserInfo *userInfo = [UserInfo currentAccount];
        // 加入购物车接口
        NSString *url = [NSString stringWithFormat:@"%@api/shoppingcarclass.php",baseUrl];
    
        
        NSDictionary *param = @{@"act":@"add",@"user_id":userInfo.user_id,@"buynum":@"-1",@"good_id":model.good_id};
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
            NSLog(@"购物车列表减1请求成功%@",responseObject);
        } enError:^(NSError *error) {
            NSLog(@"购物车列表减1请求失败%@",error);
        }];
        

        
        
        [self.dataArr replaceObjectAtIndex:indexPath.row withObject:model];
        
        //判断已选择数组里有无该对象,有就删除  重新添加
        if ([self.selectGoodsArr containsObject:model]) {
            [self.selectGoodsArr removeObject:model];
            [self.selectGoodsArr addObject:model];
            [self countPrice];
        }
    };
    
    // 点击键盘完成处理事件
    weakCell.confirmBtnBlock = ^(){
        
        
        NSInteger currentNember = [self.localNuber integerValue];
        NSInteger  netNumber = model.buynum;
        NSInteger resultNumber = (currentNember - netNumber);
        NSLog(@"数量变化了:%ld",(long)resultNumber);
        NSLog(@"我是完成按钮的回调");
        
        [self requestNumberData:model.good_id andNumber:[NSString stringWithFormat:@"%ld",(long)resultNumber]];
    };
    // 数量输入后处理事件
    weakCell.numberTextFiledInputText = ^(NSString *str){
        
        self.localNuber = str;
    };
    [cell setDataWithModel:[self.dataArr objectAtIndex:indexPath.row]];
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 185 *kHeightScale;
}
#pragma mark 点击完成后请求数量接口
- (void)requestNumberData:(NSString *)good_id andNumber:(NSString *)number
{
    UserInfo *userInfo = [UserInfo currentAccount];
    // 加入购物车接口
    NSString *url = [NSString stringWithFormat:@"%@api/shoppingcarclass.php",baseUrl];

    NSDictionary *param = @{@"act":@"add",@"user_id":userInfo.user_id,@"buynum":number,@"good_id":good_id};
    
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        [self creatData];
        self.priceLabel.text = @"0";
        
    } enError:^(NSError *error) {
        NSLog(@"添加购物车请求失败%@",error);
    }];
    
    
}

@end
