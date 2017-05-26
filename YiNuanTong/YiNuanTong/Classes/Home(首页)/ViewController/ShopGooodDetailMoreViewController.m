//
//  ShopGooodDetailMoreViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "ShopGooodDetailMoreViewController.h"
#import "ShopGoodDetailOneController.h"
#import "ShopGoodDetailNoViewController.h"
#import "YNTUITools.h"
#import "SingLeton.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "GoodsDetailTitleCell.h"
#import "GoodDetailSizeCell.h"
#import "GoodDetailBtnView.h"
#import "YNTUITools.h"
#import "YNTNetworkManager.h"
#import "HomeGoodDetailModel.h"
#import "BrandModel.h"
#import <WebKit/WebKit.h>
#import "HomeGoodsDetailSizeModel.h"
#import "GFChooseMoreView.h"
#import "HomeShopListDetailModel.h"
#import "HomeShopListSizeModel.h"
#import "UIImageView+WebCache.h"
#import "OrderConfirmViewController.h"
#import "GoodDetaiParamsCell.h"
#import "HomeGoodDetailRecommandModel.h"
#import "GoodDetailAttrtypeModel.h"
#import "HomeGoodDetailParamsView.h"
#import "YNTShopingCarViewController.h"

@interface ShopGooodDetailMoreViewController ()<UITableViewDelegate,UITableViewDataSource,GFChooseMoreViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
/**导航栏上的线*/
@property (nonatomic,strong) UILabel  *navLineLab;
/**导航栏上的选中按钮*/
@property (nonatomic,strong) UIButton *navSelectBtn;
/**规格参数model*/
@property (nonatomic,strong) NSMutableArray *detailSizeParamArray;
/**推荐商品*/
@property (nonatomic,strong) NSMutableArray *recommandModelArray;
/**存放图片数据*/
@property (nonatomic,strong) NSMutableArray  * picsArray;
/**数据模型*/
@property (nonatomic,strong) HomeShopListDetailModel  * model;
/**规格(加入购物车的时候要用)*/
@property (nonatomic,copy) NSString *goodSize;
/**huo_id*/
@property (nonatomic,copy) NSString *huo_id;
/**用于存放被选中的model*/
@property (nonatomic,strong) NSMutableArray *titleSelectModelArr;
/**加入购物车的数量*/
@property (nonatomic,copy) NSString *shoopCarNum;
/**webView*/
@property (nonatomic,strong) UIWebView*webView;
/**加入或收藏的商品id*/
@property (nonatomic,strong) NSString  * storeAndAddGood_id;
/**加入购物车的数量*/
@property (nonatomic,assign) NSInteger  shoppingGoodsNum;
/**网页的高度*/
@property (nonatomic,assign) CGFloat  webHeight;
/**尾视图*/
@property (nonatomic,strong)  UIView *bigView ;
/**html文本*/
@property (nonatomic,strong) UITextView*htmlLab;
/**用于决定是否要取消收藏*/
@property (nonatomic,strong) NSString  *isCancelStroe;
// 弹出视图
@property (nonatomic,strong) GFChooseMoreView *chooseView;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSMutableDictionary *sizeDic;
/**点击按钮后是否执行*/
@property (nonatomic,assign) BOOL isComeOn;
/**层级*/
@property (nonatomic,copy) NSString *cengji;
/**价格区间*/
@property (nonatomic,copy) NSString *jiagequjian;
// 为chooseView赋值
@property (nonatomic,strong) NSMutableArray *chooseDataArr;
/**详情数据*/
@property (nonatomic,strong) NSMutableDictionary *detailDataDic;
/**决断是否有多属性*/
@property (nonatomic,copy) NSString *is_attr;
/**GFChooseOneView图片路径*/
@property (nonatomic,copy) NSString *GFChoosePicUrl;
/**GFChooseOneView商品名*/
@property (nonatomic,copy) NSString *GFGoodName;
/**GFChooseOneView图片价格*/
@property (nonatomic,copy) NSString *GFGoodPrice;
/**是否是立即购买*/
@property (nonatomic,assign) BOOL isImmedateShopCar;
/** 一级规格尺寸数据 */
@property (nonatomic,strong) NSMutableArray *sizeDataOneArr;
/** 二级规格尺寸 */
@property (nonatomic,strong) NSMutableArray *sizeDataTwoArr;
/** 三级规格尺寸 */
@property (nonatomic,strong) NSMutableArray *sizeDataThreeArr;
/**四级规格尺寸*/
@property (nonatomic,strong) NSMutableArray * sizeDataFourArr;
/** 五级规格尺寸 */
@property (nonatomic,strong) NSMutableArray *sizeDataFiveArr;
/**类型名字*/
@property (nonatomic,strong) NSMutableArray *attrtypeDataArr;
@end
static NSString *goodDetailCell = @"goodDetailCell";
static NSString *goodSizeCell = @"goodSizeCell";
static NSString *goodPramsCell = @"goodParamsCell";
@implementation ShopGooodDetailMoreViewController
#pragma mark - 懒加载
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
- (NSMutableArray *)sizeDataFiveArr
{
    if (!_sizeDataFiveArr) {
        self.sizeDataFiveArr = [[NSMutableArray alloc]init];
    }
    return _sizeDataFiveArr;
    
}

