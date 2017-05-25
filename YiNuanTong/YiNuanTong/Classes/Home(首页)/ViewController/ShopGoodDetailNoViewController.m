//
//  ShopGoodDetailNoViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "ShopGoodDetailNoViewController.h"
#import "ShopGoodDetailOneController.h"
#import "ShopGooodDetailMoreViewController.h"
#import "YNTUITools.h"
#import "SingLeton.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "GoodsDetailTitleCell.h"
#import "GoodDetailSizeNoCell.h"
#import "GoodDetailBtnView.h"
#import "YNTUITools.h"
#import "YNTNetworkManager.h"
#import "HomeGoodDetailModel.h"
#import "BrandModel.h"
#import <WebKit/WebKit.h>
#import "HomeGoodsDetailSizeModel.h"
#import "HomeShopListDetailModel.h"
#import "HomeShopListSizeModel.h"
#import "UIImageView+WebCache.h"
#import "OrderConfirmViewController.h"
#import "GoodDetaiParamsCell.h"
#import "HomeGoodDetailRecommandModel.h"
#import "HomeGoodDetailParamsView.h"
#import "HomeShopListModel.h"
#import "YNTShopingCarViewController.h"
@interface ShopGoodDetailNoViewController ()<UITableViewDataSource,UITableViewDelegate>

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
/**规格数据*/
@property (nonatomic,strong) NSMutableArray  * brandArray;
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
@end
static NSString *goodDetailCell = @"goodDetailCell";
static NSString *goodSizeCell = @"goodSizeCell";
static NSString *goodPramsCell = @"goodParamsCell";

@implementation ShopGoodDetailNoViewController

#pragma mark - 懒加载
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
#pragma mark - 视图生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.tabBarController.tabBar.hidden = YES;
    // 加载数据
    [self loadData];
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
    self.huo_id = @"";
    self.shoopCarNum = @"1";
    self.cengji = @"";
    self.isCancelStroe = self.isfavorite;
    [self setUpNavView];
  
    [self loadSizeData];
    // 加载子视图
    [self setUpChildrenViews];
    [self setUpBottomViews];
    
    
    
}

#pragma mark - 购物车按钮的点击事件

- (void)rightBarButtonItemAction:(UIButton *)sender
{
    NSLog(@"点击的是右边items");
    YNTShopingCarViewController *shopingVC = [[YNTShopingCarViewController alloc]init];
    
    [self.navigationController pushViewController:shopingVC animated:YES];
    
}
#pragma mark 自定义视图
/**
 *加载数据
 */
