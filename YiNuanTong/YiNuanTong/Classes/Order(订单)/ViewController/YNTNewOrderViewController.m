//
//  YNTNewOrderViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "YNTNewOrderViewController.h"
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
#import "PayDetailViewController.h"
#import "Order.h"
#import <DZNEmptyDataSet/DZNEmptyDataSet-umbrella.h>
#import "YNTShopingCarViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "HomeGoodListSingLeton.h"
@interface YNTNewOrderViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/**tableView*/
@property (nonatomic,strong) UITableView *tableView;
/**paydic*/
@property (nonatomic,strong) NSMutableDictionary *payDic;
/**emptyViews*/
@property (nonatomic,strong) UIView  * emptyViews;
/**线*/
@property (nonatomic,strong) UILabel *lineLab;
/**选中按钮*/
@property (nonatomic,strong) UIButton  *selectBtn;
/**分区数组*/
@property (nonatomic,strong) NSMutableArray *sectionModelArr;
/**当前状态*/
@property (nonatomic,copy) NSString *currentStatus;
/** 订单编号 */
@property (nonatomic,copy) NSString *orderSn;
/** 订单金额 */
@property (nonatomic,copy) NSString *orderMoney;
@end
static NSString *identier = @"orderNewCell";
@implementation YNTNewOrderViewController
#pragma mark - 懒加载
- (NSMutableDictionary *)payDic
{
    if (!_payDic) {
        self.payDic = [[NSMutableDictionary alloc]init];
    }
    return _payDic;
}
 - (NSMutableArray *)sectionModelArr
{
    if (!_sectionModelArr) {
        self.sectionModelArr = [[NSMutableArray alloc]init];
    }
    return _sectionModelArr;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的订单";
    self.currentStatus = @"0";
    // 加载数据
    [self loadData];
    
//    // 获取通知中心对象
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    // 添加当前类对象为一个观察者,name 和obeject设置为nil,表示接收一切消息
//    [center addObserver:self selector:@selector(receiveNotificiation:) name:@"aliPayReslut" object:nil];
//    
//    [center addObserver:self selector:@selector(wexinPaySuccesAction:) name:@"wexinResult" object:nil];

}

