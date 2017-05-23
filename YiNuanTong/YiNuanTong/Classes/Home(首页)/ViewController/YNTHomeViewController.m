//
//  YNTHomeViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTHomeViewController.h"
#import "LoginViewController.h"
#import "HomeMenCell.h"
#import "SingLeton.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "HomeReusableHeadView.h"
#import "MinHeadElseReusableView.h"
#import "HomeFistCell.h"
#import "YNTUITools.h"
#import "ShopClassHeadView.h"
#import "ShopThreeCooperationView.h"
#import "ShopGoodsListViewController.h"
#import "HomeSecondCell.h"
#import "HomeThreeCell.h"
#import "OftenBuyViewController.h"
#import "SecondBuyGoodViewController.h"
#import "PhoneAccessViewController.h"
#import "YNTNetworkManager.h"
#import "OftenBuyViewController.h"
#import "StoreViewController.h"
#import "UserInfo.h"
#import "AddPasswordViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "HomeWebViewController.h"
#import "HomeItemsModel.h"
#import "PayDetailViewController.h"
#import "HomePicModel.h"
#import "UIImageView+WebCache.h"
#import "HomeGoodListSingLeton.h"
@interface YNTHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

/**collectionView*/
@property (nonatomic,strong) UICollectionView *collectionView;
/**存放图标数组*/
@property (nonatomic, strong) NSMutableArray *menuArray;
/**创建布局对象*/
@property (nonatomic,strong) UICollectionViewFlowLayout  * flowLayout;
//判断是否登陆
@property (nonatomic,assign) BOOL isLogin;
/**头视图*/
@property (nonatomic,strong) HomeReusableHeadView  * headView;
/**其它头视图*/
@property (nonatomic,strong) HomeReusableHeadView  * headElseView;
/**firstCell图标数据源*/
@property (nonatomic,strong) NSMutableArray  * firstImageArr;
/**secondCell图标数据源*/
@property (nonatomic,strong) NSMutableArray  * secondImageArr;
/**threeCell图标数据源*/
@property (nonatomic,strong) NSMutableArray  * threeImageArr;
/**轮播图标数据源*/
@property (nonatomic,strong) NSMutableArray  * imgArr;
/**分类的标识*/
@property (nonatomic,strong) NSMutableArray  * identifierArray;
/**进口壁挂炉数据源*/
@property (nonatomic,strong) NSMutableArray  * itemsModelArray;
/**类型数据*/
@property (nonatomic,strong) NSMutableDictionary  * typeData;
@end
static NSString *headViewIdentifier = @"headView";
static NSString *headViewElseIdentifier = @"headViewElse";
static NSString *homeFrstCell = @"homeFirstCell";
static NSString *homeSecondCell = @"homeSecondCell";
static NSString *homeThreeCell = @"homeThreeCell";
@implementation YNTHomeViewController
- (NSMutableDictionary *)typeData
{
    if (!_typeData) {
        self.typeData = [[NSMutableDictionary alloc]init];
    }
    return _typeData;
}
/**
 *懒加载
 */
