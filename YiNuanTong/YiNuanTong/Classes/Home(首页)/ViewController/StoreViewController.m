//
//  StoreViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/13.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "StoreViewController.h"
#import "YNTUITools.h"
#import "CartTableViewCell.h"
#import "CartModel.h"
#import "HomeGoodsModel.h"
#import "ShopListChooseView.h"
#import "DropDownCell.h"
#import "GFDropDownMenu.h"
#import "ShopGoodsDeitalViewController.h"
#import "YNTShopingCarViewController.h"

#import "YNTNetworkManager.h"
#import "HomeGoodsModel.h"
#import "UIImageView+WebCache.h"
#import <MJRefresh/MJRefresh.h>
#import "HomeGoodsDetailSizeModel.h"
#import "BrandModel.h"
#import "MoreBrandModel.h"
#import "UIScrollView+EmptyDataSet.h"


@interface StoreViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,UISearchBarDelegate>
{
    UITableView *myTableView;
    //全选按钮
    UIButton *selectAll;
    //展示数据源数组
    NSMutableArray *dataArray;
    //是否全选
    BOOL isSelect;
    
    //已选的商品集合
    NSMutableArray *selectGoods;
    
    UILabel *priceLabel;
}
/**下拉view*/
@property (nonatomic,strong) UIView  * dropDownView;
/**collectionView*/
@property (nonatomic,strong) UICollectionView *collectionView;
/**创建布局对象*/
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong)  DropDownCell *downCell;

/**选中cell*/
@property (nonatomic,strong) DropDownCell *selectCell;

/**创建筛选视图*/
@property (nonatomic,strong) ShopListChooseView  * chooseView;
/**创建购物车视图*/
@property (nonatomic,strong) UIView *shopCarView;
/**创建collectionView*/
@property (nonatomic,strong) UICollectionView  * shopCarCollectionView;
/**当前选中的按钮(用于控制按钮的颜色)*/
@property (nonatomic,strong) UIButton *selectedButton;
/**创建布局对象*/
@property (nonatomic,strong) UICollectionViewFlowLayout  * shopCarFlowLayout;
/**选中商品集合*/
@property (nonatomic,strong) NSMutableArray  * selectedGoodsArray;
/**商品集合*/
@property (nonatomic,strong) NSMutableArray  * goodsArray;

/**购物车中数量*/
@property (nonatomic,strong) UITextField *numberTextField;

/**是否全选 */
@property (nonatomic,assign) BOOL  isAllSelected;
/**全选按钮*/
@property (nonatomic,strong)  UIButton *allSelectBtn;
/**是否选中*/
@property (nonatomic,assign) BOOL  cellIsSelected;
/**用于传值的选中model*/
@property (nonatomic,strong) HomeGoodsModel  * shopCarModel;
/**用于传值没有选中model*/
@property (nonatomic,strong) HomeGoodsModel  * noshopCarModel;
/**购买的数量*/
@property (nonatomic,assign) NSInteger  shopingGoodsNum;
/**价格排序的状态(yes代表低到高)*/
@property (nonatomic,assign) BOOL  isPriceLowToHigh;
/**页数*/
@property (nonatomic,assign) NSInteger  page;
/**是否是上拉*/
@property (nonatomic,assign) BOOL  isUp;
/**背景*/
@property (nonatomic,strong) UIView  * bagView;
/**判断是否筛选框出现,用于改变图标*/
@property (nonatomic,assign) BOOL isSelectViewApperar;
/**筛选视图*/
@property (nonatomic,strong) GFDropDownMenu *dropDownMenu;
/**规格数据*/
@property (nonatomic,strong) NSMutableArray  * brandArray;
/**购物车视图名称*/
@property (nonatomic,strong) UILabel *goodNameLab;
/**购物车视图价格*/
@property (nonatomic,strong)  UILabel *goodPriceLab;
/**购物车视图库存*/
@property (nonatomic,strong) UILabel *goodStockLab;
/**huo_id*/
@property (nonatomic,copy) NSString *huo_id;
/**商品id*/
@property (nonatomic,copy) NSString *good_id;
/**下拉筛选品牌数据*/
@property (nonatomic,strong) NSMutableArray *selectBrandArr;
/**记录选中的品牌数据*/
@property (nonatomic,copy) NSString *brandStr;
/**存放更多数组*/
@property (nonatomic,strong) NSMutableArray *moreBrandArray;
/**用于给筛选赋值*/
@property (nonatomic,strong) NSMutableArray *transmitArray;
/**用于记录是否为品牌赋值*/
@property (nonatomic,assign) BOOL isBrand;
/**底部视图*/
@property (nonatomic,strong) UIView *bottomView;
/**首次进入*/
@property (nonatomic,assign) BOOL isFirstEnter;
/**全局请求参数*/
@property (nonatomic,copy) NSDictionary *params;
/**全局url*/
@property (nonatomic,copy) NSString *allUrl;
/**标志请求的是那个数据*/
@property (nonatomic,assign) NSInteger serialNumber;
/**要搜索的内容*/
@property (nonatomic,copy) NSString  *searchStr;
/**品牌id*/
@property (nonatomic,copy) NSString *brand_id;
/**价格区间*/
@property (nonatomic,copy) NSString *price_qujian;


