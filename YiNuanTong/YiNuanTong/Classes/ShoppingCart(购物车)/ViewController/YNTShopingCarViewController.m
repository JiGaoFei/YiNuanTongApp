//
//  YNTShopingCarViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/4/6.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTShopingCarViewController.h"
#import "GFShopTableViewCell.h"
#import "ShopSectionHeadView.h"
#import "ShopSectionFooterView.h"
#import "ShopBottomView.h"
#import "YNTNetworkManager.h"
#import "ShopCarModel.h"
#import "ShopSectionModel.h"
#import "UIImageView+WebCache.h"
#import "OrderConfirmViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "YNTHomeViewController.h"
@interface YNTShopingCarViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/**创建tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**存放分区model*/
@property (nonatomic,strong) NSMutableArray  *sectionModelArr;
/**存取*/
@property (nonatomic,assign) NSInteger  section;
/**数量*/
@property (nonatomic,assign) double zongnum;
/**总价*/
@property (nonatomic,assign) double zongprice;
/**分区数量*/
@property (nonatomic,assign) NSInteger  sectionNum;
/**分区总价*/
@property (nonatomic,assign) NSInteger sectionPrice;
/**是否控制全选*/
@property (nonatomic,copy) NSString *isAllSelect;
/**底部视图*/
@property (nonatomic,strong) ShopBottomView *shopBottomView;
/** empty视图 */
@property (nonatomic,strong) UIView *emptyViews;

/**cell中num的数量*/
@property (nonatomic,copy) NSString *goodsNum;
/**是否折叠*/
@property (nonatomic,assign) BOOL isFold;
@end
static NSString *identifier = @"shopCell";
@implementation YNTShopingCarViewController

#pragma mark -懒加载
- (NSMutableArray *)sectionModelArr
{
    if (!_sectionModelArr) {
        self.sectionModelArr = [[NSMutableArray alloc]init];
    }
    return _sectionModelArr;
}
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"进货单";
    self.isFold = NO;
    
    [self setUpNavRightBtn];
    [self setUpTableView];
    [self shopBottomView];
    
}
// 加载数据
- (void)loadData
{
    UserInfo *userInfo = [UserInfo currentAccount];
    NSString *url = [NSString stringWithFormat:@"%@api/catinfo.php",baseUrl];
    NSDictionary *param =@{@"user_id":userInfo.user_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"请求购物车列表数据成功%@",responseObject);
  
        self.isAllSelect = responseObject[@"is_allselect"];
        self.zongnum = [[NSString stringWithFormat:@"%@",responseObject[@"zongnum"]] doubleValue];
        self.zongprice = [[NSString stringWithFormat:@"%@",responseObject[@"zongprice"]] doubleValue];
        
        
      // 为bottom赋值
        [self setValueBottomeWithdata:responseObject];
        
        NSArray *arr = responseObject[@"cart_goods"];
        
        [self.sectionModelArr removeAllObjects];
        for (NSDictionary *dic in arr) {
            ShopSectionModel *model = [[ShopSectionModel alloc]init];
            // 用来控制是否要展示
            model.isOpen = YES;
            [model setValuesForKeysWithDictionary:dic];
            [self.sectionModelArr addObject:model];
        }
        
        
        if (self.tableView) {
            
            [self.tableView reloadData];
            [self.emptyViews removeFromSuperview];
    
        }else{
            // 加载tableView
            [self setUpTableView];
         
    
            
        }
        if (self.sectionModelArr.count >0) {
        [self.emptyViews removeFromSuperview];
        [self setUpBottomView];
        }
        
//        if (self.sectionModelArr.count == 0) {
//            [self.shopBottomView removeFromSuperview];
//        }
        
    } enError:^(NSError *error) {
        NSLog(@"请求购物车列表数据失败%@",error);
    }];
}
#pragma mark - 创建折叠按钮
- (void)setUpNavRightBtn
{
    
    //折叠
    UIBarButtonItem *rightBtn1 = [[UIBarButtonItem alloc] initWithTitle:@"删除"
                                                             style:  UIBarButtonItemStyleDone
                                                            target:self
                                                                 action:@selector(deleteBarButtonItemAction)];

    
    //删除
    UIBarButtonItem *rightBtn2 = [[UIBarButtonItem alloc] initWithTitle:@"折叠"
                                                             style: UIBarButtonItemStyleDone
                                                            target:self
                                                            action:@selector(foldBarButtonItemAction)];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightBtn1, rightBtn2, nil];



}
// 折叠按钮点击事件
- (void)foldBarButtonItemAction{
        NSLog(@"折叠");
    if (self.isFold) {
        self.isFold = NO;
    }else{
        self.isFold = YES;
    }
    [self.tableView reloadData];
}
// 删除按钮的点击
- (void)deleteBarButtonItemAction
{
    NSLog(@"删除");
    UserInfo *userInfo = [UserInfo currentAccount];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"act":@"delete"};
    [self selectRequestData:params andtitle:@"多选删除" AndIsRefresh:YES];
    
}