- (NSMutableArray *)itemsModelArray
{
    if (!_itemsModelArray) {
        self.itemsModelArray = [[NSMutableArray alloc]init];
    }
    return _itemsModelArray;
}
- (NSMutableArray *)imgArr
{
    if (!_imgArr) {
        self.imgArr = [[NSMutableArray alloc]init];
    }
    return _imgArr;
}
- (NSMutableArray *)secondImageArr
{
    if (!_secondImageArr) {
        self.secondImageArr = [[NSMutableArray alloc]init];
    }
    return _secondImageArr;
}
- (NSMutableArray *)firstImageArr
{
    if (!_firstImageArr) {
        self.firstImageArr = [[NSMutableArray alloc]init];
    }
    return _firstImageArr;
}
- (NSMutableArray *)threeImageArr
{
    if (!_threeImageArr) {
        self.threeImageArr = [[NSMutableArray alloc]init];
    }
    return _threeImageArr;
}
- (NSMutableArray *)identifierArray
{
    if (!_identifierArray) {
        self.identifierArray = [[NSMutableArray alloc]init];
    }
    return _identifierArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
  
       UserInfo *userInfo = [UserInfo currentAccount];
       // 首页出现后设置角标
     //   [[[[[self tabBarController] viewControllers] objectAtIndex: 1] tabBarItem] setBadgeValue:userInfo.badge];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
      self.edgesForExtendedLayout = UIRectEdgeNone;
     
    }
   
 
    if (userInfo.user_id) {
        NSLog(@"已经登陆");
        [self setNavgationChildViews];
    
        // 调用创建tableView
        [self setUpTableView];
        
        
   

    }else{
            LoginViewController *logInVC = [[LoginViewController alloc]init];
            [self presentViewController:logInVC animated:YES completion:nil];

                  [self setNavgationChildViews];
            // 加载数据
       
        

    }
    
    
    // 设置导航条的背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    // 设置导航条上的文字大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    // 设置导航条的背景颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self loadData];
    // 调用创建tableView
    [self setUpTableView];
    [self setNavgationChildViews];
    // 获取通知中心对象
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    // 添加当前类对象为一个观察者,name 和obeject设置为nil,表示接收一切消息
    [center addObserver:self selector:@selector(receiveNotificiation:) name:@"paySuccess" object:nil];
    [center addObserver:self selector:@selector(aliPayNotition:) name:@"aliPayReslutYnt" object:nil];
    
   
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weChatNotition:) name:@"weChatPaySuccessYNT" object:nil];

    }

- (void)weChatNotition:(NSNotification *)info
{
    PayDetailViewController *payDetailVC = [[PayDetailViewController alloc]init];
    
    HomeGoodListSingLeton *singLeton = [HomeGoodListSingLeton shareHomeGoodListSingLeton];
    
    payDetailVC.orderNumber =   singLeton.dic[@"sn"];
    if ([[NSString stringWithFormat:@"%@",  singLeton.dic[@"status"]] isEqualToString:@"1"]) {
        payDetailVC.payStatus = @"支付成功";
    }
    payDetailVC.payType =   singLeton.dic[@"payname"];
    payDetailVC.money =   singLeton.dic[@"price"];
    payDetailVC.order_id =   singLeton.dic[@"order_id"];
    [self.navigationController pushViewController:payDetailVC animated:YES];
 
}

- (void)aliPayNotition:(NSNotification *)info
{
    PayDetailViewController *payDetailVC = [[PayDetailViewController alloc]init];
   
    HomeGoodListSingLeton *singLeton = [HomeGoodListSingLeton shareHomeGoodListSingLeton];
  
    payDetailVC.orderNumber =   singLeton.dic[@"sn"];
    if ([[NSString stringWithFormat:@"%@",  singLeton.dic[@"status"]] isEqualToString:@"1"]) {
        payDetailVC.payStatus = @"支付成功";
    }
    payDetailVC.payType =   singLeton.dic[@"payname"];
    payDetailVC.money =   singLeton.dic[@"price"];
    payDetailVC.order_id =   singLeton.dic[@"order_id"];
    [self.navigationController pushViewController:payDetailVC animated:YES];
}
- (void)receiveNotificiation:(NSNotification *)info
{
    [self loadData];
}
/**
 *自定义导航栏
 */
- (void)setNavgationChildViews
{
    UserInfo *userInfo = [UserInfo currentAccount];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 44)];
    UILabel *logNameLab = [YNTUITools createLabel:CGRectMake(KScreenW/2 - 100, 0, 200, 30) text:@"1暖通-商用" textAlignment:NSTextAlignmentCenter textColor:RGBA(13, 114, 201, 1) bgColor:nil font:17];
    
    UILabel *companyLab = [YNTUITools createLabel:CGRectMake(KScreenW/2 - 150, 30, 300, 10) text:userInfo.realname textAlignment:NSTextAlignmentCenter textColor:[UIColor grayColor] bgColor:nil font:10.0];
    // 在这里用这种方法设置导航栏上字体的大小
    companyLab.font = [UIFont boldSystemFontOfSize:10];
    [view addSubview:logNameLab];
    [view addSubview:companyLab];
    
    self.navigationItem.titleView = view;
}
/**
 *加载数据
 */