@end
static NSString *dropDownCell = @"dropDownCell";
static NSString *listCell = @"listCell";

@implementation StoreViewController
/** 懒加载 */
 - (NSMutableArray *)selectBrandArr
{
    if (!_selectBrandArr) {
        self.selectBrandArr = [[NSMutableArray alloc]init];
    }
    return _selectBrandArr;
}
/** 存放更多品牌数据 */
- (NSMutableArray *)moreBrandArray
{
    if (!_moreBrandArray) {
        self.moreBrandArray = [[NSMutableArray alloc]init];
    }
    return _moreBrandArray;
}
/** 用于筛选赋值 */
- (NSMutableArray *)transmitArray
{
    if (!_transmitArray) {
        self.transmitArray = [[NSMutableArray alloc]init];
    }
    return _transmitArray;
}
- (NSDictionary *)params
{
    if (!_params) {
        self.params = [[NSDictionary alloc]init];
    }
    return _params;
}
- (NSMutableArray *)brandArray
{
    if (!_brandArray) {
        self.brandArray = [[NSMutableArray alloc]init];
    }
    return _brandArray;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //每次进入购物车的时候把选择的置空
    [selectGoods removeAllObjects];
    [dataArray removeAllObjects];
    self.page = 1;
    self.serialNumber = 1;
        self.isFirstEnter = YES;
    [self creatData];
  
    isSelect = NO;

    selectAll.selected = NO;
    self.isBrand = YES;
    self.tabBarController.tabBar.hidden = YES;
    

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 加载右侧item
    [self setUpRightItem];
    [self setUpSearchViews];
    dataArray = [[NSMutableArray alloc]init];
    selectGoods = [[NSMutableArray alloc]init];
    
    self.isPriceLowToHigh = YES;
    self.page = 1;
    self.isSelectViewApperar = NO;
    self.brandStr = @"";

   //  [self creatData];
    self.title = @"收藏商品";
}