//#pragma mark - 支付成功时候的回调
//- (void)receiveNotificiation:(NSNotification*)info{
//    NSLog(@"%@",info);
//    
//    
//    NSDictionary *dataDic = info.userInfo;
//    PayDetailViewController *payDetailViewVC = [[PayDetailViewController alloc]init];
//    // 没有商品名称
//    payDetailViewVC.shopName =@"测试数据";
//    payDetailViewVC.orderNumber =dataDic[@"out_trade_no"];
//    payDetailViewVC.tradingTime =dataDic[@"timestamp"];
//    payDetailViewVC.payStatus = @"已支付";
//    payDetailViewVC.payType = @"支付宝";
//    payDetailViewVC.money = dataDic[@"total_amount"];
//    [self.navigationController pushViewController:payDetailViewVC animated:YES];
//}
//#pragma makr - 微信支付成功的回调
//- (void)wexinPaySuccesAction:(NSNotification *)info
//{ UserInfo *userinfo = [UserInfo currentAccount];
//    NSString *url = [NSString stringWithFormat:@"%@api/wxappnotify.php",baseUrl];
//    NSDictionary *params = @{@"user_id":userinfo.user_id,@"order_id":info.userInfo[@"order_id"]};
//    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
//        NSLog(@"微信支付回调请求数据成功%@",responseObject);
//        if ([responseObject[@"pay_status"] isEqualToString:@"1"]) {
//            NSDictionary *dataDic = [NSDictionary dictionaryWithDictionary:responseObject];
//            PayDetailViewController *payDetailViewVC = [[PayDetailViewController alloc]init];
//            // 没有商品名称
//            payDetailViewVC.shopName =@"测试数据";
//            payDetailViewVC.orderNumber =dataDic[@"sn"];
//            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateStyle:NSDateFormatterMediumStyle];
//            [formatter setTimeStyle:NSDateFormatterShortStyle];
//            [formatter setDateFormat:@"yyyyMMddHHMMss"];
//            NSDate *date = [formatter dateFromString:dataDic[@"pay_time"]];
//            payDetailViewVC.tradingTime =[NSString stringWithFormat:@"%@",date];
//            payDetailViewVC.payStatus = @"已支付";
//            payDetailViewVC.payType = @"微信";
//            payDetailViewVC.money = dataDic[@"pay_fee"];
//            [self.navigationController pushViewController:payDetailViewVC animated:YES];
//            
//        }
//        
//    } enError:^(NSError *error) {
//        NSLog(@"微信支付回调请求数据失败%@",error);
//    }];
//}
// 加载数据
- (void)loadData
{
    // 清空数据源
    [self.sectionModelArr removeAllObjects];
    
    // 请求数据
    NSString *url = [NSString stringWithFormat:@"%@api/orderlist.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"page":@"1" ,@"status"
                             :self.currentStatus};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"请求订单列表数据成功%@",responseObject);
        //获取订单数据数组
        NSMutableArray *array = responseObject[@"order"];
        if (array.count == 0) {
            [self.emptyViews removeFromSuperview];
            // 无数据
            [self setUpEmptyViews];
        }else{
            // 移除空视图
            [self.emptyViews removeFromSuperview];
            // 有数据
            for (NSDictionary *dic in array) {
                OrderListSectionModel *model = [[OrderListSectionModel alloc]init];
                model.isOpen = NO;
                [model setValuesForKeysWithDictionary:dic];
                [self.sectionModelArr addObject:model];
            }
            
            if (self.tableView) {
                [self.tableView reloadData];
            }else{
                [self setUpTitleBtn];
                [self setUpTableView];
            }

        }
           } enError:^(NSError *error) {
        NSLog(@"请求订单列表数据失败%@",error);
    }];

}
// 创建订单标题
- (void)setUpTitleBtn
{
    NSArray *arr = @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成"];
    for (int i = 0; i<arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 408+i;
        btn.frame = CGRectMake(i * KScreenW / arr.count, 75 *kHeightScale, KScreenW / arr.count, 15 *kHeightScale);
        if (i == 0) {
            self.selectBtn = btn;
               [btn setTitleColor:RGBA(52, 162, 252, 1) forState:UIControlStateNormal];
        }else{
             [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
       

        [btn addTarget:self action:@selector(titleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
    // 蓝色线条
    self.lineLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 95*kHeightScale, KScreenW /arr.count, 2*kHeightScale)];
    self.lineLab.backgroundColor =RGBA(52, 162, 252, 1) ;
    [self.view addSubview:self.lineLab];
}
- (void)titleBtnAction:(UIButton *)sender
{
      [self.selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sender setTitleColor:RGBA(52, 162, 252, 1) forState:UIControlStateNormal];

   self.currentStatus = [NSString stringWithFormat:@"%ld",(sender.tag - 408)];
    NSMutableArray *arry= @[@"全部",@"待付款",@"待发货",@"待收货",@"已完成"].mutableCopy;
    [self requestListData:self.currentStatus andTitle:arry[(sender.tag - 408)]];
    
   [ UIView animateWithDuration:0.5 animations:^{
       CGRect rec = self.lineLab.frame;
       rec.origin.x = (sender.tag - 408) *KScreenW/5;
       self.lineLab.frame = rec;
   }];
     self.selectBtn = sender;
    
}
// 创建tableView
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100*kHeightScale, KScreenW, kScreenH-150) style:UITableViewStyleGrouped];
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
    detailVC.operationSuccessBlock = ^(){
        // 回调刷新
        self.currentStatus = @"";
        [self loadData];
    };
    detailVC.good_id = sectionModel.good_id;
    detailVC.orderPostStatus= [NSString stringWithFormat:@"%@",sectionModel.ord_status];
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
 
    
    footerView.goodNumLab.text = [NSString stringWithFormat:@"共%@种%@件",sectionModel.zhong_num,sectionModel.all_num];
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
            [footerView.seconBuyBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
        }
            break;
            
        case 3:
        {// 待收货
            [footerView.deletOrderBtn setTitle:@"再次购买" forState:UIControlStateNormal];
            [footerView.seconBuyBtn setTitle:@"确认收货" forState:UIControlStateNormal];
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
            {
                // 待付款(去付款)
                [self operationOrderWithAct:@"quxiao" andGood_id:sectionModel.good_id];
          
            }
                break;
            case 2:
            {//待发货
                
                
            }
                break;
            case 3:
            {// 待收货
          
    
               
                [self secondBuyRequestDataWithGoodID:sectionModel.good_id];
                
            }
                 break;
            case 4:
            {//已完成
                
                [self operationOrderWithAct:@"del" andGood_id:sectionModel.good_id];
                
            }
                
                break;
                
            default:
                break;
        }
      
     
    };
    

    
    footerView.secondBuyBtnBloock = ^()
    {
        NSLog(@"再次购买回调");
            switch (status) {
            case 0:
            {// 已取消(删除订单)
                  [self operationOrderWithAct:@"del" andGood_id:sectionModel.good_id];
            }
                break;
            case 1:
            {// 待付款(去付款)
                self.orderSn = sectionModel.sn;
                self.orderMoney = sectionModel.price;
                [self payRequestDataWithOrderID:sectionModel.good_id];
                
            }
                break;
            case 2:
            {//待发货
                [GFProgressHUD showSuccess:@"提醒发货成功"];
            }
                break;
            case 3:
            {// 待收货
               
                [self operationOrderWithAct:@"queren" andGood_id:sectionModel.good_id];

                
            }
            break;
                    
            case 4:
            {//已完成
                   [self operationOrderWithAct:@"zaimai" andGood_id:sectionModel.good_id];
              
           
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
//        NSMutableArray *arr = [[NSMutableArray alloc]init];
//        for (  OrderListSectionModel *model in self.sectionModelArr) {
//            NSString *str = [NSString stringWithFormat:@"%@",model.ord_status];
//            if ([str isEqualToString:self.currentStatus]) {
//                [arr addObject:model];
//            }
//        }
//        if (arr.count == 0) {
//            [self emptyDataOperation];
//        }

        NSMutableArray *array = responseObject[@"order"];
        if (array.count == 0) {
            [self.emptyViews removeFromSuperview];
            [self setUpEmptyViews];
        }else{
            //  移除空视图
            [self.emptyViews removeFromSuperview];
            for (NSDictionary *dic in array) {
                OrderListSectionModel *model = [[OrderListSectionModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.sectionModelArr addObject:model];
            }
            if (self.tableView) {
                [self.tableView reloadData];
            }else{
                [self setUpTitleBtn];
                [self setUpTableView];
            }

        }
       
    } enError:^(NSError *error) {
        NSLog(@"%@数据失败%@",title,error);
    }];

}
//#pragma mark - 删除订单
///** 
// @param Oid 订单id
// @param act 操作类型
//  @param title 调取的是哪个接口
// */
//- (void)orderRequestDataWithOid:(NSString *)Oid andActstr:(NSString *)act andActstr:(NSString *)title
//{
//    
//     //清空数据源
//    [self.sectionModelArr removeAllObjects];
//    
//    // 请求数据
//    NSString *url = [NSString stringWithFormat:@"%@api/order.php",baseUrl];
//    UserInfo *userInfo = [UserInfo currentAccount];
//    NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":Oid,@"act":@"del"};
//    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
//        NSLog(@"%@请求数据成功%@",title,responseObject);
//        //获取订单数据数组
//        NSMutableArray *array = responseObject[@"order"];
//        for (NSDictionary *dic in array) {
//            OrderListSectionModel *model = [[OrderListSectionModel alloc]init];
//            [model setValuesForKeysWithDictionary:dic];
//            [self.sectionModelArr addObject:model];
//        }
//        if (self.tableView) {
//            [self.tableView reloadData];
//        }else{
//            [self setUpTitleBtn];
//            [self setUpTableView];
//        }
//        
//    } enError:^(NSError *error) {
//        NSLog(@"%@请求数据成功%@",title,error);
//
//    }];
//    
//
//}
#pragma mark - 支付操作
- (void)payRequestDataWithOrderID:(NSString *)orderid
{
    PayDetailViewController *payDetailVC = [[PayDetailViewController alloc]init];
  
    
    UserInfo *userInfo = [UserInfo currentAccount];
    NSString *url = [NSString stringWithFormat:@"%@api/pay.php",baseUrl];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":orderid};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"%@",responseObject);
        self.payDic = responseObject;
        HomeGoodListSingLeton *singLetong = [HomeGoodListSingLeton shareHomeGoodListSingLeton];
        singLetong.dic = self.payDic;
        payDetailVC.orderNumber = self.payDic[@"sn"];
        if ([[NSString stringWithFormat:@"%@",self.payDic[@"status"]] isEqualToString:@"1"]) {
            payDetailVC.payStatus = @"支付成功";
        }
        payDetailVC.payType = self.payDic[@"payname"];
        payDetailVC.money = self.payDic[@"price"];
        payDetailVC.order_id = orderid;
        payDetailVC.orderNumber = self.orderSn;
        payDetailVC.money = self.orderMoney;
        
        
        
        NSString *payid = [NSString stringWithFormat:@"%@",responseObject[@"pay_id"]];
        if ([payid isEqualToString:@"2"]) {
            // 支付宝支付
            NSString *sign = self.payDic[@"sign"];
            
            [self doAlipayPay:sign];
   
            
            
        }
        
        if ([payid isEqualToString:@"1"]) {
            // 微信支付
            NSDictionary *data = self.payDic[@"sign"];
            
            [self WXZhiFUWith:data];
        
            
        }

          } enError:^(NSError *error) {
        
    }];
    
}