- (void)loadData
{
    self.tabBarController.tabBar.hidden = NO;
    

    self.firstImageArr = @[@"收藏商品",@"常购商品",@"再次购买",@"联系我们"].mutableCopy;
       [self.secondImageArr removeAllObjects];
    NSString *url1 = [NSString stringWithFormat:@"%@api/categoryclass.php",baseUrl];
    NSDictionary *params = @{@"banben":@"1.2.1"};
    
 [YNTNetworkManager requestPOSTwithURLStr:url1 paramDic:params finish:^(id responseObject) {
     self.typeData = responseObject;
     NSArray *dataArray = responseObject[@"data"];
     for (NSDictionary *dic in dataArray) {
         HomePicModel *model = [[HomePicModel alloc]init];
         [model setValuesForKeysWithDictionary:dic];
        [self.secondImageArr addObject:model];
     }
     if (self.collectionView) {
        [self.collectionView reloadData];
     }else{
         [self setUpTableView];
     }
     
 } enError:^(NSError *error) {
     
 }];
    
    
        //self.secondImageArr = @[@"PP-R",@"阀门",@"水暖配件",@"电料",@"地暖材料",@"散热器",@"壁挂炉",@"空气能",@"风机盘管",@"锅炉",@"锅炉"].mutableCopy;
        self.threeImageArr = @[@"1暖通商城",@"import_cb"].mutableCopy;
      //  self.identifierArray = @[@"15",@"20",@"25",@"26",@"16",@"27",@"28",@"29",@"30",@"31"].mutableCopy;
    
    
      //
    NSString *url = [NSString stringWithFormat:@"%@api/disanfang.php",baseUrl];

    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:nil finish:^(id responseObject) {
        
        NSArray *dataArr = responseObject[@"data"];
        for (NSDictionary *dic in dataArr) {
            HomeItemsModel *model = [[HomeItemsModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.itemsModelArray addObject:model];
        }
        
    } enError:^(NSError *error) {
        
        
    }];
    

}
/**
 *创建tabbleView
 */
- (void)setUpTableView
{
    // 创建collectionView
    
    // 创建布局对象
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];

      self.collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0,0, KScreenW, kScreenH-64-49 ) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate  = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.flowLayout.headerReferenceSize = CGSizeMake(KScreenW, 150);
    // 注册headView
    [self.collectionView registerClass:[HomeReusableHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewIdentifier];
      [self.collectionView registerClass:[MinHeadElseReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewElseIdentifier];
    // 注册cell
    [self.collectionView registerClass:[HomeFistCell class] forCellWithReuseIdentifier:homeFrstCell];
    [self.collectionView registerClass:[HomeSecondCell class] forCellWithReuseIdentifier:homeSecondCell];
    [self.collectionView registerClass:[HomeThreeCell class] forCellWithReuseIdentifier:homeThreeCell];
    [self.view addSubview:self.collectionView];

    
    
}
#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section == 0) {
    
        self.flowLayout.itemSize = CGSizeMake(77*kWidthScale, 77*kWidthScale);
        
              }
    if (section == 1) {
        self.flowLayout.itemSize = CGSizeMake(60*kWidthScale,75*kHeightScale);
        return self.secondImageArr.count;
        
    }
    if (section == 2) {
        self.flowLayout.itemSize = CGSizeMake(77*kWidthScale, 90*kHeightScale);
        return 2;
        
    }


    return 4;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HomeFistCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeFrstCell forIndexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:self.firstImageArr[indexPath.row]];
    
        return cell;

    }
    if (indexPath.section == 1) {
        HomeSecondCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:homeSecondCell forIndexPath:indexPath];
 
            HomePicModel *model = self.secondImageArr[indexPath.row];
            NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.image]];
            [cell.imgView sd_setImageWithURL:url];
    
        return cell;
        
    }
    if (indexPath.section == 2) {
        HomeThreeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeThreeCell forIndexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:self.threeImageArr[indexPath.row]];
        return cell;
        
    }


    return 0;
   }
