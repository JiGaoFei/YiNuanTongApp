//
//  SecondBuyGoodViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/26.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "SecondBuyGoodViewController.h"
#import "OrderNewTableViewCell.h"
#import "YNTUITools.h"
#import "OrderNewDetailViewController.h"
#import "YNTNetworkManager.h"
#import "OrderNewListSectionHeadView.h"
#import "OrderNewListSectionFooterView.h"
#import "OrderListSectionModel.h"
#import "OrderNewListModel.h"
#import "UIImageView+WebCache.h"
#import "OrderConfirmViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "YNTShopingCarViewController.h"
@interface SecondBuyGoodViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/**tableView*/
@property (nonatomic,strong) UITableView *tableView;
/**空数据视图*/
@property (nonatomic,strong) UIView  * emptyViews;
/**线*/
@property (nonatomic,strong) UILabel *lineLab;
/**选中按钮*/
@property (nonatomic,strong) UIButton  *selectBtn;
/**分区数组*/
@property (nonatomic,strong) NSMutableArray *sectionModelArr;
@end
static NSString *identier = @"orderNewCell";

@implementation SecondBuyGoodViewController

#pragma mark - 懒加载
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
    self.title = @"再次购买";
    // 加载数据
    [self loadData];
    
}

// 加载数据
- (void)loadData
{
     [self.emptyViews removeFromSuperview];
    // 清空数据源
    [self.sectionModelArr removeAllObjects];
    
    // 请求数据
    NSString *url = [NSString stringWithFormat:@"%@api/orderlist.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"page":@"1",@"status":@"4"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"请求订单列表数据成功%@",responseObject);
        //获取订单数据数组
        NSMutableArray *array = responseObject[@"order"];
        if (array.count == 0) {
            // 数据为空
            [self setUpEmptyViews];
          
        }else{
            [self.emptyViews removeFromSuperview];
            // 数据非空
            for (NSDictionary *dic in array) {
                OrderListSectionModel *model = [[OrderListSectionModel alloc]init];
                model.isOpen = NO;
                [model setValuesForKeysWithDictionary:dic];
                [self.sectionModelArr addObject:model];
            }
            
            if (self.tableView) {
                [self.tableView reloadData];
            }else{
                
                [self setUpTableView];
            }

            
            
            
        }
        
    
    
    } enError:^(NSError *error) {
        NSLog(@"请求订单列表数据失败%@",error);
    }];
    
}
// 创建tableView
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, KScreenW, kScreenH) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    // 注册cell
    [self.tableView registerClass:[OrderNewTableViewCell class] forCellReuseIdentifier:identier];
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OrderListSectionModel *sectionModel = self.sectionModelArr[section];
    
    if (sectionModel.isOpen) {
        return  sectionModel.goods.count;
    }else{
        return 0;
    }
    
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionModelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identier forIndexPath:indexPath];
    OrderListSectionModel *sectionModel = self.sectionModelArr[indexPath.section];
    
    for (NSDictionary *dic in sectionModel.goods) {
        OrderNewListModel *model = [[OrderNewListModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [sectionModel.modelArr addObject:model];
    }
    
    OrderNewListModel *model = sectionModel.modelArr[indexPath.row];
    
    [cell setValeuWithModel:model];
    // 取消cell的点击样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListSectionModel *sectionModel = self.sectionModelArr[indexPath.section];
    
    OrderNewDetailViewController *detailVC = [[OrderNewDetailViewController alloc]init];
    detailVC.oftenSettingTableBlock = ^(){
        self.tableView.frame = CGRectMake(0, 0, KScreenW, kScreenH);
    };
    detailVC.good_id = sectionModel.good_id;
    detailVC.orderPostStatus = @"4";
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90 *kHeightScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 110 *kHeightScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60 *kHeightScale;
}
//区尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    OrderNewListSectionFooterView *footerView =[[OrderNewListSectionFooterView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 70 *kHeightScale)];
    OrderListSectionModel *sectionModel = self.sectionModelArr[section];
    
    
    
    footerView.goodMoneyLab.text = [NSString stringWithFormat:@"¥%@",sectionModel.price];
    
    NSInteger status = [sectionModel.ord_status integerValue];
    switch (status) {
        case 0:
        {  // 已取消(可删除)
            footerView.deletOrderBtn.hidden = YES;
            [footerView.seconBuyBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            
        }
            break;
        case 1:
        {// 待付款
            footerView.deletOrderBtn.hidden = NO;
            [footerView.deletOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            
            [footerView.seconBuyBtn setTitle:@"去付款" forState:UIControlStateNormal];
            
        }
            break;
            
        case 2:
        {// 待发货
            footerView.deletOrderBtn.hidden = YES;
            [footerView.seconBuyBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        }
            break;
            
        case 3:
        {// 待收货
            footerView.deletOrderBtn.hidden = YES;
            [footerView.seconBuyBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        }
            break;
            
        case 4:
        {// 已完成
            footerView.deletOrderBtn.hidden = NO;
            [footerView.deletOrderBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            [footerView.seconBuyBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        }
            break;
            
            
        default:
            break;
    }
    
    
    
    footerView.deletOrderBtnBloock = ^()
    {
        NSLog(@"删除的回调");
        switch (status) {
            case 0:
            {// 已取消(删除订单)
                
            }
                break;
            case 1:
            {// 待付款(去付款)
                
                [self orderRequestDataWithOid:sectionModel.good_id andActstr:@"del" andActstr:@"删除订单"];
            }
                break;
            case 2:
            {//待发货
                
                
            }
                break;
            case 3:
            {// 待收货
                
                
                
            }
            case 4:
            {//已完成
                [self orderRequestDataWithOid:sectionModel.good_id andActstr:@"del" andActstr:@"删除订单"];
                
            }
                
                break;
                
            default:
                break;
        }
        
        
    };
    
    OrderConfirmViewController *orderConfirmVC = [[OrderConfirmViewController alloc]init];
    
    footerView.secondBuyBtnBloock = ^()
    {
        NSLog(@"再次购买回调");
        switch (status) {
            case 0:
            {// 已取消(删除订单)
                [self orderRequestDataWithOid:sectionModel.good_id andActstr:@"del" andActstr:@"删除订单"];
            }
                break;
            case 1:
            {// 待付款(去付款)
                
            }
                break;
            case 2:
            {//待发货
                [self orderRequestDataWithOid:sectionModel.good_id andActstr:@"zaimai" andActstr:@"再次购买"];
                [self.navigationController pushViewController:orderConfirmVC animated:YES];
                
            }
                break;
            case 3:
            {// 待收货
                [self orderRequestDataWithOid:sectionModel.good_id andActstr:@"zaimai" andActstr:@"再次购买"];
                [self.navigationController pushViewController:orderConfirmVC animated:YES];
                
            }
            case 4:
            {//已完成
                [self orderRequestDataWithOid:sectionModel.good_id andActstr:@"zaimai" andActstr:@"再次购买"];
        
                
            }
                
                break;
                
            default:
                break;
        }
        
    };
    
    
    return  footerView;
}
// 区头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OrderNewListSectionHeadView *sectionView =  [[OrderNewListSectionHeadView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 70 *kHeightScale)];
    OrderListSectionModel *sectionModel = self.sectionModelArr[section];
    
    sectionView.orderSnLab.text = [NSString stringWithFormat:@"订单编号:%@",sectionModel.sn];
    sectionView.orderTimeLab.text = [NSString stringWithFormat:@"下单时间:%@",sectionModel.done_time];
    
    NSInteger status = [sectionModel.ord_status integerValue];
    switch (status) {
        case 0:
        {  // 已取消(可删除)
            sectionView.statuLab.text = @"已取消";
        }
            break;
        case 1:
        {// 待付款
            sectionView.statuLab.text = @"待付款";
            
        }
            break;
            
        case 2:
        {// 待发货
            sectionView.statuLab.text = @"待发货";
            
        }
            break;
            
        case 3:
        {// 待收货
            sectionView.statuLab.text = @"待收货";
            
        }
            break;
            
        case 4:
        {// 已完成
            sectionView.statuLab.text = @"已完成";
            
        }
            break;
            
            
        default:
            break;
    }
    
    
    //  旋转按钮回调(折叠方式)
    sectionView.openBtnBloock = ^(BOOL isPen){
        if (sectionModel.isOpen) {
            
            
            // 控制折叠与展开
            sectionModel.isOpen = NO;
            [self.sectionModelArr replaceObjectAtIndex:section withObject:sectionModel];
            [self.tableView reloadData];
            
        }else{
            
            
            // 控制折叠与展开
            sectionModel.isOpen =YES;
            [self.sectionModelArr replaceObjectAtIndex:section withObject:sectionModel];
            [self.tableView reloadData];
            
            
            
        }
        
    };
    
    
    //  根据isOpen来判断要显示的图标
    if (sectionModel.isOpen) {
        UIImage *roateImg = [UIImage imageNamed:@"arrow_after"];
        roateImg = [roateImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [sectionView.openBtn setImage:roateImg forState:UIControlStateNormal];
    }else{
        UIImage *roateImg = [UIImage imageNamed:@"arrow_before"];
        roateImg = [roateImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [sectionView.openBtn setImage:roateImg forState:UIControlStateNormal];
        
    }
    
    
    return sectionView;
}
#pragma mark - 请求数据
/**
 @param status 请求状态
 @title 请求提示
 */
- (void)requestListData:(NSString *)status andTitle:(NSString *)title
{   // 清空数据源
    [self.sectionModelArr removeAllObjects];
    // 请求数据
    NSString *url = [NSString stringWithFormat:@"%@api/orderlist.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"page":@"1",@"status":status};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"%@数据成功%@",title,responseObject);
        //获取订单数据数组
        NSMutableArray *array = responseObject[@"order"];
        for (NSDictionary *dic in array) {
            OrderListSectionModel *model = [[OrderListSectionModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.sectionModelArr addObject:model];
        }
        if (self.tableView) {
            [self.tableView reloadData];
        }else{
            
            [self setUpTableView];
        }
        
    } enError:^(NSError *error) {
        NSLog(@"%@数据失败%@",title,error);
    }];
    
}
#pragma mark - 删除订单
/**
 @param Oid 订单id
 @param act 操作类型
 @param title 调取的是哪个接口
 */
- (void)orderRequestDataWithOid:(NSString *)Oid andActstr:(NSString *)act andActstr:(NSString *)title
{
    
    //清空数据源
    [self.sectionModelArr removeAllObjects];
    
    // 请求数据
    NSString *url = [NSString stringWithFormat:@"%@api/order.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":Oid,@"act":act};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"%@请求数据成功%@",title,responseObject);
    
        NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [GFProgressHUD showSuccess:responseObject[@"msg"]];
            
            if ([act isEqualToString:@"zaimai"]) {
                YNTShopingCarViewController *shopCarVC = [[YNTShopingCarViewController alloc]init];
                [self.navigationController pushViewController:shopCarVC animated:YES];
            }
            if ([act isEqualToString:@"del"]) {
                [self loadData];
            }

        }
        
            

        
       
    } enError:^(NSError *error) {
        NSLog(@"%@请求数据成功%@",title,error);
        
    }];
    
    
}

#pragma mark - 空数据处理

- (void)setUpEmptyViews
{
    self.emptyViews = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, kScreenH)];
    self.emptyViews.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.emptyViews];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW / 2 - 50 *kWidthScale, 133 *kHeightScale, 100 *kWidthScale, 124 *kHeightScale)];
    imgView.image = [UIImage imageNamed:@"orde_-list_-empty"];
    [self.emptyViews addSubview:imgView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(65 *kWidthScale, 296 *kHeightScale, KScreenW - 130 *kWidthScale, 16*kHeightScale)];
    titleLab.font = [UIFont systemFontOfSize:16 *kHeightScale];
    titleLab.text = @"空空的,去挑几件好货吧!";
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
    [self.navigationController popViewControllerAnimated:YES];
}

@end
