//
//  ShopGoodsListViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/19.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "ShopGoodsListViewController.h"
#import "GFDropDownMenu.h"
#import "YNTUITools.h"
#import "DropDownCell.h"
#import "ShopListChooseView.h"
#import "ShopListCell.h"
#import "YNTNetworkManager.h"
#import "UIImageView+WebCache.h"
#import "YNTShopingCarViewController.h"
#import "BrandModel.h"
#import <MJRefresh/MJRefresh.h>
#import "HomeGoodsDetailSizeModel.h"
#import "MoreBrandModel.h"
#import "UIScrollView+EmptyDataSet.h"
#import "HomeShopListModel.h"
#import "ShopGoodDetailOneController.h"
#import "ShopGoodDetailNoViewController.h"
#import "ShopGooodDetailMoreViewController.h"
#import "PayDetailViewController.h"
@interface ShopGoodsListViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout>

/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**下拉view*/
@property (nonatomic,strong) UIView  * dropDownView;
/**collectionView*/
@property (nonatomic,strong) UICollectionView *collectionView;
/**创建布局对象*/
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong)  DropDownCell *downCell;
/**搜索框*/
@property (nonatomic,strong) UISearchBar *searchBar;

/**创建筛选视图*/
@property (nonatomic,strong) ShopListChooseView  * chooseView;
/**当前选中的按钮(用于控制按钮的颜色)*/
@property (nonatomic,strong) UIButton *selectedButton;
/**创建购物车视图*/
@property (nonatomic,strong) UIView *shopCarView;

/**购物车中数量*/
@property (nonatomic,strong) UITextField *numberTextField;
/**创建collectionView*/
@property (nonatomic,strong) UICollectionView  * shopCarCollectionView;
/**创建布局对象*/
@property (nonatomic,strong) UICollectionViewFlowLayout  * shopCarFlowLayout;
/**存放model数组*/
@property (nonatomic,strong) NSMutableArray  * modelArr;
/**存放点击品牌数据 */
@property (nonatomic,strong) NSMutableArray  * brandArray;
/**是否给品牌赋值*/
@property (nonatomic,assign) BOOL isBrand;
/**存放更多数组*/
@property (nonatomic,strong) NSMutableArray *moreBrandArray;
/**用于给筛选赋值*/
@property (nonatomic,strong) NSMutableArray *transmitArray;
/**存放购物车视图规格数据*/
@property (nonatomic,strong) NSMutableArray  * shopCarBrandArray;
/**蒙层view*/
@property (nonatomic,strong) UIView  * maskView;

/**加入购物车的数量*/
@property (nonatomic,assign) NSInteger  shopGoodsNum;
/**价格排序的状态(yes代表低到高)*/
@property (nonatomic,assign) BOOL  isPriceLowToHigh;
/**用于控制筛选动画*/
@property (nonatomic,strong) UIButton *selectBtn;
/**页数*/
@property (nonatomic,assign) NSInteger  page;
// YES 代表上拉  NO代表下拉
@property (nonatomic,assign) BOOL isUp;
/**背景*/
@property (nonatomic,strong) UIView  * bagView;
/**判断是否筛选框出现,用于改变图标*/
@property (nonatomic,assign) BOOL isSelectViewApperar;
/**筛选视图*/
@property (nonatomic,strong) GFDropDownMenu *dropDownMenu;
/**huo_id*/
@property (nonatomic,copy) NSString *huo_id;

/**购物车视图名称*/
@property (nonatomic,strong) UILabel *goodNameLab;
/**购物车视图价格*/
@property (nonatomic,strong)  UILabel *goodPriceLab;
/**购物车视图库存*/
@property (nonatomic,strong) UILabel *goodStockLab;
/**记录选中的品牌数据*/
@property (nonatomic,copy) NSString *brandStr;
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
/**品牌id*/
@property (nonatomic,copy) NSString *brand_id;
/**更多品牌id*/
@property (nonatomic,copy) NSString *moreBrand_id;
/**价格区间*/
@property (nonatomic,copy) NSString *price_qujian;
/**销量*/
@property (nonatomic,copy) NSString * saleNum;
/**价格*/
@property (nonatomic,copy) NSString * salePrice;

/**数据源*/
@property (nonatomic,strong) NSMutableDictionary *dataDic;


@end
static NSString *dropDownCell = @"dropDownCell";
static NSString *listCell = @"listCell";
@implementation ShopGoodsListViewController
- (NSMutableDictionary *)dataDic
{
    if (!_dataDic) {
        self.dataDic = [[NSMutableDictionary alloc]init];
    }
    return _dataDic;
}
/**
 *懒加载
 */
