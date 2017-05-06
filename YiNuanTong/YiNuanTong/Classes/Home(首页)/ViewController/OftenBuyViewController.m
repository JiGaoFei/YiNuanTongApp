//
//  OftenBuyViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OftenBuyViewController.h"
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
#import "ShopGoodsDeitalViewController.h"
@interface OftenBuyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UISearchBarDelegate>
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
/**创建筛选视图*/
@property (nonatomic,strong) ShopListChooseView  * chooseView;
/**底部视图*/
@property (nonatomic,strong) UIView *bottomView;
/**创建购物车视图*/
@property (nonatomic,strong) UIView *shopCarView;
/**创建collectionView*/
@property (nonatomic,strong) UICollectionView  * shopCarCollectionView;
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
/**用于传值的model*/
@property (nonatomic,strong) HomeGoodsModel  * shopCarModel;
/**加入购物车的数量*/
@property (nonatomic,assign) NSInteger  shopGoodsNum;
/**页数*/
@property (nonatomic,assign) NSInteger  page;
/**是否是上拉*/
@property (nonatomic,assign) BOOL  isUp;
/**当前选中的按钮(用于控制按钮的颜色)*/
@property (nonatomic,strong) UIButton *selectedButton;
/**背景*/
@property (nonatomic,strong) UIView  * bagView;
/**判断是否筛选框出现,用于改变图标*/
@property (nonatomic,assign) BOOL isSelectViewApperar;
/**筛选视图*/
@property (nonatomic,strong) GFDropDownMenu *dropDownMenu;
/**价格排序的状态(yes代表低到高)*/
@property (nonatomic,assign) BOOL  isPriceLowToHigh;
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
/** 用于判断是否给品牌赋值 */
@property (nonatomic,assign) BOOL isBrand;
/**记录选中品牌的cell*/
@property (nonatomic,strong) DropDownCell *brandCell;
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
/**商品id*/
@property (nonatomic,copy) NSString *brand_id;
/**价格区间*/
@property (nonatomic,copy) NSString *price_qujian;


@end
static NSString *dropDownCell = @"dropDownCell";
static NSString *listCell = @"listCell";

@implementation OftenBuyViewController
/** 下拉品牌筛选数据  */
- (NSMutableArray *)selectBrandArr
{
    if (!_selectBrandArr) {
        self.selectBrandArr = [[NSMutableArray alloc]init];
    }
    return _selectBrandArr;
}
/** 更多品牌数据 */
- (NSMutableArray *)moreBrandArray
{
    if (!_moreBrandArray) {
        self.moreBrandArray = [[NSMutableArray alloc]init];
    }
    return _moreBrandArray;
}
/** 用于赋值的筛选数组 */
- (NSMutableArray *)transmitArray
{
    if (!_transmitArray) {
        self.transmitArray = [[NSMutableArray alloc]init];
    }
    return _transmitArray;
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
    isSelect = NO;
 
    selectAll.selected = NO;
    self.page = 1;
    
    priceLabel.text = [NSString stringWithFormat:@"￥0.00"];
    
    self.serialNumber = 1;
    self.isFirstEnter = YES;
    [self creatData];
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
    self.page = 1;
    self.brandStr = @"";
    self.isBrand = YES;
    self.isSelectViewApperar = NO;
    // 加载右侧item
    [self setUpRightItem];
    [self setUpSearchViews];
    
    dataArray = [[NSMutableArray alloc]init];
    selectGoods = [[NSMutableArray alloc]init];
  
     self.title = @"常购商品";
}