//创建tableView
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH-50) style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerClass:[GFShopTableViewCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:self.tableView];
}
- (void)setUpEmptyViews
{
    self.emptyViews = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, kScreenH)];
    [self.view addSubview:self.emptyViews];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW / 2 - 50 *kWidthScale, 133 *kHeightScale, 100 *kWidthScale, 124 *kHeightScale)];
    imgView.image = [UIImage imageNamed:@"orde_-list_-empty"];
    [self.emptyViews addSubview:imgView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(65 *kWidthScale, 296 *kHeightScale, KScreenW - 130 *kWidthScale, 16*kHeightScale)];
    titleLab.font = [UIFont systemFontOfSize:16 *kHeightScale];
    titleLab.text = @"进货单空空的,去挑几件好货吧!";
    titleLab.textColor = RGBA(102, 102, 102, 1);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.emptyViews addSubview:titleLab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(147 *kWidthScale, 330 *kHeightScale, 80 *kWidthScale, 30 *kHeightScale);
    [btn setImage:[UIImage imageNamed:@"orde_-list_-empty_casually_browse"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.emptyViews addSubview:btn];
    
    
}
- (void)goButAction:(UIButton *)sender
{
    self.tabBarController.selectedIndex = 0;
}
// 创建底部按钮
- (void)setUpBottomView
{
    self.shopBottomView = [[ShopBottomView alloc]initWithFrame:CGRectMake(0,kScreenH - 52*kHeightScale - 49, KScreenW, 52*kHeightScale)];
    // 为总价赋值
    _shopBottomView.bottomPriceLab.text = [NSString stringWithFormat:@"总价:￥%.2f",self.zongprice];
    // 为总数赋值
   _shopBottomView.allNumberLab.text = [NSString stringWithFormat:@"共:%f件",self.zongnum];
  
    _shopBottomView.backgroundColor = [UIColor whiteColor];
    // 为全选按钮赋图片
    if ([self.isAllSelect isEqualToString:@"0"]) {
        [self.shopBottomView.allSelectBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];

    }
    
    if ([self.isAllSelect isEqualToString:@"1"]) {
        [self.shopBottomView.allSelectBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
        
    }

//    if (self.isAllSelect) {
//  
//        [self.shopBottomView.allSelectBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
//    }else{
//        [self.shopBottomView.allSelectBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
//    }
    
        UserInfo *userInfo = [UserInfo currentAccount];
    __weak typeof(self)weakSelf = self;
    _shopBottomView.payBtnBlook = ^(){
        NSLog(@"结算回调出来");
        // 结算请求数据
        [weakSelf payBtnRequestData];
    };
    __weak typeof(_shopBottomView)shopSelf = _shopBottomView;
    // 全选按钮的回调
    _shopBottomView.allSelectBtnBloock = ^(NSInteger index){
        
        if ([weakSelf.isAllSelect isEqualToString:@"1"]) {
            NSDictionary *params = @{@"user_id":userInfo.user_id,@"select":@"0",@"act":@"select"};
            
            [weakSelf selectRequestData:params andtitle:@"取消全选" AndIsRefresh:YES ];
            [shopSelf.allSelectBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        }
        if ([weakSelf.isAllSelect isEqualToString:@"0"]) {
            NSDictionary *params = @{@"user_id":userInfo.user_id,@"select":@"1",@"act":@"select"};
            
            [weakSelf selectRequestData:params andtitle:@"全选" AndIsRefresh:YES ];
              [shopSelf.allSelectBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
        
        }

//        NSLog(@"取消全选");
//        switch (index) {
//            case 0:
//            {
//                
//         
//                            NSDictionary *params = @{@"user_id":userInfo.user_id,@"select":@"0",@"act":@"select"};
//                
//                            [weakSelf selectRequestData:params andtitle:@"取消全选" AndIsRefresh:YES ];
//            }
//                break;
//            case 1:
//            {
//    
//            // 取消选中
//            NSDictionary *params = @{@"user_id":userInfo.user_id,@"select":@"1",@"act":@"select"};
//                            [weakSelf selectRequestData:params andtitle:@"全选" AndIsRefresh:YES];
//
//            }
//                break;
//                
//            default:
//                break;
//        }
//        
    };
    
    [self.view addSubview:_shopBottomView];
  }
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ShopSectionModel *model = self.sectionModelArr[section];
    // 根据折叠
    if (self.isFold) {
        return 0;
    }else{
        if (model.isOpen) {
            return model.good_attr.count;
        }else{
            return 0;
        }

    }
    
    
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return self.sectionModelArr.count;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShopSectionHeadView *shopHeadView =[[ShopSectionHeadView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 95 *kHeightScale)];
    
    ShopSectionModel *model = self.sectionModelArr[section];
    [shopHeadView.goodImgView sd_setImageWithURL:[NSURL URLWithString:model.good_img]];
    shopHeadView.goodNameLab.text = model.good_name;
    shopHeadView.backgroundColor = [UIColor whiteColor];
    
    UserInfo *userInfo = [UserInfo currentAccount];
    shopHeadView.numberTextField.text = model.num;
    // 加号点击事件
    shopHeadView.addBtnBloock = ^(NSString *str){
        
        NSLog(@"加号回调");
        NSDictionary *param = @{@"act":@"edit",@"user_id":userInfo.user_id,@"num":@"1",@"cat_id":model.cat_id};
        [self modifyGoodNumbRequestData:param andtitle:@"加号"];
    };
    // 减号点击事件
    shopHeadView.cutBtnBloock = ^(NSString *str){
        NSLog(@"减号回调");
        NSDictionary *param = @{@"act":@"edit",@"user_id":userInfo.user_id,@"num":@"-1",@"cat_id":model.cat_id};
        [self modifyGoodNumbRequestData:param andtitle:@"加号"];
    };
    
    
    //无属性的时候要隐藏
    if (model.good_attr.count == 0) {
        shopHeadView.roateBtn.hidden = YES;
    }else{
        shopHeadView.addBtn.hidden = YES;
        shopHeadView.cutBtn.hidden = YES;
        shopHeadView.numberTextField.hidden = YES;
        shopHeadView.addImgView.hidden = YES;
    }
       // 有属性的时候隐藏加减
    
    
    // 根据isOpen来判断要显示的图标
    if (model.isOpen) {
        UIImage *roateImg = [UIImage imageNamed:@"arrow_after@3x"];
        roateImg = [roateImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [shopHeadView.roateBtn setImage:roateImg forState:UIControlStateNormal];
    }else{
        UIImage *roateImg = [UIImage imageNamed:@"arrow_before@3x"];
        roateImg = [roateImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [shopHeadView.roateBtn setImage:roateImg forState:UIControlStateNormal];

    }
    

    
    if (model.good_sele ) {
        
        [shopHeadView.selectBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
        
    }else{
        [shopHeadView.selectBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        
    }
   // __weak typeof(shopHeadView)weakSelf = shopHeadView;
    // 点击标题全选
  
    shopHeadView.shopSectionBtn = ^(NSInteger index){
        
        if (model.good_sele ) {
            NSDictionary *params = @{@"user_id":userInfo.user_id,@"select":@"0",@"act":@"select",@"cat_id":model.cat_id};
            [self selectRequestData:params andtitle:@"分组取消全选" AndIsRefresh:NO];
        }else{
            NSDictionary *params = @{@"user_id":userInfo.user_id,@"select":@"1",@"act":@"select",@"cat_id":model.cat_id};
            
            [self selectRequestData:params andtitle:@"分组全选" AndIsRefresh:NO];

        }

        
        
        
        
        
    };
    
    //  旋转按钮回调(折叠方式)
    shopHeadView.roateSectionBtn = ^(BOOL isPen){
        if (model.isOpen) {
            
            // 当标题选中的时候所有的都选中
            if (model.good_sele) {
                // 遍历分区中数值
                for (int i = 0 ; i< model.modelArr.count; i++) {
                    ShopCarModel *model1 = model.modelArr[i];
                    model1.attr_select = YES;
                    [model.modelArr replaceObjectAtIndex:i withObject:model1];
                }
                
            }else{  // 当标题没有选中的时候所有的都不选中
                
                for (int i = 0 ; i< model.modelArr.count; i++) {
                    ShopCarModel *model1 = model.modelArr[i];
                    model1.attr_select = NO;
                    [model.modelArr replaceObjectAtIndex:i withObject:model1];
                }
                
            }
            
            // 控制折叠与展开
            model.isOpen = NO;
            [self.sectionModelArr replaceObjectAtIndex:section withObject:model];
          [self.tableView reloadData];
            
        }else{
            
            
            
            
            // 当标题选中的时候所有的都选中
            if (model.good_sele) {
                // 遍历分区中数值
                for (int i = 0 ; i< model.modelArr.count; i++) {
                    ShopCarModel *model1 = model.modelArr[i];
                    model1.attr_select = YES;
                    [model.modelArr replaceObjectAtIndex:i withObject:model1];
                }
                
            }else{   // 当标题没有选中的时候所有的都不选中
                for (int i = 0 ; i< model.modelArr.count; i++) {
                    ShopCarModel *model1 = model.modelArr[i];
                    model1.attr_select = NO;
                    [model.modelArr replaceObjectAtIndex:i withObject:model1];
                }
                
            }
            
            // 控制折叠与展开
            model.isOpen =YES;
            [self.sectionModelArr replaceObjectAtIndex:section withObject:model];
            [self.tableView reloadData];
            
            
            
        }
        
    };
    return shopHeadView;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    ShopSectionFooterView *shopFooterView = [[ShopSectionFooterView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 32 *kHeightScale)];
    shopFooterView.backgroundColor = [UIColor whiteColor];
    // 获取对应分区的sectionModel
    ShopSectionModel *sectionModel = self.sectionModelArr[section];
    
    if (sectionModel.good_attr.count == 0) {    // 无属性时
       shopFooterView.goodNumberLab.text = [NSString stringWithFormat:@"共%ld件",(long)sectionModel.good_num];
        double price = [sectionModel.price doubleValue];
        double num = [sectionModel.num doubleValue];
        double totallmoney = price *num;
        shopFooterView.goodPriceLab.text = [NSString stringWithFormat:@"¥%.2f",totallmoney];
    }else{
        // 有属性时
         shopFooterView.goodNumberLab.text = [NSString stringWithFormat:@"共%ld种%ld件",(long)sectionModel.good_zhong,(long)sectionModel.good_num];
        
        NSString * goodPrice = [NSString stringWithFormat:@"%.2f",sectionModel.good_price];
        double price = [goodPrice doubleValue];
        
        shopFooterView.goodPriceLab.text = [NSString stringWithFormat:@"¥%.2f",price];
    }
    
    
    shopFooterView.backgroundColor = [UIColor whiteColor];
//    if (sectionModel.good_attr.count ==0) {
// 
//        //计算选中的总价
//        double danjia = [sectionModel.price doubleValue];
//        sectionPrice += ([sectionModel.num doubleValue]) *danjia;
//    }else{
//    
//        // 清空
//        [sectionModel.modelArr removeAllObjects];
//        // 获取cell中的model
//        for (NSDictionary *dic in sectionModel.good_attr) {
//            ShopCarModel *model = [[ShopCarModel alloc]init];
//            [model setValuesForKeysWithDictionary:dic];
//            
//            // 计算分区中选中的总价
//            if (model.attr_select  == YES) {
//                //计算选中的总价
//                double danjia = [model.attrprice doubleValue];
//                sectionPrice += ([model.num doubleValue]) *danjia;
//            }
//            //   NSLog(@"%ld分区:%d",section ,model.attr_select);
//            [sectionModel.modelArr addObject:model];
//        }
//
//    }
//    
    
    //NSLog(@"%ld分区的总价:%ld",section,sectionPrice);
    
//    shopFooterView.goodNumberLab.text = [NSString stringWithFormat:@"共:%ld件",(long)sectionModel.good_num];
//    shopFooterView.goodPriceLab.text =[NSString stringWithFormat:@"￥%.2f",sectionPrice];
    return shopFooterView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 105 *kHeightScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 32 *kHeightScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75 *kHeightScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GFShopTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    __weak typeof(cell)cellSelf = cell;
    cell.selectionStyle = UITableViewCellAccessoryNone;
    // 获取对应分区模型
    ShopSectionModel *sectionModel = self.sectionModelArr[indexPath.section];
    // 获取对应分组数据源
    for (NSDictionary *dic in sectionModel.good_attr) {
        ShopCarModel *model = [[ShopCarModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [sectionModel.modelArr addObject:model];
    }
    // 分区对应row的模型
    ShopCarModel *model = sectionModel.modelArr[indexPath.row];
    // 赋值
    cell.shopNameLabel.text = model.namestr;
    cell.shopPriceLabel.text = model.attrprice;
    cell.numberTextField.text = model.num;
  
    UserInfo *userInfo = [UserInfo currentAccount];
    // 点击加号
    cell.addBtnBloock = ^(NSString *str){
        NSLog(@"加号数量为:%@",str);
          NSDictionary *param = @{@"act":@"edit",@"user_id":userInfo.user_id,@"num":@"1",@"cat_attrid":model.cat_attrid};
        [self modifyGoodNumbRequestData:param andtitle:@"加号"];
    };
    // 点击减号
    cell.cutBtnBloock = ^(NSString *str){
        NSLog(@"减号数量为:%@",str);
        NSDictionary *param = @{@"act":@"edit",@"user_id":userInfo.user_id,@"num":@"-1",@"cat_attrid":model.cat_attrid};
        [self modifyGoodNumbRequestData:param andtitle:@"减号"];


    };
    
    //监听实时num的值
    cell.numberTextFiledInputText = ^(NSString *str){
        self.goodsNum = str;
    };
    
   
    
    // 点击完成时的数
    cell.confirmBtnBlock = ^(){
        NSInteger currentNember = [self.goodsNum integerValue];
        NSInteger  netNumber = [model.num  integerValue];
        NSInteger resultNumber = (currentNember - netNumber);
        NSLog(@"数量变化了:%ld",(long)resultNumber);
        NSLog(@"我是完成按钮的回调");
        NSString *resultStr = [NSString stringWithFormat:@"%ld",(long)resultNumber];
        NSDictionary *param = @{@"act":@"edit",@"user_id":userInfo.user_id,@"num":resultStr,@"cat_attrid":model.cat_attrid};
        [self modifyGoodNumbRequestData:param andtitle:@"完成"];

    };
    
    
    
    
    // 根据选中状态设置勾选按钮的图标
        if (model.attr_select) {
                
            [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
               }else{
            [cell.selectBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
         
               }
    
 
    
    cell.selectBtnBlock = ^(BOOL isSelect){
        
                  if (model.attr_select) { // 如果之前选中,点击后取消选中
                    //  model.attr_select = NO;
//                      [sectionModel.modelArr replaceObjectAtIndex:indexPath.row withObject:model];
//                       [self.sectionModelArr replaceObjectAtIndex:indexPath.section withObject:sectionModel];
                           [cellSelf.selectBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
           
                      
                      // 请求参数
                      NSDictionary *params = @{@"user_id":userInfo.user_id,@"cat_attrid":model.cat_attrid,@"select":@"0",@"act":@"select"};
                    [self selectRequestData:params andtitle:@"row取消选中" AndIsRefresh:NO];
                 
                        NSLog(@"取消选中%d", model.attr_select);
                      
                  }else{//如果之前为非选中,点击后为选中
                     // model.attr_select = YES;
//                      [sectionModel.modelArr replaceObjectAtIndex:indexPath.row withObject:model];
//                      [self.sectionModelArr replaceObjectAtIndex:indexPath.section withObject:sectionModel];
                     [cellSelf.selectBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
             

                      // 请求参数
                      NSDictionary *params = @{@"user_id":userInfo.user_id,@"cat_attrid":model.cat_attrid,@"select":@"1",@"act":@"select"};
                      [self selectRequestData:params andtitle:@"row选中" AndIsRefresh:NO];
                  

                       NSLog(@"已经选中%d", model.attr_select);
                  }
                  
        
        
        
        
                  };

    
    return cell;
}
#pragma mark - 选中请求数据
- (void)selectRequestData:(NSDictionary *)params andtitle:(NSString *)title AndIsRefresh:(BOOL) isRefresh
{
    NSString *url = [NSString stringWithFormat:@"%@/api/catinfo.php",baseUrl];
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"%@数据请求成功********%@",title,responseObject);
        

        
        [self loadData];

    } enError:^(NSError *error) {
         NSLog(@"%@数据请求失败%@",title,error);
    }];
    
}
#pragma mark - 修改数量请求数据
- (void)modifyGoodNumbRequestData:(NSDictionary *)params andtitle:(NSString *)title
{
    NSString *url = [NSString stringWithFormat:@"%@/api/catinfo.php",baseUrl];
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"%@数据请求成功********%@",title,responseObject);
      
            [self loadData];
     
        
    } enError:^(NSError *error) {
        NSLog(@"%@数据请求失败%@",title,error);
    }];

}

#pragma mark - 结算请求数据 
- (void)payBtnRequestData
{
    
    
    NSString *url = [NSString stringWithFormat:@"%@api/checkorder.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"directbuy":@"0"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"确认订单请求数据成功%@",responseObject);
        
       
        
        NSArray *arr = responseObject[@"cart_goods"];
        
        if (arr.count >0) {
            OrderConfirmViewController *orderConfirmVc = [[OrderConfirmViewController alloc]init];
            orderConfirmVc.directbuy = @"0";
            [self.navigationController pushViewController:orderConfirmVc animated:YES];
        }else{
            [GFProgressHUD showFailure:@"请选择您要购买的商品!"];
        }
        
     

              
    } enError:^(NSError *error) {
        NSLog(@"确认订单请求数据失败%@",error);
    }];

    
    
    
    

}

#pragma mark - 为bottomView赋值
- (void)setValueBottomeWithdata:(NSDictionary *)dic
{
    // 为总价赋值
    _shopBottomView.bottomPriceLab.text = [NSString stringWithFormat:@"总价:￥%@",dic[@"zongprice"]];
    // 为总数赋值
    _shopBottomView.allNumberLab.text = [NSString stringWithFormat:@"共:%@件",dic[@"zongnum"]];
    _shopBottomView.backgroundColor = [UIColor whiteColor];
    // 为全选按钮赋图片
    if (!dic[@"zongprice"]) {
         _shopBottomView.bottomPriceLab.text = @"总价:￥0";
    }
    self.isAllSelect = [NSString stringWithFormat:@"%@",dic[@"is_allselect"]];
    
    if ([self.isAllSelect isEqualToString:@"0"]) {
         [self.shopBottomView.allSelectBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        // 为总数赋值
        _shopBottomView.allNumberLab.text = [NSString stringWithFormat:@"共:0件"];
    }
    
    if ([self.isAllSelect isEqualToString:@"1"]) {
        [self.shopBottomView.allSelectBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
 
    }
    
    
    

}
#pragma mark - 数据为空时处理
- (void)emptyDataOperation
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"空空哒,快去逛逛吧!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.tabBarController.selectedIndex = 0;
    }];
    [alertVC addAction:action];
    [self.navigationController pushViewController:alertVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