- (NSMutableArray *)shopCarBrandArray
{
    if (!_shopCarBrandArray) {
        self.shopCarBrandArray = [[NSMutableArray alloc]init];
    }
    return _shopCarBrandArray;
}
- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        self.modelArr = [[NSMutableArray alloc]init];
    }
    return _modelArr;
}
//存放点击品牌数组
- (NSMutableArray *)brandArray
{
    if (!_brandArray) {
        self.brandArray =[[NSMutableArray alloc]init];
    }
    return _brandArray;
}
// 存放更多品牌数组
- (NSMutableArray *)moreBrandArray
{
    if (!_moreBrandArray) {
        self.moreBrandArray = [[NSMutableArray alloc]init];
    }
    return _moreBrandArray;
}
// 用于传值数组
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
// 视图将要出现的时候 隐藏tabbar
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.isFirstEnter = YES;
    // 加载子视图
    [self setUpChildrenViews];
    // 马上进入刷新状态
   // [self.tableView.mj_header beginRefreshing];
//    self.page = 1;
//    self.serialNumber = 1;

 
    }
// 视图将要消失的时候显示tabbar
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.page = 1;
    self.serialNumber = 1;
    [self loadData];
    self.view.backgroundColor = [UIColor grayColor];
  // self.isPriceLowToHigh = NO;
    self.brandStr = @"";
    self.brand_id = @"";
    self.moreBrand_id = @"";
    self.salePrice = @"0";
    
    self.isBrand = YES;
    self.isSelectViewApperar = NO;
    [self setUpRightItem];
    // 设置导航栏
    [self setUpNavViews];
      // 加载下拉菜单
    [self setUpDropDownMenu];
    
  

    
}

/**
 *加载数据
 */
- (void)loadData
{
    // 首次进入显示加载圈
    if (self.isFirstEnter) {
        [GFProgressHUD showLoading:@"正在加载数据"];
        [self.moreBrandArray removeAllObjects];
    }
    
 
  
    
    UserInfo *userInfo = [UserInfo currentAccount];
    if (_serialNumber == 1) {//默认
       
     
      self.params = @{@"cat_id":self.cat_id,@"user_id":userInfo.user_id,@"page":@(self.page),@"tpagesize":@"9"};

    }
    if (_serialNumber == 2) {//商品搜索
        self.params = @{@"searchstr":self.searchStr,@"user_id":userInfo.user_id,@"page":@(self.page),@"tpagesize":@"9",@"cat_id":self.cat_id};
        
    }
    if (_serialNumber == 3) {//搜索品牌
        self.params = @{@"brand_id":self.brand_id,@"user_id":userInfo.user_id,@"page":@(self.page),@"tpagesize":@"9",@"cat_id":self.cat_id,@"zongHeOrder":self.salePrice};
        
    }

    if (_serialNumber == 4) {//价格从低到高
        self.params = @{@"zongHeOrder":self.salePrice,@"user_id":userInfo.user_id,@"page":@(self.page),@"tpagesize":@"9",@"cat_id":self.cat_id,@"brand_id":self.brand_id};
        
    }
    if (_serialNumber == 5) {//价格从高到低
           self.params = @{@"zongHeOrder":self.salePrice,@"user_id":userInfo.user_id,@"page":@(self.page),@"tpagesize":@"9",@"cat_id":self.cat_id,@"brand_id":self.brand_id};
        
    }
    if (_serialNumber == 6) {//搜索更多
        self.params = @{@"cat_id":self.cat_id,@"user_id":userInfo.user_id,@"page":@(self.page),@"tpagesize":@"9",@"brand_id":self.brand_id,@"zongHeOrder":self.salePrice};
        
    }
    if (_serialNumber == 7) {//筛选价格区间
        self.params = @{@"price_qujian":self.price_qujian,@"user_id":userInfo.user_id,@"page":@(self.page),@"tpagesize":@"9",@"cat_id":self.cat_id,@"brand_id":self.brand_id,@"cat_id":self.cat_id,@"zongHeOrder":self.salePrice};
        
    }
    if (_serialNumber == 8) {//销量从高到低
        self.params = @{@"salesOrderBy":@"1",@"user_id":userInfo.user_id,@"page":@(self.page),@"tpagesize":@"9",@"cat_id":self.cat_id,@"brand_id":self.brand_id,@"cat_id":self.cat_id,@"zongHeOrder":self.salePrice};
        
    }
    
    if (_serialNumber == 9) {//销量从低到高
       self.params = @{@"salesOrderBy":@"0",@"user_id":userInfo.user_id,@"page":@(self.page),@"tpagesize":@"9",@"cat_id":self.cat_id,@"brand_id":self.brand_id,@"zongHeOrder":self.salePrice};
    }
    NSString *goodListUrl = [NSString stringWithFormat:@"%@/api/goodsclass.php",baseUrl];
    
    
    [YNTNetworkManager requestPOSTwithURLStr:goodListUrl paramDic:_params finish:^(id responseObject) {
        //隐藏加载圏
        [GFProgressHUD hide];
        // 停止刷新
        [self endRefresh];
      
        NSLog(@"%@",responseObject);
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *dataArray = returnDic[@"data"];
        if ([responseObject[@"err_msg"] isEqualToString:@"fail"]) {
            [GFProgressHUD showFailure:@"没有找到你要的商品!"];
            return ;
        }
        if (dataArray.count == 0) {
            [GFProgressHUD showFailure:@"没有更多数据了"];
            return;
        }
        
        
        [self.modelArr removeAllObjects];
        for (NSDictionary *dic in dataArray) {
       
            HomeShopListModel *model = [[HomeShopListModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
             NSLog(@"名字%@",model.name);
        
         [self.modelArr addObject:model];
            
        }
 
        
        
        
        if (self.isFirstEnter) { // 第一次进的时候赋值
            self.isFirstEnter = NO;
            [self.brandArray removeAllObjects];
            // 获取品牌数据
            NSArray *brandArray = returnDic[@"brandsls"];
            for (NSDictionary *dic1 in brandArray) {
                BrandModel *model = [[BrandModel alloc]init];
                [model setValuesForKeysWithDictionary:dic1];
                NSLog(@"%@",model.catname);
                [self.brandArray addObject:model];
                
            }
            self.transmitArray = self.brandArray;
      
            NSArray *moreBrandArray = returnDic[@"typels"];
            
            for (NSDictionary *dic1 in moreBrandArray) {
                MoreBrandModel *model = [[MoreBrandModel alloc]init];
                
                [model setValuesForKeysWithDictionary:dic1];
                [self.moreBrandArray addObject:model];
                
            }
            

        }else{
              [self.tableView setContentOffset:CGPointMake(0,100) animated:NO];
        }
        [self.collectionView reloadData];
        [self.tableView reloadData];
      

    } enError:^(NSError *error) {
        NSLog(@"请求失败");
        [GFProgressHUD hide];
        //停止刷新
        [self endRefresh];
    }];
    
    
}
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

#pragma mark - 购物车按钮的点击事件

- (void)rightBarButtonItemAction:(UIButton *)sender
{
    

    NSLog(@"点击的是右边items");
    
    self.tabBarController.selectedIndex = 1;
    
}
/**
 *创建导航栏视图
 */

-(void)setUpNavViews {
   // 创建搜索框
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(5, 5, 190, 35)];
    
    // 去掉搜索框的边界线
    [_searchBar setBackgroundImage:[[UIImage alloc]init] ];

    
    _searchBar.placeholder = @"商品搜索";
    _searchBar.delegate = self;
    
    UIView * centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    
    [centerView addSubview:_searchBar];
   
    self.navigationItem.titleView = centerView;
    
    }

/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 102, KScreenW, kScreenH -60) style:UITableViewStylePlain];
   
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
  
    //注册cell
    [self.tableView registerClass:[ShopListCell class] forCellReuseIdentifier:listCell];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 下拉刷新的时候 ,将主动page改为 0
        
        self.isUp = NO;// 标识下拉
        self.page -= 1;
        [self loadData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 上拉刷新的时候每次页数加1
          self.page+=1;
       
        [self loadData];
    }];
      self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    
    
}
/**
 *  停止刷新
 */