// 加载数据
-(void)creatData
{
    UserInfo *userInfo = [UserInfo currentAccount];
    NSString *page = [NSString stringWithFormat:@"%ld",(long)self.page];
    self.params = @{@"act":@"list",@"user_id":userInfo.user_id,@"page":page,@"tpagesize":@"10"};

    // 请求列表数据
    NSString *goodListUrl = [NSString stringWithFormat:@"%@api/goods_often.php",baseUrl];
    [YNTNetworkManager requestPOSTwithURLStr:goodListUrl paramDic:self.params finish:^(id responseObject) {
        NSLog(@"%@",responseObject);
        // 隐藏加载圏
        [GFProgressHUD hide];
        // 停止刷新
        [self endRefresh];
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        
        
        NSArray *dataArr= returnDic[@"goods"];
        if (dataArr.count == 0) {
            // 无数据时
            [GFProgressHUD showInfoMsg:@"没有你想要的商品了"];
            return ;
        }
        
        // 有数据时
        [dataArray removeAllObjects];

        for (NSDictionary *dic in dataArr) {
            
            HomeGoodsModel *model = [[HomeGoodsModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            [dataArray addObject:model];
        }
     
        
        
        
        if (myTableView) {
            [myTableView reloadData];
           // [myTableView setContentOffset:CGPointMake(0,0) animated:NO];
            
        }
        else
        {
            
            [self setupMainView];
            
   
            
            
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
    UIImage *rightImage = [UIImage imageNamed:@"购物车"];
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


#pragma mark - 设置主视图
-(void)setupMainView
{
        myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 110, KScreenW, kScreenH - 110) style:UITableViewStylePlain];
        myTableView.delegate = self;
        myTableView.dataSource = self;
    myTableView.emptyDataSetDelegate = self;
    myTableView.emptyDataSetSource = self;
        myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新的时候 ,将主动page改为 0
        
        self.isUp = NO;// 标识下拉
        self.page -= 1;
        [self creatData];
     
    }];
    
    myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.isUp = YES;//标识上拉
        self.page += 1;
        [self creatData];
       
    }];
        [self.view addSubview:myTableView];
        
   
}
#pragma mark -实时监听文字改变
- (void)textChage:(UITextField *)sender
{
    NSLog(@"%@",self.numberTextField.text);
     self.shopGoodsNum = [self.numberTextField.text integerValue];
}
#pragma mark - 常购键盘完成事件
- (void)confrimBtnAction:(UIButton *)sender
{
    NSLog(@"点击常购完成");
    [self.view endEditing:YES];
}
// 购物车加事件
- (void)addBtnClick:(UIButton *)sender
{
    NSLog(@"我是购物车加");
    
    NSInteger countNum = [self.numberTextField.text integerValue];
    countNum++;
    self.shopGoodsNum = countNum;
    NSLog(@"加入购物车的数量%ld",(long)self.shopGoodsNum);
    self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)countNum];
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
    self.shopGoodsNum=countNum;
     NSLog(@"加入购物车的数量%ld",(long)self.shopGoodsNum);
    self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)countNum];
    
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

    cell.isSelected = isSelect;
    cell.listCarBtn.hidden = YES;
    cell.selectBtn.hidden = YES;

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
#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.collectionView) {
        return self.transmitArray.count;
    }
    
    
    return 0;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.collectionView) {
        self.downCell= [collectionView dequeueReusableCellWithReuseIdentifier:dropDownCell forIndexPath:indexPath];
    _downCell.backgroundColor = RGBA(217, 217, 217, 1);
        if (_downCell.isSelected) {
            _downCell.backgroundColor = CGRBlue;
        }
        
        if (self.isBrand) {
            BrandModel *model = self.transmitArray[indexPath.row];
            _downCell.lab.text = model.catname;
        }else{
            MoreBrandModel *model = self.transmitArray[indexPath.row];
            _downCell.lab.text = model.catname;
        }
        return _downCell;
        
    }

    
    return 0;
    
}

#pragma mark - 停止刷新
/**
 *  停止刷新
 */
-(void)endRefresh{
    [myTableView.mj_header endRefreshing];
    [myTableView.mj_footer endRefreshing];
}


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
    
    NSString *url = [NSString stringWithFormat:@"%@api/goods_often.php",baseUrl];
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
                                              
                                              
                                          }
                                          
                                      } enError:^(NSError *error) {
                                          NSLog(@"%@请求数据失败:%@",title,error);
                                      }];
    
}

@end