/** 获取轮播图数据源 */
- (NSMutableArray *)picsArray
{
    if (!_picsArray) {
        self.picsArray = [[NSMutableArray alloc]init];
    }
    return _picsArray;
}
/** 获取推荐商品 */
- (NSMutableArray *)recommandModelArray
{
    if (!_recommandModelArray) {
        self.recommandModelArray = [[NSMutableArray alloc]init];
    }
    return _recommandModelArray;
}

/** 获取规格参数 */
- (NSMutableArray *)detailSizeParamArray
{
    if (!_detailSizeParamArray) {
        self.detailSizeParamArray = [[NSMutableArray alloc]init];
    }
    return _detailSizeParamArray;
}
/** 为chooseView赋值 */
- (NSMutableArray *)chooseDataArr
{
    if (!_chooseDataArr) {
        self.chooseDataArr = [[NSMutableArray alloc]init];
    }
    return _chooseDataArr;
}
#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self requestGoodDetaiDataWith];
    // 加载数据
    [self loadSizeData];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多属性合一";
    self.view.backgroundColor = [UIColor whiteColor];
    self.goodSize =@"";
    self.shoopCarNum = @"1";
    self.cengji = @"";
    self.isCancelStroe = self.isfavorite;
    [self setUpNavView];
    // 加载子视图
    [self setUpChildrenViews];
    [self setUpBottomViews];
    
}

#pragma mark - 购物车按钮的点击事件

- (void)rightBarButtonItemAction:(UIButton *)sender
{

    NSLog(@"点击的是右边items");
    YNTShopingCarViewController *shopingVC = [[YNTShopingCarViewController alloc]init];
    shopingVC.isFromdetail = @"1";
    [self.navigationController pushViewController:shopingVC animated:YES];
    
}
#pragma mark 自定义视图
#pragma mark - 请求规格数据
- (void)loadSizeData
{
    
    // 请求详情数据
    NSString *url = [NSString stringWithFormat:@"%@api/goodattrclass.php",baseUrl];
    NSDictionary *param = @{@"good_id":self.good_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {

        self.GFGoodPrice = responseObject[@"jiafanwei"];
        NSDictionary *dataDic= responseObject[@"data"];

        // 清空数据源
        [self.sizeDataOneArr removeAllObjects];
        [self.sizeDataTwoArr removeAllObjects];
        [self.sizeDataThreeArr removeAllObjects];
        [self.sizeDataFourArr removeAllObjects];
        [self.chooseDataArr removeAllObjects];
        [self.attrtypeDataArr removeAllObjects];
        
        NSArray *attrtypeArr = responseObject[@"attrtype"];
        
        for (NSDictionary *dic in attrtypeArr) {
            GoodDetailAttrtypeModel *model = [[GoodDetailAttrtypeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            [self.attrtypeDataArr addObject:model];
        }
        NSArray *arr0 = dataDic[@"a0"];
        NSArray *arr1 = dataDic[@"a1"];
        NSArray *arr2= dataDic[@"a2"];
        NSArray *arr3 = dataDic[@"a3"];
         NSArray *arr4 = dataDic[@"a4"];
        for (NSDictionary *dic in arr0) {
            HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model.name);
            model.isHave = NO;
            [self.sizeDataOneArr addObject:model];
            
        }
        for (NSDictionary *dic in arr1) {
            HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model.name);
              model.isHave = NO;
            [self.sizeDataTwoArr addObject:model];
            
        }

        for (NSDictionary *dic in arr2) {
            HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model.name);
              model.isHave = NO;
            [self.sizeDataThreeArr addObject:model];
            
        }

        for (NSDictionary *dic in arr3) {
            HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model.name);
              model.isHave = NO;
            [self.sizeDataFourArr addObject:model];
            
        }

        for (NSDictionary *dic in arr4) {
            HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model.name);
            [self.chooseDataArr addObject:model];
            
        }

        
        [self loadData];
    } enError:^(NSError *error) {
        NSLog(@"商品详情数据请求失败%@",error);
    }];
    
    
}

/**
 *加载数据
 */