-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

/**
 *创建下拉菜单
 */
- (void)setUpDropDownMenu
{
    // 如果有导航栏请清除自动适应设置
    self.automaticallyAdjustsScrollViewInsets = NO;
    GFDropDownMenu *dropDownMenu = [[GFDropDownMenu alloc]initWithFrame:CGRectMake(0, 64, KScreenW, 44 *kHeightScale)];
    self.dropDownMenu = dropDownMenu;
    
    __weak typeof(_dropDownMenu) weakSelf = _dropDownMenu;
   
    dropDownMenu.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_dropDownMenu];
    dropDownMenu.bttonClicked = ^(NSInteger index){
        switch (index) {
                    case 1600:
                    {
                  NSLog(@"点击的是品牌");
                        [self.chooseView removeFromSuperview];
                        [self.dropDownView removeFromSuperview];
                        [self setUpDropDownMenViews];
                     
                        [self selectSetBtnImage:weakSelf.threeBtn andImageName:@"箭头向下"];
                        [self selectSetBtnImage:weakSelf.fourBtn andImageName:@"箭头向下"];
                        
                        if (self.isSelectViewApperar) {
                            self.isSelectViewApperar = NO;
                            [self selectSetBtnImage:weakSelf.oneBtn andImageName:@"箭头向下"];
                        }else{
                            self.isSelectViewApperar = YES;
                            [self selectSetBtnImage:weakSelf.oneBtn andImageName:@"箭头向上"];
                            
                        }
                        
                        self.isBrand = YES;
                        self.transmitArray = _brandArray;
                        [self.collectionView reloadData];

                  }
                
                
                  break;
          
                    case 1601:
                    {
                        [self.chooseView removeFromSuperview];
                        [self.dropDownView removeFromSuperview];
                        NSString *i = @"";
                        NSLog(@"点击的是价格");
                        [self selectSetBtnImage:weakSelf.oneBtn andImageName:@"箭头向下"];
                        [self selectSetBtnImage:weakSelf.fourBtn andImageName:@"箭头向下"];

                        [self selectSetBtnImage:weakSelf.threeBtn andImageName:@"箭头向下"];
                        [self selectSetBtnImage:weakSelf.fourBtn andImageName:@"箭头向下"];


                        if (self.isPriceLowToHigh) {
                            NSLog(@"价格从低到高排序");
                            i = @"1";
                            self.serialNumber =4;
                            self.salePrice = @"1";
                 
                            self.isPriceLowToHigh = NO;
                           [self loadData];
                            [self selectSetBtnImage:weakSelf.twoBtn andImageName:@"双箭头上"];
                        }else{
                            NSLog(@"价格从高到低排序");
                            self.isPriceLowToHigh = YES;
                            self.serialNumber = 5;
                            
                            i = @"0";
                            self.salePrice = @"2";
                            [self loadData];

                          [self selectSetBtnImage:weakSelf.twoBtn andImageName:@"双箭头下"];
                        }
                        self.page = 1;                                         
                        
                    }
                        
                        break;


                    case 1602:
                    {
                        [self.chooseView removeFromSuperview];
                        [self.dropDownView removeFromSuperview];
                        NSLog(@"点击的是更多");
                        
                        [self selectSetBtnImage:weakSelf.oneBtn andImageName:@"箭头向下"];
                        [self selectSetBtnImage:weakSelf.fourBtn andImageName:@"箭头向下"];
                        
                        [self selectSetBtnImage:weakSelf.threeBtn andImageName:@"箭头向下"];

                        if (self.isSelectViewApperar) {
                            
                            self.isSelectViewApperar = NO;
                            [self selectSetBtnImage:weakSelf.threeBtn andImageName:@"箭头向下"];
                        }else{
                            self.isSelectViewApperar = YES;
                            [self selectSetBtnImage:weakSelf.threeBtn andImageName:@"箭头向上"];
                            
                        }
                    
                        self.isBrand = NO;
                        self.transmitArray = _moreBrandArray;
                        [self.collectionView reloadData];

                        [self  setUpDropDownMenViews];
                     
                        
                    }
                                
                    break;

            
                    case 1603:
                    {
                        NSLog(@"点击的是筛选");
                        [self.chooseView removeFromSuperview];
                        [self.dropDownView removeFromSuperview];
                        [self selectSetBtnImage:weakSelf.oneBtn andImageName:@"箭头向下"];
                        [self selectSetBtnImage:weakSelf.threeBtn andImageName:@"箭头向下"];
                        
                        [self selectSetBtnImage:weakSelf.fourBtn andImageName:@"箭头向上"];

                     
                        if (self.isSelectViewApperar) {
                            self.isSelectViewApperar = NO;
                            [self selectSetBtnImage:weakSelf.fourBtn andImageName:@"箭头向下"];
                        }else{
                            self.isSelectViewApperar = YES;
                            [self selectSetBtnImage:weakSelf.fourBtn andImageName:@"箭头向上"];
                            
                        }

                        [self setUpChooseChildViews];
                      
                    }
                                        
                    break;

                
            default:
                break;
        }
    };
}

