//
//  ShopGoodsDeitalViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/20.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "ShopGoodsDeitalViewController.h"
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
#import "GFChooseView.h"
#import "HomeShopListDetailModel.h"
#import "HomeShopListSizeModel.h"
#import "UIImageView+WebCache.h"
#import "OrderConfirmViewController.h"
#import "GoodDetaiParamsCell.h"
#import "HomeGoodDetailRecommandModel.h"
#import "HomeGoodDetailParamsView.h"
@interface ShopGoodsDeitalViewController ()<UITableViewDelegate,UITableViewDataSource,WKNavigationDelegate,GFChooseViewDelegate,UIWebViewDelegate>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
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
// 弹出视图
@property (nonatomic,strong) GFChooseView *chooseView;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSMutableDictionary *sizeDic;
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
/**全局*/
@property (nonatomic,assign) NSInteger selectNum;
/**决断是否有多属性*/
@property (nonatomic,copy) NSString *is_attr;
/** 记录四个选中的model */
@property (nonatomic,strong)HomeShopListSizeModel *model1;
@property (nonatomic,strong) HomeShopListSizeModel *model2;
@property (nonatomic,strong) HomeShopListSizeModel *model3;
@property (nonatomic,strong) HomeShopListSizeModel *model4;
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
/**导航栏上的线*/
@property (nonatomic,strong) UILabel  *navLineLab;
/**导航栏上的选中按钮*/
@property (nonatomic,strong) UIButton *navSelectBtn;
/**规格参数model*/
@property (nonatomic,strong) NSMutableArray *detailSizeParamArray;
/**推荐商品*/
@property (nonatomic,strong) NSMutableArray *recommandModelArray;

@end
static NSString *goodDetailCell = @"goodDetailCell";
static NSString *goodSizeCell = @"goodSizeCell";
static NSString *goodPramsCell = @"goodParamsCell";
@implementation ShopGoodsDeitalViewController
#pragma mark - 懒加载
/** 推荐商品 */
- (NSMutableArray *)recommandModelArray
{
    if (!_recommandModelArray) {
        self.recommandModelArray = [[NSMutableArray alloc]init];
    }
    return _recommandModelArray;
}
/**规格参数model*/
- (NSMutableArray *)detailSizeParamArray
{
    if (!_detailSizeParamArray) {
        self.detailSizeParamArray = [[NSMutableArray alloc]init];
    }
    return _detailSizeParamArray;
}
/** 详情数据 */
- (NSMutableDictionary *)detailDataDic
{
    if (!_detailDataDic) {
        self.detailDataDic = [[NSMutableDictionary alloc]init];
    }
    return _detailDataDic;
}
// 存放model数组
- (NSMutableArray *)picsArray
{
    if (!_picsArray) {
        self.picsArray =[[NSMutableArray alloc]init];
    }
    return _picsArray;
}
-(NSMutableArray *)brandArray
{
    if (!_brandArray) {
        self.brandArray = [[NSMutableArray alloc]init];
    }
    return _brandArray;
}
- (NSMutableArray *)chooseDataArr
{
    if (!_chooseDataArr) {
        self.chooseDataArr = [[NSMutableArray alloc]init];
    }
    return _chooseDataArr;
}
- (NSMutableArray *)titleSelectModelArr
{
    if (!_titleSelectModelArr) {
        self.titleSelectModelArr = [[NSMutableArray alloc]init];
    }
    return _titleSelectModelArr;
}
- (NSMutableDictionary *)sizeDic
{
    if (!_sizeDic) {
        self.sizeDic = [[NSMutableDictionary alloc]init];
    }
    return _sizeDic;
}
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
- (HomeShopListSizeModel *)model1
{
    if (!_model1) {
        self.model1 = [[HomeShopListSizeModel alloc]init];
    }
    return _model1;
}
- (HomeShopListSizeModel *)model2
{
    if (!_model2) {
        self.model2 = [[HomeShopListSizeModel alloc]init];
    }
    return _model2;
}
- (HomeShopListSizeModel *)model3
{
    if (!_model3) {
        self.model3 = [[HomeShopListSizeModel alloc]init];
    }
    return _model3;
}
- (HomeShopListSizeModel *)model4
{
    if (!_model4) {
        self.model4 = [[HomeShopListSizeModel alloc]init];
    }
    return _model4;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
 
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
        self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.goodSize =@"";
    self.huo_id = @"";
    self.shoopCarNum = @"1";
    self.cengji = @"";
    self.isCancelStroe = self.isfavorite;
   
    self.selectNum = 0;
    [self setUpNavView];
    // 加载数据
    [self loadData];
    [self loadSizeData];
    // 加载子视图
    [self setUpChildrenViews];
    [self setUpBottomViews];
}
/**
 *加载数据
 */