//- (void)payBtnAction:(UIButton *)sender
//{
//    NSLog(@"立即付款");
//    if ([self.pay_id isEqualToString:@"2"]) {
//        // 支付宝支付
//        NSString *sign = self.payDic[@"sign"];
//        
//        [self doAlipayPay:sign];
//        
//        
//        
//        
//    }
//    if ([self.pay_id isEqualToString:@"1"]) {
//        // 微信支付
//        NSDictionary *data = self.payDic[@"sign"];
//        
//        [self WXZhiFUWith:data];
//        
//    }
//    
//    
//    
//}


- (void)WXZhiFUWith:(id) data{
    
    //需要创建这个支付对象
    PayReq *req   = [[PayReq alloc] init];
    // 由用户微信号和AppID组成的唯一标识，用于校验微信用户
    req.openID = @"wxc4cf6018a3b7aacf";
    
    // 商家id，在注册的时候给的
    req.partnerId = [data objectForKey:@"partnerid"];
    
    
    
    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
    req.prepayId  = [data objectForKey:@"prepayid"];
    
    // 根据财付通文档填写的数据和签名
    //这个比较特殊，是固定的，只能是即req.package = Sign=WXPay
    req.package   = @"Sign=WXPay";
    
    // 随机编码，为了防止重复的，在后台生成
    req.nonceStr  = [data objectForKey:@"noncestr"];
    
    // 这个是时间戳，也是在后台生成的，为了验证支付的
    NSString * stamp = [data objectForKey:@"timestamp"];
    req.timeStamp = stamp.intValue;
    
    // 这个签名也是后台做的
    req.sign = [data objectForKey:@"sign"];
    
    //发送请求到微信，等待微信返回onResp
    [WXApi sendReq:req];
    
  
    
    
}