#pragma mark - 筛选框动画
- (void)selectSetBtnImage:(UIButton *)btn andImageName:(NSString *)str
{
    UIImage *img = [UIImage imageNamed:str];
    img = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [btn setImage:img forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0) ;

}
#pragma mark - 创建购物车视图

/**
 *创建的是购物车
 */

- (void)setUpShopCarViews:(HomeShopListModel *)model
{
    self.shopCarView = [[UIView alloc]initWithFrame:CGRectMake(100 *kWidthScale,0, KScreenW, kScreenH - 64)];
    self.shopCarView.backgroundColor = RGBA(249, 249, 249, 1);
    self.bagView = [[UIView alloc]initWithFrame:CGRectMake(KScreenW, 64,KScreenW, kScreenH - 64)];
    [self.bagView addSubview:self.shopCarView];
    self.bagView.backgroundColor = RGBA(0, 0, 0, 0.6);
    
    [self.view addSubview:self.bagView];
    
    
    // 创建图片
    UIImageView *imgView = [YNTUITools createImageView:CGRectMake(10 *kWidthScale, 16 *kHeightScale, 203 *kPlus *kWidthScale, 187*kPlus *kHeightScale) bgColor:nil imageName:@"女11"];
    [imgView sd_setImageWithURL:[NSURL URLWithString:model.cover_img]];
    [self.shopCarView addSubview:imgView];
    // 创建titlelab
    UILabel *titleLba = [YNTUITools createLabel:CGRectMake(130 *kWidthScale, 24 *kHeightScale, 160 *kWidthScale, 16 *kHeightScale) text:model.name textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:16 *kHeightScale];
    [self.shopCarView addSubview:titleLba];
    self.goodNameLab = titleLba;
    
    // 创建价格lab
    UILabel *priceLab = [YNTUITools createLabel:CGRectMake(130 *kWidthScale, 70 *kHeightScale, 160*kWidthScale, 19 *kHeightScale) text:[NSString stringWithFormat:@"¥%@",model.price]  textAlignment:NSTextAlignmentLeft textColor:CGRRed bgColor:nil font:19*kHeightScale];
    [self.shopCarView addSubview:priceLab];
    self.goodPriceLab = priceLab;
  
    UILabel *numberLab = [YNTUITools createLabel:CGRectMake(130 *kWidthScale, 95 *kHeightScale, 160 *kWidthScale, 12 *kHeightScale) text:  [NSString stringWithFormat:@"库存"] textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:12 *kHeightScale];
    [self.shopCarView addSubview:numberLab];
    self.goodStockLab = numberLab;
    
    // 创建规格lab
    UILabel *sizeLab = [YNTUITools createLabel:CGRectMake(15 *kWidthScale,130 *kHeightScale, 100 *kWidthScale, 14 *kHeightScale) text:@"规格" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:14 *kHeightScale];
    [self.shopCarView addSubview:sizeLab];
    
    
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 145 *kHeightScale , KScreenW - 100 *kWidthScale, 200 *kHeightScale)];

    [self.shopCarView addSubview:contentView];
    
 
     

   // 创建订购数量
    
    // 创建规格lab
    UILabel *orderNumberLab = [YNTUITools createLabel:CGRectMake(15 *kWidthScale,374 *kHeightScale, 100 *kWidthScale, 15 *kHeightScale) text:@"订购数量" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15 *kHeightScale];
    
    [self.shopCarView addSubview:orderNumberLab];
    
    // 创建单位lab
    UILabel  *unitLab  = [YNTUITools createLabel:CGRectMake(80 *kWidthScale,375*kHeightScale, 120*kWidthScale, 13 *kHeightScale) text:@"单位(件)" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13 *kHeightScale];
    
    [self.shopCarView addSubview:unitLab];


    
    // 创建加减背景
    UIImageView *addImgView = [YNTUITools createImageView:CGRectMake(15 *kWidthScale, 410 *kHeightScale, 368 *kPlus *kWidthScale, 68*kPlus *kHeightScale) bgColor:nil imageName:@"添加"];
    addImgView.userInteractionEnabled = YES;
    [self.shopCarView addSubview:addImgView];
    
    
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(163 *kWidthScale, 410 *kHeightScale, 36 *kWidthScale ,68 *kPlus *kHeightScale);
    [addBtn setImage:[UIImage imageNamed:@"右加"] forState:UIControlStateNormal];
 
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
  
    [self.shopCarView addSubview:addBtn];
    
    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame =  CGRectMake(15 *kWidthScale, 410 *kHeightScale , 36 *kWidthScale ,68 *kPlus *kHeightScale);
    [cutBtn setImage:[UIImage imageNamed:@"添加左减"] forState:UIControlStateNormal];
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.shopCarView  addSubview:cutBtn];
    
   

    //数量显示
    self.numberTextField = [YNTUITools creatTextField:CGRectMake(50 * kWidthScale, 410 *kHeightScale, 110 *kWidthScale, 68 *kPlus *kHeightScale) bgColor:nil borderStyle:UITextBorderStyleNone placeHolder:nil keyboardType:UIKeyboardTypePhonePad font:17*kHeightScale secureTextEntry:NO clearButtonMode:UITextFieldViewModeNever];
    self.numberTextField.text = @"1";
    self.numberTextField.textAlignment = NSTextAlignmentCenter;
    
    // 实时监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChage:) name:UITextFieldTextDidChangeNotification object:self.numberTextField];
    
    
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, KScreenW,30)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(KScreenW - 60, 7,50, 20)];
    [button addTarget:self action:@selector(confrimBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"完成"forState:UIControlStateNormal];
    [button setTitleColor:CGRBlue forState:UIControlStateNormal];
    [bar addSubview:button];
    _numberTextField.inputAccessoryView = bar;
    [self.shopCarView addSubview:_numberTextField];
    
    
    

    
    
    [UIView animateWithDuration:1.0 animations:^{
        CGRect  rect = self.bagView.frame;
        rect.origin.x = 0;
        self.bagView.frame = rect;
    }];
    
    
}
#pragma mark - 实时监听文字的改变
- (void)textChage:(UITextField *)sender
{
    NSLog(@"%@",self.numberTextField.text);
    self.shopGoodsNum = [self.numberTextField.text integerValue];
}
#pragma makr - 点击键盘上完成事件
- (void)confrimBtnAction:(UIButton *)sender
{
    NSLog(@"点击商品列表键盘上的完成");
    [self.view endEditing:YES];
}
// 购物车加事件
- (void)addBtnClick:(UIButton *)sender
{
    NSLog(@"我是购物车加");
    
    NSInteger countNum = [self.numberTextField.text integerValue];
      countNum++;
    self.shopGoodsNum = countNum;
    NSLog(@"加入购物车的数量:%ld",(long)self.shopGoodsNum);
    self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)countNum];
}
// 购物车加事件
- (void)cutBtnClick:(UIButton *)sender
{
    NSLog(@"我是购物车减");
    NSInteger countNum = [self.numberTextField.text integerValue];
    if (countNum <=0) {
        return;
    }
    countNum--;
    self.shopGoodsNum = countNum;
      NSLog(@"加入购物车的数量:%ld",(long)self.shopGoodsNum);
    self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)countNum];

}