// 加载数据
-(void)creatData
{

    UserInfo *userInfo = [UserInfo currentAccount];
    self.params = @{@"act":@"list",@"user_id":userInfo.user_id,@"page":@"0",@"tpagesize":@"10"};
     //清空数据源
    [dataArray removeAllObjects];
    // 请求列表数据
    NSString *goodListUrl = [NSString stringWithFormat:@"%@api/goods_favorite.php",baseUrl];
    [YNTNetworkManager requestPOSTwithURLStr:goodListUrl paramDic:self.params finish:^(id responseObject) {
        NSLog(@"%@",responseObject);
        // 隐藏加载圏
        [GFProgressHUD hide];
        // 停止刷新
        [self endRefresh];
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        
        // 获取下拉品牌数据
        NSArray *brandsArray = returnDic[@"brands"];
        for (NSDictionary *dic in  brandsArray) {
            BrandModel *brandModel = [[BrandModel alloc]init];
            [brandModel setValuesForKeysWithDictionary:dic];
            [self.selectBrandArr addObject:brandModel];
        }
        self.isBrand = YES;
        self.transmitArray = _selectBrandArr;
        
        NSArray *dataArr= returnDic[@"goods"];
        for (NSDictionary *dic in dataArr) {
            
            HomeGoodsModel *model = [[HomeGoodsModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"收藏商品名:%@",model.name);
            [dataArray addObject:model];
            
        }
        // 获取更多品牌数据
        NSArray *moreBrandArray = returnDic[@"catarr"];
        for (NSDictionary *dic1 in moreBrandArray) {
            MoreBrandModel *model = [[MoreBrandModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic1];
            [self.moreBrandArray addObject:model];
            
        }

        if (myTableView) {
            [myTableView reloadData];
            [myTableView setContentOffset:CGPointMake(0,0) animated:NO];

        }
        else
        {
            
            [self setupMainView];
         
            [self setUpAllViews];
            
            
        }
    } enError:^(NSError *error) {
        NSLog(@"请求失败");
        // 停止刷新
        [self endRefresh];
    }];
    
   
    
}
#pragma mark - 导航栏右侧item
/**
 *创建右item
 */
- (void)setUpRightItem
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame= CGRectMake(0, 0, 40, 40);
    [rightBtn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *rightImage = [UIImage imageNamed:@"shopCar_order"];
    [rightBtn setImage:rightImage forState:UIControlStateNormal];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)rightBarButtonItemAction:(UIButton *)sender
{YNTShopingCarViewController *shopVC = [[YNTShopingCarViewController alloc]init];
    [self.navigationController pushViewController:shopVC animated:YES];
    NSLog(@"点击的是右边items");
}

#pragma mark - 创建search_view
- (void)setUpSearchViews
{
    // 创建搜索框
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(50 *kWidthScale, 5 *kHeightScale,KScreenW - 100 *kWidthScale, 35*kHeightScale)];
    
    // 去掉搜索框的边界线
    [searchBar setBackgroundImage:[[UIImage alloc]init] ];
    
    searchBar.placeholder = @"商品搜索";
    searchBar.delegate = self;
    
    UIView * centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenW , 45 *kHeightScale)];
    centerView.backgroundColor = CGRBlue;
    
    [centerView addSubview:searchBar];
    
    [self.view addSubview:centerView];
}
#pragma mark  - 创建底部全选视图
- (void)setUpAllViews
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - 110 *kPlus , KScreenW, 110 *kPlus)];
    self.bottomView = backView;
   
    backView.backgroundColor =RGBA(249, 249, 249, 1);
    //全选按钮
    selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
    selectAll.frame = CGRectMake(29 *kPlus, 15, 20, 20);
    selectAll.titleLabel.font = [UIFont systemFontOfSize:15];
    [selectAll setImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
    [selectAll setImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateSelected];
    [selectAll setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectAll addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // 创建全选文字
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(87 *kPlus, 20, 40, 16) text:@"全选" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:16];
    [backView addSubview:titleLab];
    
    [backView addSubview:selectAll];
    [self.view addSubview:backView];
    
    // 创建加入购物车按钮
    UIButton*carBuyBtn = [YNTUITools createButton:CGRectMake(KScreenW/ 2, 0, KScreenW/2, 110*kPlus) bgColor:CGRBlue title:@"移出收藏夹" titleColor:[UIColor whiteColor] action:@selector(deleteFromStoreAction:) vc:self];
    
    [backView addSubview:carBuyBtn];
}