- (void)loadData
{
    
       // 请求详情数据
        NSDictionary *goodDic =self.dataDic[@"goods"];
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
#pragma mark - 请求规格数据
- (void)loadSizeData
{
    
    // 请求详情数据
    NSString *url = [NSString stringWithFormat:@"%@api/goodattrclass.php",baseUrl];
    NSDictionary *param = @{@"good_id":self.good_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"商品详情数据请求成功%@",responseObject);
        
         NSDictionary *dataDic= responseObject[@"data"];
          self.jiagequjian = responseObject[@"jiafanwei"];
          self.cengji = responseObject[@"cengji"];
        NSInteger cengjiNumber = [self.cengji integerValue];
        
        

        switch (cengjiNumber) {
            case 1:
            {
                // 第1级
                NSMutableArray *arr0 = dataDic[@"a0"];
                // 添加第5个数据源
                for (NSDictionary *dic in arr0) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataFiveArr addObject:model];
                }
            
            }
                break;
            case 2:
            {
                // 第1级
                NSMutableArray *arr0 = dataDic[@"a0"];
              NSMutableArray *arr4 = dataDic[@"a1"];
                
                // 添加第1个数据源
                for (NSDictionary *dic in arr0) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataOneArr addObject:model];
                }
               
                
                // 添加第5个数据源
                for (NSDictionary *dic in arr4) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataFiveArr addObject:model];
                }
                
                [self.chooseDataArr addObject:self.sizeDataOneArr];

            }
                break;

            case 3:
            {
                // 第1级
                NSMutableArray *arr0 = dataDic[@"a0"];
                NSMutableArray *arr1 = dataDic[@"a1"];
              NSMutableArray *arr4 = dataDic[@"a2"];
                
                // 添加第1个数据源
                for (NSDictionary *dic in arr0) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataOneArr addObject:model];
                }
                // 添加第2个数据源
                for (NSDictionary *dic in arr1) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataTwoArr addObject:model];
                }
                
                               // 添加第5个数据源
                for (NSDictionary *dic in arr4) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataFiveArr addObject:model];
                }
                
                [self.chooseDataArr addObject:self.sizeDataOneArr];
                [self.chooseDataArr addObject:self.sizeDataTwoArr];
            }
                break;

            case 4:
            {
                // 第1级
                NSMutableArray *arr0 = dataDic[@"a0"];
                NSMutableArray *arr1 = dataDic[@"a1"];
                NSMutableArray *arr2 = dataDic[@"a2"];
                NSMutableArray *arr4 = dataDic[@"a3"];
                
                // 添加第1个数据源
                for (NSDictionary *dic in arr0) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataOneArr addObject:model];
                }
                // 添加第2个数据源
                for (NSDictionary *dic in arr1) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataTwoArr addObject:model];
                }
                
                // 添加第3个数据源
                for (NSDictionary *dic in arr2) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataThreeArr addObject:model];
                }
                
                
                // 添加第5个数据源
                for (NSDictionary *dic in arr4) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataFiveArr addObject:model];
                }
                
      
               [self.chooseDataArr addObject:self.sizeDataOneArr];
                [self.chooseDataArr addObject:self.sizeDataTwoArr];
                [self.chooseDataArr addObject:self.sizeDataThreeArr];
                

            }
                break;

            case 5:
            {
                // 第1级
                NSMutableArray *arr0 = dataDic[@"a0"];
                NSMutableArray *arr1 = dataDic[@"a1"];
                NSMutableArray *arr2 = dataDic[@"a2"];
                NSMutableArray *arr3 = dataDic[@"a3"];
                NSMutableArray *arr4 = dataDic[@"a4"];
                
                // 添加第1个数据源
                for (NSDictionary *dic in arr0) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataOneArr addObject:model];
                }
                // 添加第2个数据源
                for (NSDictionary *dic in arr1) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataTwoArr addObject:model];
                }
                
                // 添加第3个数据源
                for (NSDictionary *dic in arr2) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataThreeArr addObject:model];
                }
                
                // 添加第4个数据源
                for (NSDictionary *dic in arr3) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataFourArr addObject:model];
                }
                
                // 添加第5个数据源
                for (NSDictionary *dic in arr4) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataFiveArr addObject:model];
                }
                
            
                
                
                [self.chooseDataArr addObject:self.sizeDataOneArr];
                [self.chooseDataArr addObject:self.sizeDataTwoArr];

                [self.chooseDataArr addObject:self.sizeDataThreeArr];

                [self.chooseDataArr addObject:self.sizeDataFourArr];

                

            }
                break;

                
            default:
                break;
        }
        
        
     
        
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
    UIButton *stroeBtn = [YNTUITools createCustomButton:CGRectMake(14*kWidthScale, 6 *kHeightScale, 36 *kWidthScale, 35 *kHeightScale) bgColor:RGBA(251, 251, 251, 1) title:nil titleColor:nil image:@"no_collection" action:@selector(storeBtnAction:) vc:self];
    if ([self.isfavorite isEqualToString:@"1"]) {
        [stroeBtn setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];
    }else{
         [stroeBtn setImage:[UIImage imageNamed:@"no_collection"] forState:UIControlStateNormal];
    }
    [bagView addSubview:stroeBtn];
    
    // 创建线
    UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(60*kWidthScale, 6*kHeightScale, 1*kWidthScale, 36 *kHeightScale)];
    lineLab.backgroundColor = [UIColor grayColor];
    [bagView addSubview:lineLab];
    
    
    
    // 创建客服按钮
    UIButton *customerServiceBtn =  [YNTUITools createCustomButton:CGRectMake(82*kWidthScale, 6 *kHeightScale, 28 *kWidthScale, 36 *kHeightScale) bgColor:RGBA(251, 251, 251, 1) title:nil titleColor:nil image:@"customer_service" action:@selector(customerServiceBtnAction:) vc:self];
    [bagView addSubview:customerServiceBtn];
    
    // 创建加入购物车按钮
    UIButton*carBtn = [YNTUITools createButton:CGRectMake(250 *kWidthScale , 0, 124 *kWidthScale, 50)  bgColor:CGRBlue title:@"加入购物车" titleColor:[UIColor whiteColor] action:@selector(carBtnAction:) vc:self];

       [bagView addSubview:carBtn];
    
    // 创建立刻购买
    UIButton*imdedateBtn = [YNTUITools createButton:CGRectMake(125 *kWidthScale, 0, 124 *kWidthScale, 50)  bgColor:CGRBlue title:@"立刻购买" titleColor:[UIColor whiteColor] action:@selector(imdedateAction:) vc:self];
    
    [bagView addSubview:imdedateBtn];

}
#pragma mark- 底部按钮的点击事件
- (void)storeBtnAction:(UIButton *)sender
{
    NSLog(@"收藏按钮的点击");
    UserInfo *userInfo = [UserInfo currentAccount];
    NSString *url = [NSString stringWithFormat:@"%@api/goods_favorite.php",baseUrl];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"good_id":self.good_id,@"act":@"add"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"收藏数据请求成功%@",responseObject);
    } enError:^(NSError *error) {
          NSLog(@"收藏数据请求失败%@",error);
    }];
    
    // 进来的时候处于收藏的状态
    if ([self.isCancelStroe isEqualToString: @"1"]) {
        NSLog(@"我是移除收藏夹的点击");
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
            self.isCancelStroe = @"0";
            
                 } enError:^(NSError *error) {
            NSLog(@"移除收藏夹数据失败%@",error);
        }];
    }
    
    
    //进来的时候处于未收藏的状态
    if ([self.isCancelStroe isEqualToString:@"0"]) {
        // 收藏的时候调取接口
        NSString *url = [NSString stringWithFormat:@"%@api/goods_favorite.php",baseUrl];
        NSDictionary *param = @{@"user_id":userInfo.user_id,@"good_id":self.storeAndAddGood_id,@"act":@"add"};
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
            NSLog(@"添加收藏夹数据成功%@",responseObject);
            NSString *msg = responseObject[@"msg"];
            if ([msg isEqualToString:@"success"]) {
               
                
                 [GFProgressHUD showSuccess:responseObject[@"info"]];
               
            }else{
                [GFProgressHUD showFailure:responseObject[@"info"]];
                
            }
               self.isCancelStroe = @"1";
            NSLog(@"收藏按钮的点击");
        } enError:^(NSError *error) {
            NSLog(@"添加收藏夹数据失败%@",error);
        }];
        
        
        

    }
 
    
    
    
    
    if ([self.isCancelStroe isEqualToString:@"1"]) {
        [sender setImage:[UIImage imageNamed:@"no_collection"] forState:UIControlStateNormal];

    }else{
        [sender setImage:[UIImage imageNamed:@"collection"] forState:UIControlStateNormal];

    }
    

    
}
- (void)customerServiceBtnAction:(UIButton *)sender
{
    NSLog(@"这是客服");
    
    UIWebView *webView = [[UIWebView alloc]init];
    [self.view addSubview:webView];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://10086"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];

}
// 立刻购买点击事件
- (void)imdedateAction:(UIButton *)sender
{
    
    OrderConfirmViewController *orderCofirmVC = [[OrderConfirmViewController alloc]init];
    [self.navigationController pushViewController:orderCofirmVC animated:YES];
  
}
- (void)carBtnAction:(UIButton *)sender
{
    
    self.chooseView = [[GFChooseView alloc]initWithFrame:CGRectMake(0, kScreenH, KScreenW, kScreenH)];
    _chooseView.totallMoneyLab.text =@"¥0";
        [self setToatalNumberColor:_chooseView.goodsNumberLab andStr:@"共0件"];
    
    _chooseView.delegate = self;
    
  

     [_chooseView setTitleBtnArrayWithModelArr:self.chooseDataArr andStr:@"通过服务器"];
    // 为弹出框图片赋值
    [_chooseView setGFChooseViewWithURL:self.picUrl andJiaGeQuJian:self.jiagequjian];
    
   //为规格数据赋值(创建的时候)
    [_chooseView setGFChooseTableViewValueWithArr:self.sizeDataFiveArr andCengji:self.cengji];
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
            [self loadData];
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
    
    
    if (indexPath.row == 1) {
        self.chooseView = [[GFChooseView alloc]initWithFrame:CGRectMake(0, kScreenH, KScreenW, kScreenH)];
        _chooseView.totallMoneyLab.text =@"¥0";
        [self setToatalNumberColor:_chooseView.goodsNumberLab andStr:@"共0件"];
        
        _chooseView.delegate = self;
        
        
        
        [_chooseView setTitleBtnArrayWithModelArr:self.chooseDataArr andStr:@"通过服务器"];
        // 为弹出框图片赋值
        [_chooseView setGFChooseViewWithURL:self.picUrl andJiaGeQuJian:self.jiagequjian];
        
        //为规格数据赋值(创建的时候)
        [_chooseView setGFChooseTableViewValueWithArr:self.sizeDataFiveArr andCengji:self.cengji];
        [self.view addSubview:_chooseView];
        
        
        
        [UIView animateWithDuration: 0.35 animations: ^{
            _chooseView.frame =CGRectMake(0, 0, KScreenW, kScreenH);
        } completion: nil];
        NSLog(@"我要加入购物车了");
    }

  
}
#pragma mark - wkwebView代理
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        //获取页面高度
       self.webHeight = [result doubleValue];
            self.webView.frame = CGRectMake(self.webView.frame.origin.x,self.webView.frame.origin.y, KScreenW, self.webHeight);
            self.bigView.frame = CGRectMake(0, 0, KScreenW, self.webHeight);
            [self.tableView reloadData];

    }];
    

}