- (void)doAlipayPay:(NSString *)signedString
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2017010204801650";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqmDCjnR0Bwq7luyFAcobjc/43o6BlSld9GUb17jIXzFY7n82IRyI2J766KEt9h+MY7jJx7jLVlfSkrmFa8WWZKaS2xCvC5jTmI0GUcxp8PXjfQkBHRjqoL/9gY1njhGaThaoI6mXF2VEQAajNceJUDtMeGw0xjNxOzmS0JJycoYM5ei/XVh0XozrGmIwF3R6VEsZ47w/3HkWiap3Lqu4sWKOqPE/33nr/if/3shDq2xfPwTCGScOj9u17SIdLU5tKT/qM+abmiXNB4MLcQeB3uCZjOE67kDiKo0Ad0MlwGZ4wCb1K720TUbDkvfQTShQIHXnioqka4PYwwq1PT+n+wIDAQAB";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"缺少appId或者私钥" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
        
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    order.biz_content.seller_id = @"2088021865511731";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"1暖通商城订单支付";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no =self.payDic[@"sn"];//订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    // 返回订单结果
    order.return_url = @"m.alipay.com";
    
    //将商品信息拼接成字符串
    //    NSString *orderInfo = [order orderInfoEncoded:NO];
    //    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    //    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    // NSString *signedString = nil;
    //    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    //    if ((rsa2PrivateKey.length > 1)) {
    //        signedString = [signer signString:orderInfo withRSA2:YES];
    //    } else {
    //        signedString = [signer signString:orderInfo withRSA2:NO];
    //    }
    //
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign",
                                 signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"YiNuanTong" callback:^(NSDictionary *resultDic) {
            
            NSLog(@"支付页面reslut = %@",resultDic);
            
            
            // 提取支付结果字符串
            NSDictionary *returnDic =  [self stringToJson:resultDic[@"result"]];
            
            NSDictionary *dataDic = returnDic[@"alipay_trade_app_pay_response"];
            
            
            NSLog(@"支付码:%@",dataDic[@"code"]);
            NSLog(@"支付结果:%@",dataDic[@"msg"]);
            NSLog(@"支付appid:%@",dataDic[@"app_id"]);
            NSLog(@"支付授权auth_app_id:%@",dataDic[@"auth_app_id"]);
            NSLog(@"支付时间:%@",dataDic[@"timestamp"]);
            NSLog(@"支付费用:%@",dataDic[@"total_amount"]);
            NSLog(@"支付交易码trade_no:%@",dataDic[@"trade_no"]);
            NSLog(@"支付编号:%@",dataDic[@"out_trade_no"]);
            NSLog(@"支付seller_id:%@",dataDic[@"seller_id"]);
            
    
            
            
            
            
            
        }];
        
    }
    
    
    
    
    
}