- (void)loadData
{
    // 请求详情数据
    NSDictionary *goodDic = self.dataDic[@"goods"];
    //图片路径
    self.GFChoosePicUrl = goodDic[@"full_cover_img"];
    // 图片名字
    self.GFGoodName = goodDic[@"name"];
    self.detailDataDic =self.dataDic[@"goods"];
    self.cengji = goodDic[@"cengji"];
    NSLog(@"%@",self.cengji);
    self.is_attr = goodDic[@"is_attr"];
    self.model = [[HomeShopListDetailModel alloc]init];
    [_model setValuesForKeysWithDictionary:goodDic];
    // 取轮播图
    // 清空数据源
    [self.picsArray removeAllObjects];
    for (NSDictionary *dic in _model.xiangce) {
        [self.picsArray addObject:dic[@"normal_img"]];
    }
    
    [self setUpChildrenViews];
    
    // 获取规格参数
    // 清空数据源
    [self.detailSizeParamArray removeAllObjects];
    NSArray *arr =self.detailDataDic[@"tianxie"];
    for (NSDictionary *dic in arr) {
        HomeGoodsDetailSizeModel *model = [[HomeGoodsDetailSizeModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.detailSizeParamArray addObject:model];
    }
    
    // 获取推荐商品数据
    // 清空数据源
    [self.recommandModelArray removeAllObjects];
    NSMutableArray *recArr = self.dataDic[@"recgoods"];
    for (NSDictionary *dic in recArr) {
        
        HomeGoodDetailRecommandModel *recModle = [[HomeGoodDetailRecommandModel alloc]init];
        [recModle setValuesForKeysWithDictionary:dic];
        [self.recommandModelArray addObject:recModle];
    }
    
    
    if (self.tableView) {
        [self.tableView reloadData];
    }else{
        [self setUpChildrenViews];
    }
    
    
}

#pragma mark - 加载视图
- (void)setUpNavView
{
    // 背景视图
    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW - 100, 44)];
    
    self.navigationItem.titleView = bagView;
    // 商品按钮
    UIButton *goodBtn = [YNTUITools createButton:CGRectMake(60, 0, 40, 44) bgColor:nil title:@"商品" titleColor:[UIColor whiteColor] action:@selector(goodBtnAction:) vc:self];
    [goodBtn setTitleColor:RGBA(219, 112, 0, 1) forState:UIControlStateNormal];
    [bagView addSubview:goodBtn];
    // 默认为goodBtn
    self.navSelectBtn = goodBtn;
    // 详情按钮
    UIButton *detailBtn = [YNTUITools createButton:CGRectMake(120, 0, 40, 44) bgColor:nil title:@"详情" titleColor:[UIColor whiteColor] action:@selector(detailBtnAction:) vc:self];
    [bagView addSubview:detailBtn];
    // 创建线line
    self.navLineLab = [[UILabel alloc]initWithFrame:CGRectMake(60,42, 40, 2)];
    self.navLineLab.backgroundColor = RGBA(219, 112, 0, 1);
    [bagView addSubview:self.navLineLab];
}
// 点击商品按钮的回调
- (void)goodBtnAction:(UIButton *)sender
{
    [sender setTitleColor:RGBA(219, 112, 0, 1) forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        [self.navSelectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        CGRect rect  = self.navLineLab.frame;
        rect.origin.x = 60;
        self.navLineLab.frame = rect;
    }];
    self.navSelectBtn = sender;
    self.tableView.contentOffset = CGPointMake(0, 0);
}
// 点击详情按钮的回调
- (void)detailBtnAction:(UIButton *)sender
{
    self.tableView.contentOffset = CGPointMake(0, 900);
    [sender setTitleColor:RGBA(219, 112, 0, 1) forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        [self.navSelectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        CGRect rect  = self.navLineLab.frame;
        rect.origin.x = 120;
        self.navLineLab.frame = rect;
    }];
    self.navSelectBtn = sender;
}

/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, kScreenH-50*kHeightScale - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册cell
    [self.tableView registerClass:[GoodsDetailTitleCell class] forCellReuseIdentifier:goodDetailCell];
    [self.tableView registerClass:[GoodDetailSizeCell class] forCellReuseIdentifier:goodSizeCell];
    [self.tableView registerClass:[GoodDetaiParamsCell class] forCellReuseIdentifier:goodPramsCell];
    [self.view addSubview:self.tableView];
    // 创建轮播图
    SDCycleScrollView *cycleScroollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, KScreenW, 335*kHeightScale) imageURLStringsGroup:self.picsArray];
    self.tableView.tableHeaderView = cycleScroollView;
    // 创建尾部视图
    UIView *footerView = [self setUpFooterVIews];
    self.tableView.tableFooterView = footerView;
}
/**
 *创建尾部视图
 */