- (void)loadData
{
     UserInfo *userInfo = [UserInfo currentAccount];
       NSDictionary *param = @{@"good_id":self.good_id,@"user_id":userInfo.user_id};
    // 请求详情数据
    NSString *url = [NSString stringWithFormat:@"%@api/gooddetailclass.php",baseUrl];
    
[YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
    self.dataDic = responseObject;
    NSDictionary *goodDic = self.dataDic[@"goods"];
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

} enError:^(NSError *error) {
    
}];
    
}
#pragma mark - 请求规格数据
- (void)loadSizeData
{
    
    // 请求详情数据
    NSString *url = [NSString stringWithFormat:@"%@api/goodattrclass.php",baseUrl];
    NSDictionary *param = @{@"good_id":self.good_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"商品详情数据请求成功%@",responseObject);
    
        self.jiagequjian = responseObject[@"jiafanwei"];
        self.cengji = responseObject[@"cengji"];

    } enError:^(NSError *error) {
        NSLog(@"商品详情数据请求失败%@",error);
    }];
    
    
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
    [self.tableView registerClass:[GoodDetailSizeNoCell class] forCellReuseIdentifier:goodSizeCell];
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
{UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - 50, KScreenW, 50)];
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
        // 如果已经收藏 点击后图标变暗
        [sender setImage:[UIImage imageNamed:@"no_collection"] forState:UIControlStateNormal];
        
    }else{
        // 如果无收藏  点击后图标变亮
        [sender setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
        
    }
    
    
}
- (void)customerServiceBtnAction:(UIButton *)sender
{
    NSLog(@"这是客服");
    
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
    
    // 获取限购参数
    NSString *activitynum = [NSString stringWithFormat:@"%@",self.dataDic[@"goods"][@"activitynum"]];
    // 没有数量限制
    if ([activitynum isEqualToString:@"-1"]) {
        UserInfo *userInfo = [UserInfo currentAccount];
        NSInteger num = [self.shoopCarNum integerValue];
        if (num >0) { // 数量大于0时才可执行
            NSDictionary *params = @{@"good_id":self.good_id,@"user_id":userInfo.user_id,@"is_attr":@"0",@"num":self.shoopCarNum,@"directbuy":@"1"};
            [self requestDataWithPrams:params andWithTitle:@"立即购买"];
           
            
        }else{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"请选择您要加入的商品!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertVC addAction:action];
            [self presentViewController:alertVC animated:YES completion:nil];
            
            return;
        }

    }
    
    

    // 有数量限制
    if ([activitynum isEqualToString:@"0"]) {
        [GFProgressHUD showInfoMsg:@"此商品只能购买一次"];
    }
     if ([activitynum integerValue]>0 && ([self.shoopCarNum integerValue] <[activitynum integerValue]  || [self.shoopCarNum isEqualToString:activitynum] )){
         
            UserInfo *userInfo = [UserInfo currentAccount];
             NSInteger num = [self.shoopCarNum integerValue];
             if (num >0) { // 数量大于0时才可执行
                 NSDictionary *params = @{@"good_id":self.good_id,@"user_id":userInfo.user_id,@"is_attr":@"0",@"num":self.shoopCarNum,@"directbuy":@"1"};
                 [self requestDataWithPrams:params andWithTitle:@"立即购买"];
                
                 
             }else{
                 UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"请选择您要加入的商品!" preferredStyle:UIAlertControllerStyleAlert];
                 UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                 [alertVC addAction:action];
                 [self presentViewController:alertVC animated:YES completion:nil];
                 
                 return;
             }
                  
     }

}
- (void)carBtnAction:(UIButton *)sender
{
    
    // 获取限购参数
    NSString *activitynum = [NSString stringWithFormat:@"%@",self.dataDic[@"goods"][@"activitynum"]];
    
    // 对数量没有限制
    if ([activitynum isEqualToString:@"-1"] ) {
        UserInfo *userInfo = [UserInfo currentAccount];
        NSInteger num = [self.shoopCarNum integerValue];
        if (num >0) { // 数量大于0时才可执行
            NSDictionary *params = @{@"good_id":self.good_id,@"user_id":userInfo.user_id,@"is_attr":@"0",@"num":self.shoopCarNum};
            [self requestDataWithPrams:params andWithTitle:@"加入购物车"];
            
        }else{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"请选择您要加入的商品!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertVC addAction:action];
            [self presentViewController:alertVC animated:YES completion:nil];
            
            return;
        }
        
       
    }
    
    
    
    if ([activitynum isEqualToString:@"0"]) {
        [GFProgressHUD showInfoMsg:@"此商品只能购买一次"];
    }
    if ([activitynum integerValue]>0 && ([self.shoopCarNum integerValue] <[activitynum integerValue]  || [self.shoopCarNum isEqualToString:activitynum] )){
        
            // 没有超出限制数量
            UserInfo *userInfo = [UserInfo currentAccount];
            NSInteger num = [self.shoopCarNum integerValue];
            if (num >0) { // 数量大于0时才可执行
                NSDictionary *params = @{@"good_id":self.good_id,@"user_id":userInfo.user_id,@"is_attr":@"0",@"num":self.shoopCarNum};
                [self requestDataWithPrams:params andWithTitle:@"加入购物车"];
               
            }else{
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"请选择您要加入的商品!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                [alertVC addAction:action];
                [self presentViewController:alertVC animated:YES completion:nil];
                
                return;
            }
            

       
       
    }else{
        [GFProgressHUD showInfoMsg:@"超出要购买的数量了!"];
    }
    
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
        GoodDetailSizeNoCell *cell = [tableView dequeueReusableCellWithIdentifier:goodSizeCell forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.totallMoneyLab.text = [NSString stringWithFormat:@"¥  %@",self.dataDic[@"goods"][@"price"] ];
        __weak typeof(cell) CellSelf = cell;
        // 获取限购参数
        NSString *activitynum = [NSString stringWithFormat:@"%@",self.dataDic[@"goods"][@"activitynum"]];
          NSString *order_count = [NSString stringWithFormat:@"%@",self.dataDic[@"goods"][@"order_count"]];
        // 加号按钮回调
        cell.addBtnBloock = ^(NSString *str){
            

                if ([activitynum isEqualToString:@"0"]) {
                    // 不可购买
                    [GFProgressHUD showInfoMsg:@"此商品只能购买一次!"];
                    CellSelf.numberTextField.text = @"1";
                    return ;
                }
            
                if ([activitynum integerValue] > 0) {
                    if ([order_count integerValue] > 0) {
                    // 非首次购买
                    [GFProgressHUD showInfoMsg:@"此商品只能购买一次!"];
                    }else{
                        //只能购买一个
                        self.shoopCarNum = str;
                        NSInteger num = [str integerValue];
                        double price =[self.dataDic[@"goods"][@"price"] doubleValue];
                        
                        if ([str integerValue] > [activitynum integerValue]) {
                            CellSelf.numberTextField.text = activitynum;
                            [GFProgressHUD showInfoMsg:[NSString stringWithFormat:@"此商品只能购买%@件!",activitynum]];
                            CellSelf.totallMoneyLab.text = [NSString stringWithFormat:@"¥ %.2f", [activitynum integerValue]*price];
                            self.shoopCarNum = activitynum;
                        }else{
                            CellSelf.totallMoneyLab.text = [NSString stringWithFormat:@"¥ %.2f",num*price];
                            self.shoopCarNum = str;
                        }
                        
                      return ;
  
                    }
                    
                }
                if ([activitynum isEqualToString:@"-1"]) {
                    //不限制数量
                    self.shoopCarNum = str;
                    NSInteger num = [str integerValue];
                    double price =[self.dataDic[@"goods"][@"price"] doubleValue];
                    CellSelf.totallMoneyLab.text = [NSString stringWithFormat:@"¥ %.2f",num*price];
                }

                
                
       
        };
        // 减号按钮回调
        cell.cutBtnBloock = ^(NSString *str){
            self.shoopCarNum = str;
            NSInteger num = [str integerValue];
            double price =[self.dataDic[@"goods"][@"price"] doubleValue];
            CellSelf.totallMoneyLab.text = [NSString stringWithFormat:@"¥ %.2f",num*price];
        };
        // 确定按钮的回调
        cell.confirmBtnBlock = ^(NSString *str){

            if ([activitynum isEqualToString:@"0"]) {
                // 不可购买
                [GFProgressHUD showInfoMsg:@"此商品只能购买一次!"];
                CellSelf.numberTextField.text = @"1";
                return ;
            }
            if ([activitynum integerValue] > 0) {
                if ([order_count integerValue] > 0) {
                    // 非首次购买
                    [GFProgressHUD showInfoMsg:@"此商品只能购买一次!"];
                }else{
                    //只能购买一个
                    self.shoopCarNum = str;
                    NSInteger num = [str integerValue];
                    double price =[self.dataDic[@"goods"][@"price"] doubleValue];
                    
                    if ([str integerValue] > [activitynum integerValue]) {
                        CellSelf.numberTextField.text = activitynum;
                        [GFProgressHUD showInfoMsg:[NSString stringWithFormat:@"此商品只能购买%@件!",activitynum]];
                        CellSelf.totallMoneyLab.text = [NSString stringWithFormat:@"¥ %.2f", [activitynum integerValue]*price];
                        self.shoopCarNum = activitynum;
                    }else{
                        CellSelf.totallMoneyLab.text = [NSString stringWithFormat:@"¥ %.2f",num*price];
                        self.shoopCarNum = str;
                    }
                    
                    return ;
                    
                }
                
            }
            
            if ([activitynum isEqualToString:@"-1"]) {
                //不限制数量
                self.shoopCarNum = str;
                NSInteger num = [str integerValue];
                double price =[self.dataDic[@"goods"][@"price"] doubleValue];
                CellSelf.totallMoneyLab.text = [NSString stringWithFormat:@"¥ %.2f",num*price];
            }

        };
        
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
        if (self.detailSizeParamArray.count>0) {
            // 有参数时才让弹出
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
        
    
}

#pragma mark - 加入购物车请求数据
- (void)requestDataWithPrams:(NSDictionary *)params andWithTitle:(NSString *)title
{
    NSString *url = [NSString stringWithFormat:@"%@api/addcart.php",baseUrl];
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"%@请求数据成功%@",title,responseObject);
        
        if ([title isEqualToString:@"立即购买"]) {
            OrderConfirmViewController *orderCofirmVC = [[OrderConfirmViewController alloc]init];
            orderCofirmVC.directbuy = @"1";
            [self.navigationController pushViewController:orderCofirmVC animated:YES];
        }else{
               [GFProgressHUD showSuccess:responseObject[@"msg"]];
          
        }
        [self loadData];
        
          } enError:^(NSError *error) {
        NSLog(@"%@请求数据失败%@",title,error);
    }];
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
        
    } enError:^(NSError *error) {
        NSLog(@"请求详情数据失败");
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

@end