// 全选按钮的点击事件
-(void)selectAllBtnClick:(UIButton*)button
{
    //点击全选时,把之前已选择的全部删除
    [selectGoods removeAllObjects];
    
    button.selected = !button.selected;
    isSelect = button.selected;
    if (isSelect) {
        
        for (CartModel *model in dataArray) {
            [selectGoods addObject:model];
        }
    }
    else
    {
        [selectGoods removeAllObjects];
    }
    
    [myTableView reloadData];
    
}
// 加入购物车按钮的点击事件
- (void)deleteFromStoreAction:(UIButton *)sender
{
    
    UserInfo *userInfo = [UserInfo currentAccount];
   
    // 拼接所有商品id
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (HomeGoodsModel*model in selectGoods) {
       [arr addObject:model.good_id];
  }
    // 当全选的时候全部移除
    if (arr.count == dataArray.count) {
        [self.bottomView removeFromSuperview];
    }
    NSString *good_id = [arr componentsJoinedByString:@","];
    NSLog(@"这是商品拼接后的id:%@",good_id);

    NSLog(@"我是移除收藏夹的点击");
    NSString *url = [NSString stringWithFormat:@"%@api/goods_favorite.php",baseUrl];
    NSDictionary *param = @{@"user_id":userInfo.user_id,@"good_id":good_id,@"act":@"del"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"移除收藏夹数据成功%@",responseObject);
        NSString *msg = responseObject[@"msg"];
        if ([msg isEqualToString:@"success"]) {
            [GFProgressHUD showSuccess:responseObject[@"info"]];
        }else{
            [GFProgressHUD showFailure:responseObject[@"info"]];
        }

        
        // 移除成功后进行数据的刷新
           [self creatData];
        if (dataArray.count == 0) {
     
     
        }else{
  
          [self setUpAllViews];
        }
     
    } enError:^(NSError *error) {
        NSLog(@"移除收藏夹数据失败%@",error);
    }];
}


#pragma mark - 设置主视图
-(void)setupMainView
{
    myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 110, KScreenW, kScreenH - 155) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.emptyDataSetSource = self;
    myTableView.emptyDataSetDelegate = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新的时候 ,将主动page改为 0
        
        self.isUp = NO;// 标识下拉
        self.page = 1;
        
        [self creatData];
    }];
    
    myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 上拉刷新的时候每次页数加1
        self.page+=1;
        [self creatData];
    }];
    [self.view addSubview:myTableView];
    
    
}
#pragma makr - 实时监听文字的改变
- (void)textChage:(UITextField *)sender
{
    NSLog(@"%@",self.numberTextField.text);
    self.shopingGoodsNum = [self.numberTextField.text integerValue];
}
#pragma mark - 键盘上点击完成事件
- (void)confrimBtnAction:(UIButton *)sender
{
    NSLog(@"点击的是收藏键盘上的完成");
    [self.view endEditing:YES];
    
}
// 购物车加事件
- (void)addBtnClick:(UIButton *)sender
{
    NSLog(@"我是购物车加");
    
    NSInteger countNum = [self.numberTextField.text integerValue];
    countNum++;
    self.shopingGoodsNum = countNum;
    self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)countNum];
    NSLog(@"购买的数量:%ld",(long)_shopingGoodsNum);
}
// 购物车减事件
- (void)cutBtnClick:(UIButton *)sender
{
    NSLog(@"我是购物车减");
    NSInteger countNum = [self.numberTextField.text integerValue];
    if (countNum <=0) {
        return;
    }
    countNum--;
    self.shopingGoodsNum = countNum;
    self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)countNum];
    NSLog(@"购买的数量:%ld",(long)_shopingGoodsNum);
    
}