#pragma mark - 创建下拉框品牌和更多的子视图
/**
 *创建下拉框品牌和更多的子视图
 */
- (void)setUpDropDownMenViews
{
    CGFloat height = 98 *kHeightScale;
    if (KScreenW == 320) {
        height = 110 *kHeightScale;
    }
    //创建下拉view
    self.dropDownView = [[UIView alloc]initWithFrame:CGRectMake(0, height, KScreenW, 240)];
    _dropDownView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dropDownView];
    
    
    // 创建collectionView
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20 *kHeightScale, KScreenW, 180) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.flowLayout.itemSize = CGSizeMake(80, 30 );
    // 注册cell
    [self.collectionView registerClass:[DropDownCell class] forCellWithReuseIdentifier:dropDownCell];
    [self.dropDownView addSubview:self.collectionView];
    
    
// 创建确定 取消按钮
  //  UIButton *cancelBtn =[YNTUITools  createButton:CGRectMake(0, 200, KScreenW / 2, 40) bgColor:[UIColor whiteColor] title:@"取消" titleColor:[UIColor blackColor] action:@selector(cancelBtnAction:) vc:self];
    
    
   // [self.dropDownView addSubview:cancelBtn];
    
    UIButton *confirmBtn =[YNTUITools createButton:CGRectMake(0, 200, KScreenW , 40) bgColor:CGRBlue title:@"取消" titleColor:[UIColor whiteColor] action:@selector(confirmBtnAction:) vc:self];
    [self.dropDownView addSubview:confirmBtn];
    
    

}
- (void)cancelBtnAction:(UIButton *)sender
{
    NSLog(@"我是下拉取消");

    [self.dropDownView removeFromSuperview];
    self.isSelectViewApperar = NO;
    [self selectSetBtnImage:self.dropDownMenu.oneBtn andImageName:@"箭头向下"];
      [self selectSetBtnImage:self.dropDownMenu.threeBtn andImageName:@"箭头向下"];
      [self selectSetBtnImage:self.dropDownMenu.fourBtn andImageName:@"箭头向下"];
  

}
- (void)confirmBtnAction:(UIButton *)sender
{
     NSLog(@"我是下拉确定");
    [self.dropDownView removeFromSuperview];
    self.isSelectViewApperar = NO;
    [self selectSetBtnImage:self.dropDownMenu.oneBtn andImageName:@"箭头向下"];
    [self selectSetBtnImage:self.dropDownMenu.threeBtn andImageName:@"箭头向下"];
    [self selectSetBtnImage:self.dropDownMenu.fourBtn andImageName:@"箭头向下"];

    

}