#pragma mark - 弹出框代理
//点击加号事件
- (void)clickAddButtonAction:(NSString *)str
{
    NSLog(@"代理加号点击事件:%@",str);

    
}
//点击减号事件
- (void)clickReduceButtonAction:(NSString *)str
{NSLog(@"代理减号点击事件:%@",str);

}
// 文字改变事件
- (void)textChangeAction:(NSString *)str
{
    NSLog(@"代理文字正在改变:%@",str);
}
// 键盘完成事件
- (void)clickKeyBordCompleteAction:(NSString *)str
{
    NSLog(@"代理完成后输入的文字是:%@",str);
}
//点击关闭事件
- (void)closeButtonAction
{
    [UIView animateWithDuration: 0.35 animations: ^{
        self.chooseView.frame =CGRectMake(0, kScreenH,KScreenW, kScreenH);
        
    } completion: nil];
    
}
// 点击确定事件
- (void)chooseViewConfirmButtonActionWithArr:(NSMutableDictionary *)dic
{
    NSString *url = [NSString stringWithFormat:@"%@api/addcart.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    
   NSArray *keysArr = dic.allKeys;
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    for (int i = 0; i<keysArr.count; i++) {
        NSString *num = dic[keysArr[i]];
          NSDictionary *dic1 = @{@"good_attid":keysArr[i],@"num":num};
        [dataArray addObject:dic1];
    }
    
    
    // 数组转化为json
    NSData *arrData = [NSJSONSerialization dataWithJSONObject:dataArray options:NSJSONWritingPrettyPrinted error:nil];
    
        NSString *dataStr = [[NSString alloc] initWithData:arrData encoding:NSUTF8StringEncoding];
 // 请求参数
    NSDictionary *params = @{@"good_id":self.good_id,@"user_id":userInfo.user_id,@"data":dataStr,@"is_attr":self.is_attr};
    
    
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"提交购物车请求数据成功%@",responseObject);
    } enError:^(NSError *error) {
        NSLog(@"提交购物车请求数据失败%@",error);
    }];


    
    [UIView animateWithDuration: 0.35 animations: ^{
                self.chooseView.frame =CGRectMake(0, kScreenH, KScreenW, kScreenH);
        
            } completion: nil];

}