- (UIView *)setUpFooterVIews
{
    self.bigView = [[UIView alloc]initWithFrame:CGRectMake(0,0, KScreenW, 500 )];
    //加载默认数据
    self.webHeight = 0;
    NSString *width = @"";
    if (KScreenW == 375) {
        width = @"347px";
    }
    if (KScreenW == 320) {
        width = @"295px";
    }
    if (KScreenW == 414) {
        width = @"385px";
    }
    
    NSString *str  = [NSString stringWithFormat:@"<style>*{margin:0;padding:0;}img{width:%@;}</style>%@",width,self.detailDataDic[@"details"]];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[str  dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    self.htmlLab = [[UITextView alloc]initWithFrame:CGRectMake(10*kWidthScale, 10 *kHeightScale, KScreenW - 20 *kWidthScale, 500)];
    self.htmlLab.attributedText = attributedString;
    [_bigView addSubview:self.htmlLab];

    return _bigView;
}
/**
 *创建底部视图
 */
- (void)setUpBottomViews
{
    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - 50, KScreenW, 50)];
    bagView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bagView];
    // 创建收藏按钮
    UIButton *stroeBtn = [YNTUITools createCustomButton:CGRectMake(14*kWidthScale, 6 *kHeightScale, 36 *kWidthScale, 35 *kHeightScale) bgColor:RGBA(251, 251, 251, 1) title:nil titleColor:nil image:@"" action:@selector(storeBtnAction:) vc:self];
    
    
    if ([self.isfavorite isEqualToString:@"1"]) {
        [stroeBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
    }else{
        [stroeBtn setImage:[UIImage imageNamed:@"no_collection"] forState:UIControlStateNormal];
    }
    [bagView addSubview:stroeBtn];
    
    // 创建线
    UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(60*kWidthScale, 6*kHeightScale, 1*kWidthScale, 36 *kHeightScale)];
    lineLab.backgroundColor = [UIColor grayColor];

    // 创建客服按钮
    UIButton *customerServiceBtn =  [YNTUITools createCustomButton:CGRectMake(65*kWidthScale, 6 *kHeightScale, 28 *kWidthScale, 36 *kHeightScale) bgColor:RGBA(251, 251, 251, 1) title:nil titleColor:nil image:@"customer_service" action:@selector(customerServiceBtnAction:) vc:self];
    [bagView addSubview:customerServiceBtn];
    
    // 创建客服按钮
    UIButton *goShopVCBtn =  [YNTUITools createCustomButton:CGRectMake(110*kWidthScale, 6 *kHeightScale, 36 *kWidthScale, 36 *kHeightScale) bgColor:RGBA(251, 251, 251, 1) title:nil titleColor:nil image:@"goods-details-receipt" action:@selector(goShopVCBtn:) vc:self];
    [bagView addSubview:goShopVCBtn];

    // 创建立刻购买
    UIButton*imdedateBtn = [YNTUITools createButton:CGRectMake(154 *kWidthScale, 0, (KScreenW - 154 *kWidthScale)/2 , 50)  bgColor:CGRBlue title:@"立刻购买" titleColor:[UIColor whiteColor] action:@selector(imdedateAction:) vc:self];
    [bagView addSubview:imdedateBtn];
    
    // 创建加入购物车按钮
    UIButton*carBtn = [YNTUITools createButton:CGRectMake(KScreenW / 2 +78*kWidthScale, 0, (KScreenW - 154 *kWidthScale)/2, 50)  bgColor:CGRBlue title:@"加入进货单" titleColor:[UIColor whiteColor] action:@selector(carBtnAction:) vc:self];
    [bagView addSubview:carBtn];
}
#pragma mark- 底部按钮的点击事件
- (void)storeBtnAction:(UIButton *)sender
{
    UserInfo *userInfo = [UserInfo currentAccount];
    if ([self.isfavorite isEqualToString:@"1"]) {
        
        NSString *url = [NSString stringWithFormat:@"%@api/goods_favorite.php",baseUrl];
        NSDictionary *param = @{@"user_id":userInfo.user_id,@"good_id":self.good_id, @"act":@"del"};
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
            NSLog(@"移除收藏夹数据成功%@",responseObject);
            NSString *msg = responseObject[@"msg"];
            if ([msg isEqualToString:@"success"]) {
                [GFProgressHUD showSuccess:responseObject[@"info"]];
                
            }else{
                [GFProgressHUD showFailure:responseObject[@"info"]];
            }
            
            [self requestGoodDetaiDataWith];
        } enError:^(NSError *error) {
            NSLog(@"移除收藏夹数据失败%@",error);
        }];
        
        
    }else{
        
        NSString *url = [NSString stringWithFormat:@"%@api/goods_favorite.php",baseUrl];
        NSDictionary *param = @{@"user_id":userInfo.user_id,@"good_id":self.good_id,@"act":@"add"};
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
            NSLog(@"添加收藏夹数据成功%@",responseObject);
            NSString *msg = responseObject[@"msg"];
            if ([msg isEqualToString:@"success"]) {
                [GFProgressHUD showSuccess:responseObject[@"info"]];
            }else{
                [GFProgressHUD showFailure:responseObject[@"info"]];
            }
            [self requestGoodDetaiDataWith];
            NSLog(@"收藏按钮的点击");
        } enError:^(NSError *error) {
            NSLog(@"添加收藏夹数据失败%@",error);
        }];
        
    }
    
    if ([self.isfavorite isEqualToString:@"1"]) {
        [sender setImage:[UIImage imageNamed:@"no_collection"] forState:UIControlStateNormal];
        
    }else{
        [sender setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
        
    }
    
    
}
- (void)customerServiceBtnAction:(UIButton *)sender
{
    NSLog(@"这是客服");
    // 点击拨打电话
    UIWebView *webView = [[UIWebView alloc]init];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://4007713123"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (void)goShopVCBtn:(UIButton *)sender
{
    YNTShopingCarViewController *shopCarVC = [[YNTShopingCarViewController alloc]init];
    shopCarVC.isFromdetail = @"1";
    [self.navigationController pushViewController:shopCarVC animated:YES];
}
// 立刻购买点击事件
- (void)imdedateAction:(UIButton *)sender
{
    self.chooseView = [[GFChooseMoreView alloc]initWithFrame:CGRectMake(0, kScreenH, KScreenW, kScreenH)];
    // 为限制数量赋值
    [self.chooseView  setActivityNumWithStr:self.activitynum andOrderCout:self.order_count];
    // 当限制商品数量为0时只能购买一次
    if ([self.activitynum isEqualToString:@"0"]) {
        // 此商品只能购买一次
        [GFProgressHUD showInfoMsg:@"此商品只能购买一次!"];
         self.isImmedateShopCar= NO;
        return ;
    }
    

    // 当限制商品数量大于0时,对购买次数限制条件进行判断
    if ([self.activitynum  integerValue] >0) {
        
        if (self.order_count >0) {
            // 购买次数大于0 ,说明不是第一次购买
            // 此商品只能购买一次
            [GFProgressHUD showInfoMsg:@"此商品只能购买一次!"];

            return;
        }else{
                       //  第1次购买
                      if (self.cart_count >0) {
                            //此时进货单中有数据
                            [GFProgressHUD showInfoMsg:@"请在进货单中购买!"];
                          return;
                        }else{
                            // 此时进货单中无数据
                            self.isImmedateShopCar= YES;
                            // 此时不限制数量
                            _chooseView.totallMoneyLab.text =@"¥0";
                            self.chooseView.delegate = self;
                            [self.view addSubview:_chooseView];
                            //为多级赋值
                            NSMutableDictionary *params1 = @{@"a0":self.sizeDataOneArr,@"a1":self.sizeDataTwoArr,@"a2":self.sizeDataThreeArr,@"a3":self.sizeDataFourArr,@"a4":self.attrtypeDataArr}.mutableCopy;
                            [_chooseView setGFChooseMoreViewValueWithParams:params1 andWithAttrtypeArr:self.attrtypeDataArr];
                            // 为规格赋值
                            NSMutableDictionary *params2 = @{@"url":self.GFChoosePicUrl,@"price":self.GFGoodPrice,@"name":self.GFGoodName}.mutableCopy;
                            [_chooseView setGFChooseMoreViewValueWithModelArray:self.chooseDataArr andParams:params2];
                        }
            
                    }
    
 
    }
    // 当数量为-1时,此时不限制购买
    if ([self.activitynum isEqualToString:@"-1"]) {
        self.isImmedateShopCar= YES;
        // 此时不限制数量
        _chooseView.totallMoneyLab.text =@"¥0";
        self.chooseView.delegate = self;
        [self.view addSubview:_chooseView];
        //为多级赋值
        NSMutableDictionary *params1 = @{@"a0":self.sizeDataOneArr,@"a1":self.sizeDataTwoArr,@"a2":self.sizeDataThreeArr,@"a3":self.sizeDataFourArr,@"a4":self.attrtypeDataArr}.mutableCopy;
        [_chooseView setGFChooseMoreViewValueWithParams:params1 andWithAttrtypeArr:self.attrtypeDataArr];
        // 为规格赋值
        NSMutableDictionary *params2 = @{@"url":self.GFChoosePicUrl,@"price":self.GFGoodPrice,@"name":self.GFGoodName}.mutableCopy;
         [_chooseView setGFChooseMoreViewValueWithModelArray:self.chooseDataArr andParams:params2];
    }
   
   
    
    
    [UIView animateWithDuration: 0.35 animations: ^{
        _chooseView.frame =CGRectMake(0, 0, KScreenW, kScreenH);
    } completion: nil];
 


}
- (void)carBtnAction:(UIButton *)sender
{
    
    self.chooseView = [[GFChooseMoreView alloc]initWithFrame:CGRectMake(0, kScreenH, KScreenW, kScreenH)];
    self.chooseView.delegate = self;
    // 为限制数量赋值
 [self.chooseView  setActivityNumWithStr:self.activitynum andOrderCout:self.order_count];
    // 等于0时 只能购买一次
    if ([self.activitynum isEqualToString:@"0"]) {
        // 此商品只能购买一次
        [GFProgressHUD showInfoMsg:@"此商品只能购买一次!"];
        return ;
    }
    
    
    // 如果大于0时,对购买次数进行判断
    if ([self.activitynum integerValue] > 0) {
        
        if (self.order_count >0) {
        //非第一次购买
            [GFProgressHUD showInfoMsg:@"此商品只能购买一次!"];
              return;
        }else{
            self.isImmedateShopCar = NO;
            _chooseView.totallMoneyLab.text =@"¥0";
            // 为多级赋值
            NSMutableDictionary *params1 = @{@"a0":self.sizeDataOneArr,@"a1":self.sizeDataTwoArr,@"a2":self.sizeDataThreeArr,@"a3":self.sizeDataFourArr,@"a4":self.attrtypeDataArr}.mutableCopy;
            [_chooseView setGFChooseMoreViewValueWithParams:params1 andWithAttrtypeArr:self.attrtypeDataArr];
            // 为规格赋值
            NSMutableDictionary *params2 = @{@"url":self.GFChoosePicUrl,@"price":self.GFGoodPrice,@"name":self.GFGoodName}.mutableCopy;
            [_chooseView setGFChooseMoreViewValueWithModelArray:self.chooseDataArr andParams:params2
             ];
            

        }
        
        
    }
    


   
    // 等于-1的时候无限制
    if ([self.activitynum isEqualToString:@"-1"]) {
        
          self.isImmedateShopCar = NO;
        _chooseView.totallMoneyLab.text =@"¥0";
        // 为多级赋值
        NSMutableDictionary *params1 = @{@"a0":self.sizeDataOneArr,@"a1":self.sizeDataTwoArr,@"a2":self.sizeDataThreeArr,@"a3":self.sizeDataFourArr,@"a4":self.attrtypeDataArr}.mutableCopy;
        [_chooseView setGFChooseMoreViewValueWithParams:params1 andWithAttrtypeArr:self.attrtypeDataArr];
        // 为规格赋值
        NSMutableDictionary *params2 = @{@"url":self.GFChoosePicUrl,@"price":self.GFGoodPrice,@"name":self.GFGoodName}.mutableCopy;
        [_chooseView setGFChooseMoreViewValueWithModelArray:self.chooseDataArr andParams:params2
         ];
        

       
    }
    
    
     [self.view addSubview:_chooseView];
    
    [UIView animateWithDuration: 0.35 animations: ^{
        _chooseView.frame =CGRectMake(0, 0, KScreenW, kScreenH);
    } completion: nil];
    NSLog(@"我要加入购物车了");
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        GoodsDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:goodDetailCell forIndexPath:indexPath];
        
        [cell setValueWithModel:self.model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if (indexPath.row == 1) {
        GoodDetailSizeCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSizeCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    if (indexPath.row == 2) {
        GoodDetaiParamsCell*cell = [tableView dequeueReusableCellWithIdentifier:goodPramsCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSInteger index = self.detailSizeParamArray.count;
        
        if (index == 1) {
            HomeGoodsDetailSizeModel *model1 = self.detailSizeParamArray[0];
            
            cell.materialLab.text  = model1.aname;
            cell.materialContentLab.text = model1.avalue;
        }
        if (index == 2) {
            HomeGoodsDetailSizeModel *model1 = self.detailSizeParamArray[0];
            HomeGoodsDetailSizeModel *model2 = self.detailSizeParamArray[1];
            cell.materialLab.text  = model1.aname;
            cell.materialContentLab.text = model1.avalue;
            cell.originLab.text  = model2.aname;
            cell.originlContentLab.text = model2.avalue;
        }
        
        if (index>3 || index== 3) {
            HomeGoodsDetailSizeModel *model1 = self.detailSizeParamArray[0];
            HomeGoodsDetailSizeModel *model2 = self.detailSizeParamArray[1];
            HomeGoodsDetailSizeModel *model3 = self.detailSizeParamArray[2];
            cell.materialLab.text  = model1.aname;
            cell.materialContentLab.text = model1.avalue;
            cell.originLab.text  = model2.aname;
            cell.originlContentLab.text = model2.avalue;
            cell.brandLab.text  = model3.aname;
            cell.brandContentLab.text = model3.avalue;
        }
        // 创建推荐商品
        [cell setValueWithModelArray:self.recommandModelArray];
        cell.tapBtnActionBlock = ^(HomeGoodDetailRecommandModel *model){
            self.good_id = model.good_id;
            UserInfo *userInfo = [UserInfo currentAccount];
            NSDictionary *param = @{@"good_id":model.good_id,@"user_id":userInfo.user_id};
            [self requestGoodDetaiDataWith:param andString:model.good_id];

        };
        
        return cell;
    }
    
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 155;
    }
    if (indexPath.row == 1) {
        return 60 *kHeightScale;
    }
    if (indexPath.row == 2) {
        return 355 *kHeightScale;
    }
    
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 2) {
        if (self.detailSizeParamArray.count > 0) {
            
            // 大于0时才执行
            HomeGoodDetailParamsView *view = [[HomeGoodDetailParamsView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, kScreenH)];
            __weak typeof(view)weakSelf = view;
            [view setValueWithModelArray:self.detailSizeParamArray];
            view.closeBtnBlock = ^(){
                NSLog(@"关闭回调");
                [UIView animateWithDuration:0.2 animations:^{
                    CGRect rect = weakSelf.frame;
                    rect.origin.y = kScreenH;
                    weakSelf.frame = rect;
                }];
            };
            [self.view addSubview:view];
        }
     
    }
    
    
    if (indexPath.row == 1) {
        self.chooseView = [[GFChooseMoreView alloc]initWithFrame:CGRectMake(0, kScreenH, KScreenW, kScreenH)];
        _chooseView.totallMoneyLab.text =@"¥0";
        self.chooseView.delegate = self;
               [self.view addSubview:_chooseView];
        // 为限制数量赋值
      [self.chooseView  setActivityNumWithStr:self.activitynum andOrderCout:self.order_count];
        
        
        // 等于0时 只能购买一次
        if ([self.activitynum isEqualToString:@"0"]) {
            // 此商品只能购买一次
            [GFProgressHUD showInfoMsg:@"此商品只能购买一次!"];
            return ;
        }
        
        
        // 如果大于0时,对购买次数进行判断
        if ([self.activitynum integerValue] > 0) {
            
            if (self.order_count >0) {
                //非第一次购买
                [GFProgressHUD showInfoMsg:@"此商品只能购买一次!"];
                return;
            }else{
                // 第一次购买
                _chooseView.totallMoneyLab.text =@"¥0";
                // 为多级赋值
                NSMutableDictionary *params1 = @{@"a0":self.sizeDataOneArr,@"a1":self.sizeDataTwoArr,@"a2":self.sizeDataThreeArr,@"a3":self.sizeDataFourArr,@"a4":self.attrtypeDataArr}.mutableCopy;
                [_chooseView setGFChooseMoreViewValueWithParams:params1 andWithAttrtypeArr:self.attrtypeDataArr];
                // 为规格赋值
                NSMutableDictionary *params2 = @{@"url":self.GFChoosePicUrl,@"price":self.GFGoodPrice,@"name":self.GFGoodName}.mutableCopy;
                [_chooseView setGFChooseMoreViewValueWithModelArray:self.chooseDataArr andParams:params2
                 ];
                
                
            }
            
            
        }
        
     
        
        [self.view addSubview:_chooseView];
        // 等于-1的时候无限制
        if ([self.activitynum isEqualToString:@"-1"]) {
            _chooseView.totallMoneyLab.text =@"¥0";
            // 为多级赋值
            NSMutableDictionary *params1 = @{@"a0":self.sizeDataOneArr,@"a1":self.sizeDataTwoArr,@"a2":self.sizeDataThreeArr,@"a3":self.sizeDataFourArr,@"a4":self.attrtypeDataArr}.mutableCopy;
            [_chooseView setGFChooseMoreViewValueWithParams:params1 andWithAttrtypeArr:self.attrtypeDataArr];
            // 为规格赋值
            NSMutableDictionary *params2 = @{@"url":self.GFChoosePicUrl,@"price":self.GFGoodPrice,@"name":self.GFGoodName}.mutableCopy;
            [_chooseView setGFChooseMoreViewValueWithModelArray:self.chooseDataArr andParams:params2
             ];
            
        }
        
        [UIView animateWithDuration: 0.35 animations: ^{
            _chooseView.frame =CGRectMake(0, 0, KScreenW, kScreenH);
        } completion: nil];
        NSLog(@"我要加入购物车了");
    }
}
#pragma mark - 弹出框代理
// 选择回调
- (void)GFChooseMoreViewLine:(NSInteger )LineNumber andWithGoodIDs:(NSString *)good_ids
{
    NSLog(@"点击的是第%ld行 商品id为:%@",LineNumber,good_ids);
    [self requestDetailSizeDataWithGoods_id:good_ids andIndex:LineNumber];
    
}
// 确定按钮点击事件
- (void)GFChooseMoreViewClickConfirmBtnActionWithDic:(NSMutableDictionary *)dic
{
    [self.chooseView removeFromSuperview];
    // 刷新数据
    [self loadSizeData];
    
    NSString *url = [NSString stringWithFormat:@"%@api/addcart.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    
    NSArray *keysArr = dic.allKeys;
    if (keysArr.count == 0) {//当为空时要返回
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"请选择您要加入的商品!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];

        return;
    }
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<keysArr.count; i++) {
        NSString *num = dic[keysArr[i]];
        NSDictionary *dic1 = @{@"good_attid":keysArr[i],@"num":num};
        [dataArray addObject:dic1];
    }
    
    
    // 数组转化为json
    NSData *arrData = [NSJSONSerialization dataWithJSONObject:dataArray options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *dataStr = [[NSString alloc] initWithData:arrData encoding:NSUTF8StringEncoding];
    NSString *directbuy = @"";
    if (self.isImmedateShopCar) {
        directbuy = @"1";
    }else{
        directbuy = @"0";
    }
    // 请求参数
    NSDictionary *params = @{@"good_id":self.good_id,@"user_id":userInfo.user_id,@"data":dataStr,@"is_attr":@"1",@"directbuy":directbuy};
    
    
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
    
        if (self.isImmedateShopCar) {
            NSLog(@"立即购买请求数据成功%@",responseObject);
            OrderConfirmViewController *orderCofirmVC = [[OrderConfirmViewController alloc]init];
            orderCofirmVC.directbuy = @"1";
            [self.navigationController pushViewController:orderCofirmVC animated:YES];
            self.isImmedateShopCar = NO;
            
            // 点击确定的时候刷新数据 为限制数量赋值
            [self requestGoodDetaiDataWith];
        
            
        }else{
         
                [GFProgressHUD showSuccess:responseObject[@"msg"]];
            // 点击确定的时候刷新数据 为限制数量赋值
           [self requestGoodDetaiDataWith];

            NSLog(@"提交购物车请求数据成功%@",responseObject);
        }
    } enError:^(NSError *error) {
        
        
        
    }];
    
    
    
    [UIView animateWithDuration: 0.35 animations: ^{
        self.chooseView.frame =CGRectMake(0, kScreenH, KScreenW, kScreenH);
        
    } completion: nil];
    
    
    
}