#pragma mark - 筛选视图
/**
 *创建筛选视图
 */
- (void)setUpChooseChildViews
{
   
    CGFloat  height = 98 *kHeightScale;
    if (KScreenW == 320) {
        height = 108 *kHeightScale;
    }
    self.chooseView = [[ShopListChooseView alloc]initWithFrame:CGRectMake(0, height, KScreenW, 200*kHeightScale)];

    self.chooseView.backgroundColor = [UIColor whiteColor];
 
    
    
    __weak typeof (self) weakSelf = self;
  weakSelf.chooseView.btnClicked = ^(NSInteger index){
        switch (index) {
            case 1700:
            {
                NSLog(@"点击的是从高到低");
                self.serialNumber = 8;
                [self loadData];
                [weakSelf.chooseView removeFromSuperview];
                self.isSelectViewApperar = NO;
                [self selectSetBtnImage:self.dropDownMenu.oneBtn andImageName:@"箭头向下"];
                [self selectSetBtnImage:self.dropDownMenu.threeBtn andImageName:@"箭头向下"];
                [self selectSetBtnImage:self.dropDownMenu.fourBtn andImageName:@"箭头向下"];
                
                

                
            }
                break;
            case 1701:
            {
                NSLog(@"点击的是从低到高");
                self.serialNumber = 9;
                [self loadData];
                [weakSelf.chooseView removeFromSuperview];
                self.isSelectViewApperar = NO;
                [self selectSetBtnImage:self.dropDownMenu.oneBtn andImageName:@"箭头向下"];
                [self selectSetBtnImage:self.dropDownMenu.threeBtn andImageName:@"箭头向下"];
                [self selectSetBtnImage:self.dropDownMenu.fourBtn andImageName:@"箭头向下"];
                
                

                
                }
                break;

            case 1702:
            {
                NSLog(@"点击的是重置");
                [weakSelf.chooseView removeFromSuperview];
                self.isSelectViewApperar = NO;
                [self selectSetBtnImage:self.dropDownMenu.oneBtn andImageName:@"箭头向下"];
                [self selectSetBtnImage:self.dropDownMenu.threeBtn andImageName:@"箭头向下"];
                [self selectSetBtnImage:self.dropDownMenu.fourBtn andImageName:@"箭头向下"];

            }
                break;

            case 1703:
            {
                NSLog(@"点击的是完成");
                self.serialNumber = 7;
                
            NSString *price_qujian = [NSString stringWithFormat:@"%@_%@",self.chooseView.minTextField.text,self.chooseView.maxTextField.text];
                self.price_qujian = price_qujian;
            
                // 只要一个为空就不处理
                if (self.chooseView.minTextField.text.length == 0 || self.chooseView.maxTextField.text.length ==0) {
                         [weakSelf.chooseView removeFromSuperview];
                }
                [self loadData];
                [weakSelf.chooseView removeFromSuperview];
                self.isSelectViewApperar = NO;
                [self selectSetBtnImage:self.dropDownMenu.oneBtn andImageName:@"箭头向下"];
                [self selectSetBtnImage:self.dropDownMenu.threeBtn andImageName:@"箭头向下"];
                [self selectSetBtnImage:self.dropDownMenu.fourBtn andImageName:@"箭头向下"];

                
                
            }
                break;

                
            default:
                break;
        }
    };
    [self.view addSubview:self.chooseView];
}