// 购物车视图底部按钮
- (void)setUpBottomViews
{
     CGFloat h = 55 *kHeightScale;
    // 创建收藏按钮
    UIButton *stroeBtn = [YNTUITools createCustomButton:CGRectMake(0, kScreenH - 64- h, KScreenW/2-50 *kWidthScale, h) bgColor:nil title:nil titleColor:nil image:@"收藏成功" action:@selector(storeBtnAction:) vc:self];
    
    [self.shopCarView addSubview:stroeBtn];
    // 创建加入购物车按钮
    UIButton*carBtn = [YNTUITools createButton:CGRectMake(KScreenW /2-50*kWidthScale, kScreenH - h - 64, KScreenW/2-50 *kWidthScale, h)  bgColor:RGBA(19, 123, 204, 1) title:@"加入购物车" titleColor:[UIColor whiteColor] action:@selector(carBtnAction:) vc:self];
    
    [self.shopCarView addSubview:carBtn];
    
}
#pragma mark- 底部按钮的点击事件
- (void)storeBtnAction:(UIButton *)sender
{
    UserInfo *userInfo = [UserInfo currentAccount];
    [sender setImage:[UIImage imageNamed:@"收藏图标"] forState:UIControlStateNormal];
    NSString *url = [NSString stringWithFormat:@"%@api/goods_favorite.php",baseUrl];
    NSDictionary *param = @{@"user_id":userInfo.user_id,@"good_id":self.noshopCarModel.good_id,@"act":@"del"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"取消收藏请求数据成功%@",responseObject);
        NSString *msg = responseObject[@"msg"];
        if ([msg isEqualToString:@"success"]) {
            [GFProgressHUD showSuccess:responseObject[@"info"]];
        }else{
            [GFProgressHUD showFailure:responseObject[@"info"]];
        }

        [self creatData];

    } enError:^(NSError *error) {
        NSLog(@"取消收藏请求数据失败%@",error);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect  rect = self.bagView.frame;
        rect.origin.x = KScreenW;
        self.bagView.frame = rect;
    }];

}
- (void)carBtnAction:(UIButton *)sender
{
    UserInfo *userInfo=[UserInfo currentAccount];
    NSLog(@"加入购物车按钮的点击");
    // 加入购物车接口
    NSString *url = [NSString stringWithFormat:@"%@api/shoppingcarclass.php",baseUrl];
    NSString *buynum= [NSString stringWithFormat:@"%ld",(long)self.shopingGoodsNum];
    NSDictionary *param = @{@"act":@"add",@"user_id":userInfo.user_id,@"buynum":buynum,@"good_id":self.good_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"添加购物车请求成功%@",responseObject);
        NSString *msg = responseObject[@"msg"];
        if ([msg isEqualToString:@"success"]) {
            [GFProgressHUD showSuccess:responseObject[@"info"]];
        }else{
            [GFProgressHUD showFailure:responseObject[@"info"]];
        }

    } enError:^(NSError *error) {
        NSLog(@"添加购物车请求失败%@",error);
    }];

    [UIView animateWithDuration:0.5 animations:^{
        CGRect  rect = self.bagView.frame;
        rect.origin.x = KScreenW;
        self.bagView.frame = rect;
    }];
    
    
}


#pragma mark - tableView 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[CartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    HomeGoodsModel *model = dataArray[indexPath.row];
    self.shopCarModel = model;
    cell.listCarBtn.hidden = YES;
    cell.isSelected = isSelect;
    cell.addCarBlock = ^(){
        NSLog(@"我是加入购物车按钮的回调");
        self.noshopCarModel =dataArray[indexPath.row];
         };
    
    //是否被选中
    if ([selectGoods containsObject:[dataArray objectAtIndex:indexPath.row]]) {
        cell.isSelected = YES;
        
    }
    
    //选择回调
    cell.cartBlock = ^(BOOL isSelec){
        
        if (isSelec) {
            [selectGoods addObject:[dataArray objectAtIndex:indexPath.row]];
            HomeGoodsModel *model = dataArray[indexPath.row];
            NSLog(@"添加的是:%@",model.name);
        }
        else
        {
            [selectGoods removeObject:[dataArray objectAtIndex:indexPath.row]];
              HomeGoodsModel *model = dataArray[indexPath.row];
            
              NSLog(@"移除的是:%@",model.name);
        }
        
        if (selectGoods.count == dataArray.count) {
            selectAll.selected = YES;
        }
        else
        {
            selectAll.selected = NO;
        }
        
    };
    
    
    
    [cell reloadDataWith:[dataArray objectAtIndex:indexPath.row]];
    return cell;
}