// 取消按钮点击事件
- (void)GFChooseMoreViewCancelBtn
{
    // 刷新数据
    [self loadSizeData];
    [UIView animateWithDuration: 0.35 animations: ^{
        self.chooseView.frame =CGRectMake(0, kScreenH, KScreenW, kScreenH);
        
    } completion: nil];
    
}
#pragma mark - 请求商品详情数据
- (void)requestGoodDetaiDataWith
{
    // 请求详情数据
    NSString *url = [NSString stringWithFormat:@"%@api/gooddetailclass.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    NSDictionary *param = @{@"good_id":self.good_id,@"user_id":userInfo.user_id};
    
    [YNTNetworkManager  requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"请求详情数据成功");
        self.isfavorite = [NSString stringWithFormat:@"%@",responseObject[@"goods"][@"isfavorite"]];
        
        self.activitynum = [NSString stringWithFormat:@"%@",responseObject[@"goods"][@"activitynum"]];
        
        self.order_count =[responseObject[@"goods"][@"order_count"]  integerValue] ;
        self.cart_count =[responseObject[@"goods"][@"cart_count"]  integerValue] ;
    } enError:^(NSError *error) {
        NSLog(@"请求详情数据失败");
    }];
    
}
// 请求规格数据
- (void)requestDetailSizeDataWithGoods_id:(NSString *)good_id andIndex:(NSInteger )index
{
    
    
    // 请求详情数据
    UserInfo *userInfo = [UserInfo  currentAccount];
    NSString *url = [NSString stringWithFormat:@"%@api/goodattrclass.php",baseUrl];
    NSDictionary *param = @{@"good_id":self.good_id ,@"user_id":userInfo.user_id,@"xuanze":good_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"商品详情数据请求成功%@",responseObject);
        self.GFGoodPrice = responseObject[@"jiafanwei"];
        NSDictionary *dataDic= responseObject[@"data"];
        
        // 清空数据源
        [self.sizeDataOneArr removeAllObjects];
        [self.sizeDataTwoArr removeAllObjects];
        [self.sizeDataThreeArr removeAllObjects];
        [self.sizeDataFourArr removeAllObjects];
        [self.chooseDataArr removeAllObjects];
        [self.attrtypeDataArr removeAllObjects];
        
        NSArray *attrtypeArr = responseObject[@"attrtype"];
        
        for (NSDictionary *dic in attrtypeArr) {
            GoodDetailAttrtypeModel *model = [[GoodDetailAttrtypeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            [self.attrtypeDataArr addObject:model];
        }
        NSArray *arr0 = dataDic[@"a0"];
        NSArray *arr1 = dataDic[@"a1"];
        NSArray *arr2= dataDic[@"a2"];
        NSArray *arr3 = dataDic[@"a3"];
        NSArray *arr4 = dataDic[@"a4"];
        for (NSDictionary *dic in arr0) {
            HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model.name);
            model.isHave = NO;
            [self.sizeDataOneArr addObject:model];
            
        }
        for (NSDictionary *dic in arr1) {
            HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model.name);
            model.isHave = NO;
            [self.sizeDataTwoArr addObject:model];
            
        }
        
        for (NSDictionary *dic in arr2) {
            HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model.name);
            model.isHave = NO;
            [self.sizeDataThreeArr addObject:model];
            
        }
        
        for (NSDictionary *dic in arr3) {
            HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model.name);
            model.isHave = NO;
            [self.sizeDataFourArr addObject:model];
            
        }
        
        for (NSDictionary *dic in arr4) {
            HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@",model.name);
            [self.chooseDataArr addObject:model];
            
        }
        
        // 为多级赋值
        NSMutableDictionary *params1 = @{@"a0":self.sizeDataOneArr,@"a1":self.sizeDataTwoArr,@"a2":self.sizeDataThreeArr,@"a3":self.sizeDataFourArr,@"a4":self.attrtypeDataArr}.mutableCopy;
        [_chooseView setGFChooseMoreViewValueWithParams:params1 andWithAttrtypeArr:self.attrtypeDataArr andWithIndex:index];
   
        NSMutableDictionary *params2 = @{@"url":self.GFChoosePicUrl,@"price":self.GFGoodPrice,@"name":self.GFGoodName}.mutableCopy;
        [_chooseView setGFChooseMoreViewValueWithModelArray:self.chooseDataArr andParams:params2
         ];
        


    } enError:^(NSError *error) {
        NSLog(@"商品详情数据请求失败%@",error);
    }];
    

}