#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.collectionView) {
          return self.transmitArray.count;
    }
    
    
//    if (collectionView == self.shopCarCollectionView) {
//        return 3;
//    }

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
      //   _downCell.backgroundColor = RGBA(217, 217, 217, 1);
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
//    if (collectionView == self.shopCarCollectionView) {
//        self.downCell= [collectionView dequeueReusableCellWithReuseIdentifier:dropDownCell forIndexPath:indexPath];
//        _downCell.backgroundColor = RGBA(217, 217, 217, 1);
//        if (_downCell.isSelected) {
//            _downCell.backgroundColor = CGRBlue;
//        }
//        return _downCell;
//        
//    }
    

       

    return 0;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collectionView) {
        //根据idenxPath获取对应的cell
        UICollectionViewCell *cell =   [collectionView cellForItemAtIndexPath:indexPath];
        cell.backgroundColor = CGRBlue;
        if (self.isBrand) {
            BrandModel *model = self.transmitArray[indexPath.row];
            _downCell.lab.text = model.catname;
            self.serialNumber = 3;
            self.brand_id = model.brand_id;
            
         
            [self loadData];
          //  [self requestBrandDataWithModel:model];
        }else{
            MoreBrandModel *model = self.transmitArray[indexPath.row];
            _downCell.lab.text = model.catname;
            self.serialNumber = 6;
            self.cat_id = model.catson_id;
          
            [self loadData];
           // [self requestMoreBrandData:model];
        }
      
         self.isSelectViewApperar = NO;
        [self.dropDownView removeFromSuperview];
        self.isSelectViewApperar = NO;
        [self selectSetBtnImage:self.dropDownMenu.oneBtn andImageName:@"箭头向下"];
        [self selectSetBtnImage:self.dropDownMenu.threeBtn andImageName:@"箭头向下"];
        [self selectSetBtnImage:self.dropDownMenu.fourBtn andImageName:@"箭头向下"];
        
           }
    
   }

#pragma mark - tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.modelArr.count == 0) {
        return  0;
    }
    HomeShopListModel *model = self.modelArr[indexPath.row];
   
    [cell setValueWithMode:model];
  
    cell.carBtnClicked = ^(NSInteger index){
        if (index == 1720) {
            NSLog(@"购物车要出来了");
      
           
        
        }
        
    };
   
    return cell;
   }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120 *kHeightScale;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    HomeShopListModel*model = self.modelArr[indexPath.row];
    UserInfo *userInfo = [UserInfo currentAccount];
    NSDictionary *param = @{@"good_id":model.good_id,@"user_id":userInfo.user_id};
    [self requestGoodDetaiDataWith:param andModel:model];
    
    
}
#pragma mark - searchBar代理方法

// 文字改变的时候进行搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.serialNumber = 2;
    self.searchStr = searchText;
    [self loadData];
    [searchBar resignFirstResponder];
}
#pragma mark - 点击移除事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.searchBar resignFirstResponder];
//    [UIView animateWithDuration:0.5 animations:^{
//        // 购物车视图消失
//      
//        CGRect  rect = self.bagView.frame;
//        rect.origin.x = KScreenW;
//        self.bagView.frame = rect;
//        
//    } completion:^(BOOL finished) {
//     
//    }];
    
}