// 字典转json字符串方法

-(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
#pragma mark - 处理支付宝支付结果
- (NSDictionary *)stringToJson:(NSString *)str
{
    
    NSString *requestTmp = [NSString stringWithString: str];
    
    NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
    return resultDic;
}



#pragma mark 操作订单请求数据(取消,提醒,确认)
- (void)operationOrderWithAct:(NSString *)act andGood_id:(NSString *)good_id
{
    // 如果点击的是确认
    if ([act isEqualToString:@"queren"]) {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"您是否收到了商品?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            
            
            UserInfo *userInfo = [UserInfo currentAccount];
            
            NSString *url =  [NSString  stringWithFormat:@"%@api/order.php",baseUrl];
            NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":good_id,@"act":act};
            [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
                NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
                if ([status isEqualToString:@"1"]) {
                    [GFProgressHUD showSuccess:responseObject[@"msg"]];
                    
                    
                    if ([act isEqualToString:@"queren"]) {
                        [self loadData];
                    }
                    
                    
               
                }else{
                    [GFProgressHUD showFailure:responseObject[@"msg"]];
                }
                
                
            } enError:^(NSError *error) {
                
            }];
            
            

            
        }];
        
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
        
        
    }else{
        
        
        UserInfo *userInfo = [UserInfo currentAccount];
        
        NSString *url =  [NSString  stringWithFormat:@"%@api/order.php",baseUrl];
        NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":good_id,@"act":act};
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
            NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
            if ([status isEqualToString:@"1"]) {
                [GFProgressHUD showSuccess:responseObject[@"msg"]];
                
                
                if ([act isEqualToString:@"del"]) {
                    [self loadData];
                }
                
                
                
                
                if ([act isEqualToString:@"quxiao"]) {
                    [self loadData];
                }
                
                if ([act isEqualToString:@"queren"]) {
                    [self loadData];
                }
                
                
                if ([act isEqualToString:@"zaimai"]) {
                    YNTShopingCarViewController *shopCarVC = [[YNTShopingCarViewController alloc]init];
                    [self.navigationController pushViewController:shopCarVC animated:YES];
                }
            }else{
                [GFProgressHUD showFailure:responseObject[@"msg"]];
            }
            
            
        } enError:^(NSError *error) {
            
        }];

        
        
    }
    
    
    
    
    
    
    
    
   }


#pragma mark - 再次购买
- (void)secondBuyRequestDataWithGoodID:(NSString *)goodid;
{
    UserInfo *userInfo = [UserInfo currentAccount];
    
    NSString *url =  [NSString  stringWithFormat:@"%@api/order.php",baseUrl];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":goodid,@"act":@"zaimai"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        YNTShopingCarViewController *shopCarVC = [[YNTShopingCarViewController alloc]init];
        [self.navigationController pushViewController:shopCarVC animated:YES];
        
    } enError:^(NSError *error) {
        
    }];
}

#pragma mark - 空数据处理

- (void)setUpEmptyViews
{
    self.emptyViews = [[UIView alloc]initWithFrame:CGRectMake(0, 105, KScreenW, kScreenH)];
    self.emptyViews.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.emptyViews];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW / 2 - 50 *kWidthScale, 83 *kHeightScale, 100 *kWidthScale, 124 *kHeightScale)];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