// 返回区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        
        if (indexPath.section == 0) {
            
            
            self.headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewIdentifier  forIndexPath:indexPath];

        
            return self.headView;
            
            
            
        }else if (indexPath.section ==1){
              self.headElseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewElseIdentifier  forIndexPath:indexPath];
            
           ShopClassHeadView *shopHeadView = [[ShopClassHeadView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 20*kHeightScale)];
          shopHeadView.titileNameLab.text = @"商品分类";
            [self.headElseView addSubview:shopHeadView];
        }else{
            self.headElseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewElseIdentifier  forIndexPath:indexPath];
            
            ShopThreeCooperationView *shopHeadView = [[ShopThreeCooperationView alloc]initWithFrame:CGRectMake(0, 10, KScreenW, 20*kHeightScale)];
            shopHeadView.titileNameLab.text = @"第三方合作平台";
            
            [self.headElseView addSubview:shopHeadView];
        }
        
        }
    return self.headElseView;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        OftenBuyViewController *oftenVC = [[OftenBuyViewController alloc]init];
       
        switch (indexPath.row) {
            case 0:{
                NSLog(@"收藏商品");
                StoreViewController *storeVC = [[StoreViewController alloc]init];
                
                 [self.navigationController pushViewController: storeVC animated:YES];
            }
                break;
            case 1:{
                NSLog(@"常购商品");
                 oftenVC.titleStr = @"常购商品";
               
                 [self.navigationController pushViewController:oftenVC animated:YES];
            }
                break;

            case 2:{
                NSLog(@"再次购买");
                
                SecondBuyGoodViewController *secondBuyGoodVC = [[SecondBuyGoodViewController alloc]init];
                [self.navigationController pushViewController:secondBuyGoodVC animated:YES];
            }
                break;

            case 3:{
                PhoneAccessViewController *phoneVC = [[PhoneAccessViewController alloc]init];
                [self.navigationController pushViewController:phoneVC animated:YES];

                NSLog(@"联系我们");
                            }
                break;

            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        if (indexPath.row <(self.secondImageArr.count - 1)) {
            ShopGoodsListViewController *shopGoodListVC = [[ShopGoodsListViewController alloc]init];
            HomePicModel *model = self.secondImageArr[indexPath.row];
            shopGoodListVC.cat_id = model.cat_id;
            [self.navigationController pushViewController:shopGoodListVC animated:YES];
        }else{
            NSString *start = [NSString stringWithFormat:@"%@",self.typeData[@"is_start"]];
            
            if ([start isEqualToString:@"1"]) {
                ShopGoodsListViewController *shopGoodListVC = [[ShopGoodsListViewController alloc]init];
                HomePicModel *model = self.secondImageArr[indexPath.row];
                shopGoodListVC.cat_id = model.cat_id;
                [self.navigationController pushViewController:shopGoodListVC animated:YES];
            }else{
                [GFProgressHUD showInfoMsg:@"此功能暂未开通"];
            }
        }
    
    }
    if (indexPath.section == 2) {
      
            // 点击进口壁挂炉
            HomeWebViewController *homeWebVC = [[HomeWebViewController alloc]init];
            HomeItemsModel *model = self.itemsModelArray[indexPath.row];
            homeWebVC.url = model.link_url;
        homeWebVC.titleStr = model.name;
        
            [self.navigationController pushViewController:homeWebVC animated:YES];
            
     
      
    }
}

// 设置区头高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLyout  referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(KScreenW, 180 *kHeightScale);
    }else if (section == 1){
        return CGSizeMake(KScreenW, 25);
    }else if (section == 2){
        return CGSizeMake(KScreenW, 25);

    }else{
        return CGSizeMake(KScreenW, 30);
}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  }


@end