#pragma mark - 点击更多时候请求数据
- (void)requestMoreBrandData:(MoreBrandModel *)model
{
    UserInfo *userInfo = [UserInfo currentAccount];
    NSString *url = [NSString stringWithFormat:@"%@api/goodsclass.php",baseUrl];
    NSDictionary *params = @{@"soncat_id":model.catson_id,@"user_id":userInfo.user_id,@"tpagesize":@"100"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"筛选更多品牌请求数据成功%@",responseObject);
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *dataArray = returnDic[@"data"];
        NSString *msg = responseObject[@"err_msg"];
        
        if ([msg isEqualToString:@"fail"]) {
            
            // 当请求失败的时候直接返回
            NSLog(@"筛选更多品牌请求失败err_msg = fail");
            return ;
            
        }
        // 判断当有数据的时候展示
        // 清空数据源
        [self.modelArr removeAllObjects];
        for (NSDictionary *dic in dataArray) {
            
            HomeShopListModel *model = [[HomeShopListModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"名字%@",model.name);
            [self.modelArr addObject:model];
            
        }
        
        [self.dropDownView removeFromSuperview];
        [self.tableView reloadData];
        
    } enError:^(NSError *error) {
        NSLog(@"筛选品牌请求数据失败%@",error);
    }];
    
    

}
#pragma makr - 点击品牌请求数据
- (void)requestBrandDataWithModel:(BrandModel *)model
{
    UserInfo *userInfo = [UserInfo currentAccount];
    NSString *url = [NSString stringWithFormat:@"%@api/goodsclass.php",baseUrl];
    NSDictionary *params = @{@"brand_id":model.brand_id,@"user_id":userInfo.user_id,@"tpagesize":@"100"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"筛选品牌请求数据成功%@",responseObject);
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
    
        NSString *msg = responseObject[@"err_msg"];
        
        if ([msg isEqualToString:@"fail"]) {
            
            // 当请求失败的时候直接返回
            NSLog(@"筛选品牌请求失败err_msg = fail");
            return ;
            
        }
        // 判断当有数据的时候展示
        // 清空数据源
        [self.modelArr removeAllObjects];
   
        
        [self.dropDownView removeFromSuperview];
        [self.tableView reloadData];
        
    } enError:^(NSError *error) {
        NSLog(@"筛选品牌请求数据失败%@",error);
    }];
    
    
}

#pragma mark - 请求商品详情数据
- (void)requestGoodDetaiDataWith:(NSDictionary *)params andModel:(HomeShopListModel*)model
{
        // 请求详情数据
    NSString *url = [NSString stringWithFormat:@"%@api/gooddetailclass.php",baseUrl];

    [YNTNetworkManager  requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"请求详情数据成功");
        /** 
         is_attr
         
         0  没有属性
         1 组合属性
        2 多属性合一
         
         */
        NSString *is_attr = [NSString stringWithFormat:@"%@",responseObject[@"goods"][@"is_attr"]];
        NSString *isfavorite = [NSString stringWithFormat:@"%@",responseObject[@"goods"][@"isfavorite"]];
        if ([is_attr isEqualToString:@"0"]) {
            // 无属性
            ShopGoodDetailNoViewController *shopDetaiNoVC = [[ShopGoodDetailNoViewController alloc]init];
            shopDetaiNoVC.dataDic = responseObject;
            shopDetaiNoVC.good_id = model.good_id;
            shopDetaiNoVC.isfavorite = isfavorite;
            [self.navigationController pushViewController:shopDetaiNoVC animated:YES];
        }
        if ([is_attr isEqualToString:@"1"]) {
            //多属性
           ShopGooodDetailMoreViewController *shopGoodDetailVC = [[ShopGooodDetailMoreViewController alloc]init];
            
            shopGoodDetailVC.good_id = model.good_id;
            shopGoodDetailVC.picUrl = model.cover_img;
            shopGoodDetailVC.dataDic = responseObject;
            shopGoodDetailVC.isfavorite = isfavorite;
            [self.navigationController pushViewController:shopGoodDetailVC animated:YES];
        }
        if ([is_attr isEqualToString:@"2"]) {
            // 多属性合一
            ShopGoodDetailOneController *shopDetaiOneVC = [[ShopGoodDetailOneController alloc]init];
            shopDetaiOneVC.good_id = model.good_id;
            shopDetaiOneVC.dataDic = responseObject;
            shopDetaiOneVC.isfavorite = isfavorite;
            [self.navigationController pushViewController:shopDetaiOneVC animated:YES];
        }

        
        
    } enError:^(NSError *error) {
          NSLog(@"请求详情数据失败");
    }];
  
}

@end