#pragma mark - 推荐商品请求数据
- (void)requestGoodDetaiDataWith:(NSDictionary *)params andString:(NSString *)modelGood_id
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
            shopDetaiNoVC.good_id = modelGood_id;
            shopDetaiNoVC.isfavorite = isfavorite;
            [self.navigationController pushViewController:shopDetaiNoVC animated:YES];
        }
        if ([is_attr isEqualToString:@"1"]) {
            //多属性
            ShopGooodDetailMoreViewController *shopGoodDetailVC = [[ShopGooodDetailMoreViewController alloc]init];
            
            shopGoodDetailVC.good_id = modelGood_id;
            shopGoodDetailVC.dataDic = responseObject;
            shopGoodDetailVC.isfavorite = isfavorite;
            [self.navigationController pushViewController:shopGoodDetailVC animated:YES];
        }
        if ([is_attr isEqualToString:@"2"]) {
            // 多属性合一
            ShopGoodDetailOneController *shopDetaiOneVC = [[ShopGoodDetailOneController alloc]init];
            shopDetaiOneVC.good_id = modelGood_id;
            shopDetaiOneVC.dataDic = responseObject;
            shopDetaiOneVC.isfavorite = isfavorite;
            [self.navigationController pushViewController:shopDetaiOneVC animated:YES];
        }
        
        
        
    } enError:^(NSError *error) {
        NSLog(@"请求详情数据失败");
    }];
    
}
@end