- (void)clickBtnLineNumber:(NSInteger)lineNumber andIndex:(NSInteger)index
{
    
   
        switch (lineNumber) {
            case 0:
            {
                NSLog(@"点击的是第%ld行 --第%ld个",lineNumber,(long)index);
                
          
               
                self.model1 = self.sizeDataOneArr[index];
                NSDictionary *params = @{@"good_id":self.good_id,@"xuanze":self.model1.attrid};
                [self clickSizeData:params andIndex:lineNumber];
                
            }
                break;
            case 1:
            {
                self.model2 = self.sizeDataTwoArr[index];
                
                NSString *xuanze = [NSString stringWithFormat:@"%@%@",[self getClickTitleId:0],self.model2.attrid];
              
                NSDictionary *params = @{@"good_id":self.good_id,@"xuanze":xuanze};
                
                
                [self clickSizeData:params andIndex:lineNumber];
                
  
                
                
            }
                break;
                
            case 2:
            {
                
                self.model3 = self.sizeDataThreeArr[index];
                
                NSString *xuanze = [NSString stringWithFormat:@"%@%@",[self getClickTitleId:1],self.model3.attrid];
                NSDictionary *params = @{@"good_id":self.good_id,@"xuanze":xuanze};
                
                [self clickSizeData:params andIndex:lineNumber];
                              
            }
                break;
                
            case 3:
            {
                NSLog(@"点击的是第%ld行 --第%ld个",lineNumber,(long)index);
                
                self.model4 = self.sizeDataFourArr[index];
                
                NSString *xuanze = [NSString stringWithFormat:@"%@%@",[self getClickTitleId:2],self.model4.attrid];
                NSDictionary *params = @{@"good_id":self.good_id,@"xuanze":xuanze};

                [self clickSizeData:params andIndex:lineNumber];
    
                
                
            }
                break;
                
                
            default:
                break;
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

#pragma mark - 点击规格请求数据 
- (void)clickSizeData:(NSDictionary *)param andIndex:(NSInteger )index{
     //请求详情数据
    NSString *url = [NSString stringWithFormat:@"%@api/goodattrclass.php",baseUrl];


    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"商品详情数据请求成功%@",responseObject);
        NSDictionary *dataDic= responseObject[@"data"];
        
        switch ([self.cengji integerValue]) {
            case 1:
            {
                //  第1级
                NSMutableArray *arr0 = [[NSMutableArray alloc]init];
             
                
                
                arr0 = dataDic[@"a0"];
              
                
                
                
                [self.chooseDataArr removeAllObjects];
                [self.sizeDataFiveArr removeAllObjects];
         
                // 添加第1个数据源
                for (NSDictionary *dic in arr0) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataFiveArr addObject:model];
                }
           
            }
                break;
            case 2:
            {
                //  第1级
                NSMutableArray *arr0 = [[NSMutableArray alloc]init];
                NSMutableArray *arr1 = [[NSMutableArray alloc]init];
       
                
                arr0 = dataDic[@"a0"];
                arr1 = dataDic[@"a1"];
    
                
                
                [self.chooseDataArr removeAllObjects];
                [self.sizeDataFiveArr removeAllObjects];
                [self.sizeDataOneArr removeAllObjects];
                // 添加第1个数据源
                for (NSDictionary *dic in arr0) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataOneArr addObject:model];
                }
                // 添加第2个数据源
                for (NSDictionary *dic in arr1) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataFiveArr addObject:model];
                }
                
                
                [self.chooseDataArr addObject:self.sizeDataOneArr];
            
            }
                break;

            case 3:
            {
                //  第1级
                NSMutableArray *arr0 = [[NSMutableArray alloc]init];
                NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                NSMutableArray *arr2 = [[NSMutableArray alloc]init];
       
                arr0 = dataDic[@"a0"];
                arr1 = dataDic[@"a1"];
                arr2 = dataDic[@"a2"];
      
                
                [self.chooseDataArr removeAllObjects];
                [self.sizeDataTwoArr removeAllObjects];
                [self.sizeDataFiveArr removeAllObjects];
                [self.sizeDataOneArr removeAllObjects];
                // 添加第1个数据源
                for (NSDictionary *dic in arr0) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataOneArr addObject:model];
                }
                // 添加第2个数据源
                for (NSDictionary *dic in arr1) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataTwoArr addObject:model];
                }
                
                // 添加第3个数据源
                for (NSDictionary *dic in arr2) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataFiveArr addObject:model];
                }
                
                
                
                [self.chooseDataArr addObject:self.sizeDataOneArr];
                [self.chooseDataArr addObject:self.sizeDataTwoArr];
       
            }
                break;

            case 4:
            {
                //  第1级
                NSMutableArray *arr0 = [[NSMutableArray alloc]init];
                NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                NSMutableArray *arr2 = [[NSMutableArray alloc]init];
                NSMutableArray *arr3 = [[NSMutableArray alloc]init];
                arr0 = dataDic[@"a0"];
                arr1 = dataDic[@"a1"];
                arr2 = dataDic[@"a2"];
                arr3 = dataDic[@"a3"];
             
                [self.chooseDataArr removeAllObjects];
                [self.sizeDataTwoArr removeAllObjects];
                [self.sizeDataThreeArr removeAllObjects];
                [self.sizeDataFiveArr removeAllObjects];
                [self.sizeDataOneArr removeAllObjects];
                // 添加第1个数据源
                for (NSDictionary *dic in arr0) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataOneArr addObject:model];
                }
                // 添加第2个数据源
                for (NSDictionary *dic in arr1) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataTwoArr addObject:model];
                }
                
                // 添加第3个数据源
                for (NSDictionary *dic in arr2) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataThreeArr addObject:model];
                }
                
                // 添加第4个数据源
                for (NSDictionary *dic in arr3) {
                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                    [model setValuesForKeysWithDictionary:dic];
                    [self.sizeDataFiveArr addObject:model];
                }
                
                
                [self.chooseDataArr addObject:self.sizeDataOneArr];
                [self.chooseDataArr addObject:self.sizeDataTwoArr];
                [self.chooseDataArr addObject:self.sizeDataThreeArr];
               
            }
                break;
            case 5:
            {
               //  第1级
                                NSMutableArray *arr0 = [[NSMutableArray alloc]init];
                                NSMutableArray *arr1 = [[NSMutableArray alloc]init];
                                NSMutableArray *arr2 = [[NSMutableArray alloc]init];
                                NSMutableArray *arr3 = [[NSMutableArray alloc]init];
                                NSMutableArray *arr4 = [[NSMutableArray alloc]init];
                
                                arr0 = dataDic[@"a0"];
                                arr1 = dataDic[@"a1"];
                                arr2 = dataDic[@"a2"];
                                arr3 = dataDic[@"a3"];
                                arr4 = dataDic[@"a4"];
                                [self.chooseDataArr removeAllObjects];
                                [self.sizeDataTwoArr removeAllObjects];
                                [self.sizeDataThreeArr removeAllObjects];
                                [self.sizeDataFourArr removeAllObjects];
                                [self.sizeDataFiveArr removeAllObjects];
                                [self.sizeDataOneArr removeAllObjects];
                                // 添加第1个数据源
                                for (NSDictionary *dic in arr0) {
                                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                                    [model setValuesForKeysWithDictionary:dic];
                                    [self.sizeDataOneArr addObject:model];
                                }
                                // 添加第2个数据源
                                for (NSDictionary *dic in arr1) {
                                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                                    [model setValuesForKeysWithDictionary:dic];
                                    [self.sizeDataTwoArr addObject:model];
                                }
                
                                // 添加第3个数据源
                                for (NSDictionary *dic in arr2) {
                                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                                    [model setValuesForKeysWithDictionary:dic];
                                    [self.sizeDataThreeArr addObject:model];
                                }
                
                                // 添加第4个数据源
                                for (NSDictionary *dic in arr3) {
                                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                                    [model setValuesForKeysWithDictionary:dic];
                                    [self.sizeDataFourArr addObject:model];
                                }
                
                                // 添加第5个数据源
                                for (NSDictionary *dic in arr4) {
                                    HomeShopListSizeModel *model = [[HomeShopListSizeModel alloc]init];
                                    [model setValuesForKeysWithDictionary:dic];
                                    [self.sizeDataFiveArr addObject:model];
                                }
                
                                [self.chooseDataArr addObject:self.sizeDataOneArr];
                                [self.chooseDataArr addObject:self.sizeDataTwoArr];
                                [self.chooseDataArr addObject:self.sizeDataThreeArr];
                                [self.chooseDataArr addObject:self.sizeDataFourArr];
                

            }
                break;


                
            default:
                break;
        }
        
        [_chooseView setTitleBtnArrayWithModelArr:self.chooseDataArr andStr:@"通过点击"];
        [_chooseView setGFChooseTableViewValueWithArr:self.sizeDataFiveArr andCengji:self.cengji];
        
    } enError:^(NSError *error) {
        NSLog(@"商品详情数据请求失败%@",error);
    }];
    

}
#pragma mark - 获取点击id
- (NSString *)getClickTitleId:(NSInteger )index
{
    [self.titleSelectModelArr removeAllObjects];
    switch (index) {
        case 0:
        {
            // 点击第0行
            for (HomeShopListSizeModel *model in self.sizeDataOneArr) {
                if ([model.select integerValue] == 1) {
                
                    [self.titleSelectModelArr addObject:model];
                }
            }
            
        }
            break;
        case 1:
        { // 点击第1行
            for (HomeShopListSizeModel *model in self.sizeDataOneArr) {
                if ([model.select integerValue] == 1) {
                    [self.titleSelectModelArr addObject:model];
                }
            }
            
            for (HomeShopListSizeModel *model in self.sizeDataTwoArr) {
                if ([model.select integerValue] == 1) {
                    [self.titleSelectModelArr addObject:model];
                }
            }

                }
            break;

        case 2:
        {  // 点击第2行
            for (HomeShopListSizeModel *model in self.sizeDataOneArr) {
                if ([model.select integerValue] == 1) {
                    [self.titleSelectModelArr addObject:model];
                }
            }
            for (HomeShopListSizeModel *model in self.sizeDataTwoArr) {
                if ([model.select integerValue] == 1) {
                    [self.titleSelectModelArr addObject:model];
                }
            }
            for (HomeShopListSizeModel *model in self.sizeDataThreeArr) {
                if ([model.select integerValue] == 1) {
                    [self.titleSelectModelArr addObject:model];
                }
            }

            
                 }
            break;
            
        case 3:
        {  // 点击第2行
            for (HomeShopListSizeModel *model in self.sizeDataOneArr) {
                if ([model.select integerValue] == 1) {
                    [self.titleSelectModelArr addObject:model];
                }
            }
            for (HomeShopListSizeModel *model in self.sizeDataTwoArr) {
                if ([model.select integerValue] == 1) {
                    [self.titleSelectModelArr addObject:model];
                }
            }
            
            for (HomeShopListSizeModel *model in self.sizeDataThreeArr) {
                if ([model.select integerValue] == 1) {
                    [self.titleSelectModelArr addObject:model];
                }
            }
            for (HomeShopListSizeModel *model in self.sizeDataFourArr) {
                if ([model.select integerValue] == 1) {
                    [self.titleSelectModelArr addObject:model];
                }
            }

            
            
        }
            break;


            
        default:
            break;
    }
    
    
    NSString *stringxuanze =@"";
    for (HomeShopListSizeModel *model in self.titleSelectModelArr) {
        stringxuanze =  [stringxuanze stringByAppendingFormat:@"%@,",model.attrid];
        
    }
    return stringxuanze;
}
//将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData options:NSJSONWritingPrettyPrinted error:nil];
    
    if ([jsonData length]&&error== nil){
        return jsonData;
    }else{
        return nil;
    }
}

@end