-(void)reloadTable
{
    [myTableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130 *kHeightScale;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopGoodsDeitalViewController *shoopGoodDetailVC = [[ShopGoodsDeitalViewController alloc]init];
    HomeGoodsModel *model = dataArray[indexPath.row];
    shoopGoodDetailVC.good_id = model.good_id;
    [self.navigationController pushViewController:shoopGoodDetailVC animated:YES];
}


#pragma mark - 停止刷新
/**
 *  停止刷新
 */
-(void)endRefresh{
    [myTableView.mj_header endRefreshing];
    [myTableView.mj_footer endRefreshing];
}
#pragma mark - 点击移除事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.5 animations:^{
        // 购物车视图消失
        //  [self.shopCarView removeFromSuperview];
        CGRect  rect = self.bagView.frame;
        rect.origin.x = KScreenW;
        self.bagView.frame = rect;
     
    } completion:^(BOOL finished) {
        // 移除成功后进行数据的刷新
        [self creatData];
    }];
    
}

#pragma mark - searchBar代理方法

// 文字改变的时候进行搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.serialNumber = 2;
    self.searchStr = searchText;
        UserInfo *userInfo = [UserInfo currentAccount];
          NSDictionary *params = @{@"user_id":userInfo.user_id,@"searchstr":self.searchStr};
    [self requestListDataWtihParams:params andTitle:@"搜索"];
    [searchBar resignFirstResponder];
}

#pragma mark - 请求列表数据
/** 
 @ params params请求参数
 @ params title 提示文字
 */
- (void)requestListDataWtihParams:(NSDictionary *)params andTitle:(NSString *)title
{
     // 清空数据源
    [dataArray removeAllObjects];

    NSString *url = [NSString stringWithFormat:@"%@api/goods_favorite.php",baseUrl];
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params
                                      finish:^(id responseObject) {
                                          NSLog(@"%@请求数据成功:%@",title,responseObject);
                                          NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
                                          
                                          // 获取下拉品牌数据
                                          NSArray *brandsArray = returnDic[@"brands"];
                                          for (NSDictionary *dic in  brandsArray) {
                                              BrandModel *brandModel = [[BrandModel alloc]init];
                                              [brandModel setValuesForKeysWithDictionary:dic];
                                              [self.selectBrandArr addObject:brandModel];
                                          }
                                          self.isBrand = YES;
                                          self.transmitArray = _selectBrandArr;
                                          
                                          NSArray *dataArr= returnDic[@"goods"];
                                          for (NSDictionary *dic in dataArr) {
                                              
                                              HomeGoodsModel *model = [[HomeGoodsModel alloc]init];
                                              [model setValuesForKeysWithDictionary:dic];
                                              NSLog(@"收藏商品名:%@",model.name);
                                              [dataArray addObject:model];
                                              
                                          }
                                          // 获取更多品牌数据
                                          NSArray *moreBrandArray = returnDic[@"catarr"];
                                          for (NSDictionary *dic1 in moreBrandArray) {
                                              MoreBrandModel *model = [[MoreBrandModel alloc]init];
                                              
                                              [model setValuesForKeysWithDictionary:dic1];
                                              [self.moreBrandArray addObject:model];
                                              
                                          }
                                          
                                          if (myTableView) {
                                              [myTableView reloadData];
                                              [myTableView setContentOffset:CGPointMake(0,0) animated:NO];
                                              
                                          }
                                          else
                                          {
                                              
                                              [self setupMainView];
                                              
                                              [self setUpAllViews];
                                              
                                              
                                          }

                                      } enError:^(NSError *error) {
                                          NSLog(@"%@请求数据失败:%@",title,error);
                                      }];
  
}
#pragma mark - 数据为空时处理
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    [self.bottomView removeFromSuperview];
    return [UIImage imageNamed:@"orde_-list_-empty"];
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"orde_-list_-empty_casually_browse"];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    NSLog(@"你要想添加吗");
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"你还没有收藏哟!";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

@end

