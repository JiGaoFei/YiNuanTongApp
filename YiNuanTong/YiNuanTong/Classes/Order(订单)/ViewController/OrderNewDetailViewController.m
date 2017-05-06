//
//  OrderNewDetailViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderNewDetailViewController.h"
#import "OrderNewDetaiTableViewCell.h"
#import "OrderNewDetailSectionView.h"
#import "OrderNewDetailFooterView.h"
#import "OrderNewDetailTableHeadView.h"
#import "YNTUITools.h"
#import "OrderPayTypeView.h"
#import "OrderConfirmViewController.h"
#import "OrderNewDetailSectionModel.h"
#import "OrderNewDetailListModel.h"
#import "YNTNetworkManager.h"
#import "UIImageView+WebCache.h"
#import "OrderNewDetailShipTypeView.h"
#import "Order.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "AddressViewController.h"
#import "OrderShipModel.h"
#import "YNTShopingCarViewController.h"
@interface OrderNewDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
/**sectionModel数组*/
@property (nonatomic,strong) NSMutableArray *sectionModelArr;
/**备注信息*/
@property (nonatomic,strong)  UITextView *textView;
/** 详情底部支付按钮 */
@property (nonatomic,strong) UIButton *payBtn;
/** 详情底部取消按钮 */
@property (nonatomic,strong) UIButton *cancelBtn;


/**整个字典*/
@property (nonatomic,strong) NSMutableDictionary *dataDic;
/**合计*/
@property (nonatomic,strong) UILabel *totallMoneyLab;

/**配送方式*/
@property (nonatomic,strong)  OrderNewDetailShipTypeView *shipView;
/**支付*/
@property (nonatomic,strong) OrderPayTypeView *payView;
/**配送方式id(1是送货上*/
@property (nonatomic,copy) NSString  *ship_id;
/**支付方式id*/
@property (nonatomic,copy) NSString  *pay_id;
/**支付name*/
@property (nonatomic,strong) UILabel *payNameLab;
/**物流name*/
@property (nonatomic,strong) UILabel *shipnamelab;
/**订单状态*/
@property (nonatomic,copy) NSString *orderStatus;
/**客服电话*/
@property (nonatomic,copy) NSString *customerTel;
/**是否折叠*/
@property (nonatomic,assign) BOOL isFold;



@end
static NSString *identifier = @"orderDetailCell";
@implementation OrderNewDetailViewController
#pragma mark - 懒加载
/** 存放区头数组 */
- (NSMutableArray *)sectionModelArr
{
    if (!_sectionModelArr) {
        self.sectionModelArr = [[NSMutableArray alloc]init];
    }
    return _sectionModelArr;
}
/** 存放服务器返回来的数据 */
- (NSMutableDictionary *)dataDic
{
    if (!_dataDic) {
        self.dataDic = [[NSMutableDictionary alloc]init];
    }
    return _dataDic;
}
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    [self loadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    if (self.oftenSettingTableBlock) {
        self.oftenSettingTableBlock();
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"订单详情";
    // 刚开始不折叠,
    self.isFold = NO;
    [self setUpNavRightBtn];

}
#pragma mark - 加载数据
- (void)loadData
{
    
    
    
    
    
    NSString *url =  [NSString stringWithFormat:@"%@api/order.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":self.good_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"请求订单详情数据成功%@",responseObject);
        self.dataDic = responseObject;
        // 为总价赋值
        self.totallMoneyLab.text = [NSString stringWithFormat:@"合计:%@",self.dataDic[@"zongprice"]];
        // 为客服电话赋值
        self.customerTel = self.dataDic[@"kefu"];
        // 为支付id赋值
        self.pay_id = [NSString stringWithFormat:@"%@",self.dataDic[@"pay_id"]];
        // 为配送id赋值
          self.ship_id = [NSString stringWithFormat:@"%@",self.dataDic[@"shipping_id"]];
    
        self.totallMoneyLab.textColor = [UIColor redColor];
        NSArray *dataArray = responseObject[@"cart_goods"];
        // 清空数据源
        [self.sectionModelArr removeAllObjects];
        for (NSDictionary *dic in dataArray) {
            OrderNewDetailSectionModel *model = [[OrderNewDetailSectionModel alloc]init];
            model.isOpen =YES;
            [model setValuesForKeysWithDictionary:dic];
            [self.sectionModelArr addObject:model];
        }
        
        if (self.tableView) {
            [self.tableView reloadData];
        }else{
            [self setUpTableView];
            [self setUpBottomView];
            
        }
        self.shipnamelab.text = [NSString stringWithFormat:@"(%@)",self.dataDic[@"shippingname"]];
        self.payNameLab.text =[NSString stringWithFormat:@"(%@)",self.dataDic[@"payname"]];
            self.orderStatus = [NSString stringWithFormat:@"%@",self.dataDic[@"order_status"]];
        if ([self.orderStatus isEqualToString:@"2"]) {
            self.payView.weChatPayBtn.hidden = YES;
            self.payView.aliPayBtn.hidden = YES;
            self.shipView.ziquBtn.hidden = YES;
            self.shipView.mianfeiBtn.hidden = YES;
        }
        if ([self.orderStatus isEqualToString:@"3"]) {
            self.payView.weChatPayBtn.hidden = YES;
            self.payView.aliPayBtn.hidden = YES;
            self.shipView.ziquBtn.hidden = YES;
            self.shipView.mianfeiBtn.hidden = YES;
        }
        

    } enError:^(NSError *error) {
        NSLog(@"请求订单详情数据失败%@",error);
    }];
    
}
#pragma mark - 创建折叠按钮
- (void)setUpNavRightBtn
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame= CGRectMake(0, 0, 40, 40);
    [rightBtn addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"折叠" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}
// 折叠按钮点击事件
- (void)rightBarButtonItemAction:(UIButton *)sender
{
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.isFold = YES;
    }else{
        self.isFold = NO;
    }
    [self.tableView reloadData];
    
    
}

#pragma mark - 自定义视图
// 创建tableView
- (void)setUpTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, kScreenH - 48 *kHeightScale - 64) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor =[UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册cell
    [self.tableView registerClass:[OrderNewDetaiTableViewCell class] forCellReuseIdentifier:identifier];
    // 表头视图
    OrderNewDetailTableHeadView *tableHeadView = [[OrderNewDetailTableHeadView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 160)];
    NSDictionary *shipDic = self.dataDic[@"shippads"];
    // 收货人赋值
    tableHeadView.customerLab.text = [NSString stringWithFormat:@"收货人:%@                                    %@",shipDic[@"consignee"],shipDic[@"mobile"]];
    // 为订单编号赋值
    tableHeadView.orderSnLab.text = [NSString stringWithFormat:@"订单编号:%@",self.dataDic[@"sn"]];
    // 收货地址
    tableHeadView.addressLab.text = [NSString stringWithFormat:@"%@%@%@%@",shipDic[@"province"],shipDic[@"city"],shipDic[@"area"],shipDic[@"address"]];
    
    __weak typeof(tableHeadView)weakSelf = tableHeadView;
    
    
    
    // 手势回调
    tableHeadView.tapActionBlock = ^(){
        // 待付款状态可以改
        if ([self.orderPostStatus isEqualToString:@"1"]) {
            
             AddressViewController *addressVC = [[AddressViewController alloc]init];
              addressVC.confirmBlockShipiing_id = ^(OrderShipModel *model){
                // 回调赋值
                weakSelf.customerLab.text = [NSString stringWithFormat:@"收货人:%@                                %@",model.consignee,model.mobile];
                weakSelf.addressLab.text = [NSString stringWithFormat:@"收货地址:%@%@%@",model.province,model.city,model.area];
                weakSelf.backgroundColor = [UIColor whiteColor];
                CGRect rec = self.tableView.frame;
                rec.origin.y = 0;
                self.tableView.frame = rec;
                
            };
            [self.navigationController pushViewController:addressVC animated:YES];

        }
        
           };
    
    
    
    // 打电话回调
    tableHeadView.callBtnBloock = ^(){
        NSLog(@"开始拨打电话了");
        UIWebView *webView = [[UIWebView alloc]init];
        [self.view addSubview:webView];
        NSString *str = [NSString stringWithFormat:@"tel:%@",self.customerTel];
            NSURL *url = [NSURL URLWithString:str];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];

    };
    self.tableView.tableHeaderView = tableHeadView;
    // 表尾视图
    UIView *tableFooterView = [self setUpListFooterView];
    self.tableView.tableFooterView = tableFooterView;
    [self.view addSubview:self.tableView];
}
// 创建底部视图
- (void)setUpBottomView
{    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - 48 *kHeightScale, KScreenW, 48*kHeightScale)];
    bagView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bagView];
    
    // 合计
    self.totallMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale, 5 *kHeightScale, 140 *kHeightScale, 48 *kHeightScale)];
    _totallMoneyLab.text = [NSString stringWithFormat:@"合计:%@",self.dataDic[@"zongprice"]];
    self.totallMoneyLab.textColor = [UIColor redColor];
    [bagView addSubview:_totallMoneyLab];
    // 取消按钮
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(158 *kWidthScale, 0, (KScreenW - 158*kHeightScale)/2, 48 *kHeightScale);
    _cancelBtn.backgroundColor = RGBA(52, 162, 252, 1);
    [_cancelBtn setTitle:@"" forState:UIControlStateNormal];
    
    [_cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [bagView addSubview:_cancelBtn];
    // 去付款
  
    self.payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _payBtn.frame = CGRectMake((KScreenW +162*kHeightScale)/2, 0,(KScreenW - 158*kHeightScale)/2, 48 *kHeightScale);
        _payBtn.backgroundColor = RGBA(52, 162, 252, 1);
    [_payBtn setTitle:@"" forState:UIControlStateNormal];
    [_payBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bagView addSubview:_payBtn];
    
    
    
    // 设置按钮文字
    
    if ([self.orderPostStatus isEqualToString:@"0"]) {
        self.cancelBtn.hidden = YES;
        [self.payBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        // 已取消
    }
    if ([self.orderPostStatus isEqualToString:@"1"]) {
        // 待付款
        [self.cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.payBtn setTitle:@"去付款" forState:UIControlStateNormal];
    }
    
    if ([self.orderPostStatus isEqualToString:@"2"]) {
        // 待发货
        self.cancelBtn.hidden = YES;
        [self.payBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
        
    }
    
    if ([self.orderPostStatus isEqualToString:@"3"]) {
        // 待收货
        [self.cancelBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        [self.payBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        
    }
    
    if ([self.orderPostStatus isEqualToString:@"4"]) {
        // 已完成
        [self.cancelBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [self.payBtn setTitle:@"再次购买" forState:UIControlStateNormal];
    }
    

    
    
}
// 取消订单
- (void)cancelBtnAction:(UIButton *)sender
{
    NSLog(@"取消订单");
    //[self cancelOrderRequestData];
    if ([self.orderPostStatus isEqualToString:@"0"]) {
     
    }
    if ([self.orderPostStatus isEqualToString:@"1"]) {
        // 待付款
         [self operationOrderWithAct:@"quxiao"];
        self.orderPostStatus = @"0";
        [self refreshData];
      
    }
    
    if ([self.orderPostStatus isEqualToString:@"2"]) {
      
        
    }
    
    if ([self.orderPostStatus isEqualToString:@"3"]) {
        // 待收货
        [self operationOrderWithAct:@"zaimai"];
        
    }
    
    if ([self.orderPostStatus isEqualToString:@"4"]) {
        // 已完成
        [self operationOrderWithAct:@"del"];
        [self.navigationController popViewControllerAnimated:YES];
        if (self.operationSuccessBlock) {
            self.operationSuccessBlock();
        }

    }
    
    

    
}
// 去付款
- (void)payBtnAction:(UIButton *)sender
{
    if ([self.orderPostStatus isEqualToString:@"0"]) {
       // 删除订单
      [self operationOrderWithAct:@"del"];
       
      [self.navigationController popViewControllerAnimated:YES];
        if (self.operationSuccessBlock) {
            self.operationSuccessBlock();
        }
    }
    if ([self.orderPostStatus isEqualToString:@"1"]) {
        // 待付款
      
        [self payRequstDataWithWeChatOrAlipay];
    }
    
    if ([self.orderPostStatus isEqualToString:@"2"]) {
        // 待发货
       // [self operationOrderWithAct:@""];
        [GFProgressHUD showSuccess:@"提醒发货成功"];
    }
    
    if ([self.orderPostStatus isEqualToString:@"3"]) {
        // 待收货
        [self operationOrderWithAct:@"queren"];
        self.orderPostStatus = @"4";
        [self refreshData];
        
    }
    
    if ([self.orderPostStatus isEqualToString:@"4"]) {
        // 已完成
       [self operationOrderWithAct:@"zaimai"];
    }
    
    

//    OrderConfirmViewController *confirmVC = [[OrderConfirmViewController alloc]init];
//    [self.navigationController pushViewController:confirmVC animated:YES];
    
  
   
}

// 创建表尾视图
- (UIView *)setUpListFooterView
{
    UserInfo *userInfo = [UserInfo currentAccount];
    __weak typeof(self)weakSelf = self;
    
    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 550*kHeightScale)];
   
    // 配送方式
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 1)];
    line1.backgroundColor = [UIColor grayColor];
    [bagView addSubview:line1];
    
    UILabel *lab1  = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 15 *kHeightScale, 80 *kWidthScale, 16 *kHeightScale) text:@"配送方式" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15*kHeightScale];
    [bagView addSubview:lab1];
    self.shipnamelab = [[UILabel alloc]initWithFrame:CGRectMake(90*kWidthScale, 15*kHeightScale, 120*kWidthScale, 16*kHeightScale)];
    self.shipnamelab.textColor = [UIColor grayColor];
    self.shipnamelab.font = [UIFont systemFontOfSize:15 *kHeightScale];
    self.shipnamelab.textAlignment = NSTextAlignmentLeft;
    [bagView addSubview:self.shipnamelab];
    

    UIImageView *arrow1 = [[UIImageView alloc]init];
    arrow1.frame = CGRectMake(KScreenW - 40 *kWidthScale, 10 *kHeightScale, 25 *kWidthScale, 16 *kHeightScale) ;
    arrow1.image = [UIImage imageNamed:@"arrow@2x"];
    [bagView addSubview:arrow1];
    
    self.shipView = [[OrderNewDetailShipTypeView alloc]initWithFrame:CGRectMake(0,45 *kHeightScale, KScreenW, 90 *kHeightScale)];
    // 控制是否选中
    if ([self.ship_id isEqualToString:@"1"]) {
        [self.shipView.mianfeiBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
          [self.shipView.ziquBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
    }else{
        [self.shipView.mianfeiBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        [self.shipView.ziquBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
    }

    
    __weak typeof(_shipView)shipSelf = _shipView;
    _shipView.mianfeiBtnBlook = ^()
    {
        NSLog(@"送货上门");
        // 待付款状态可以改
        if ([weakSelf.orderPostStatus isEqualToString:@"1"]) {
            [shipSelf.mianfeiBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
            [shipSelf.ziquBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
           weakSelf.shipnamelab.text = @"送货上门";
            // actid为1为送货上门
            NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":weakSelf.good_id,@"act":@"shipping",@"actid":@"1"};
            [weakSelf modifiyRequestDataWithDic:params withTitle:@"送货上门"];

        }else{
            NSLog(@"不能更改");
        }
      
    };
    _shipView.ziquBtnBlook = ^()
    {
        //   // 待付款状态可以改
         if ([weakSelf.orderPostStatus isEqualToString:@"1"]) {
        [shipSelf.mianfeiBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        [shipSelf.ziquBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
        NSLog(@"上门自取");
              weakSelf.shipnamelab.text = @"到店自取";
        // actid为2为上门自取
        NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":weakSelf.good_id,@"act":@"shipping",@"actid":@"2"};
        [weakSelf modifiyRequestDataWithDic:params withTitle:@"上门自取"];

         }else{
             NSLog(@"不能更改");
         }
    };
    
    [bagView addSubview:_shipView];

    

    // 支付方式
    UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 170 *kHeightScale, KScreenW, 1)];
    line3.backgroundColor = [UIColor grayColor];
    [bagView addSubview:line3];

    UILabel *lab3  = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 180 *kHeightScale, 80 *kWidthScale, 16 *kHeightScale) text:@"支付方式" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15*kHeightScale];
    [bagView addSubview:lab3];
    self.payNameLab = [[UILabel alloc]initWithFrame:CGRectMake(90*kWidthScale, 180*kHeightScale, 120*kWidthScale, 16*kHeightScale)];
    self.payNameLab.textColor = [UIColor grayColor];
    self.payNameLab.font = [UIFont systemFontOfSize:15 *kHeightScale];
    self.payNameLab.textAlignment = NSTextAlignmentLeft;
    [bagView addSubview:self.payNameLab];
    
    
    UIImageView *arrow3 = [[UIImageView alloc]init];
    arrow3.frame = CGRectMake(KScreenW - 40 *kWidthScale, 180*kHeightScale, 25 *kWidthScale, 16*kHeightScale) ;
    arrow3.image = [UIImage imageNamed:@"arrow@2x"];
    [bagView addSubview:arrow3];
    
    self.payView = [[OrderPayTypeView alloc]initWithFrame:CGRectMake(0, 210 *kHeightScale, KScreenW, 90 *kHeightScale)];
    [bagView addSubview:_payView];
    // 控制是否选中
    if ([self.pay_id isEqualToString:@"1"]) {
        [self.payView.weChatPayBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
        [self.payView.aliPayBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
    }else{
        [self.payView.weChatPayBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        [self.payView.aliPayBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
    }
    __weak typeof(_payView)payViewSelf = _payView;
    _payView.weChatPayBtnBlook = ^(){
        
        // 待付款状态可以改
        if ([weakSelf.orderPostStatus isEqualToString:@"1"]) {
        NSLog(@"微信支付回调");
        [payViewSelf.weChatPayBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
            [payViewSelf.aliPayBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
            weakSelf.payNameLab.text = @"微信支付";
        // actid为1为微信支付
        NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":weakSelf.good_id,@"act":@"pay",@"actid":@"1"};
        [weakSelf modifiyRequestDataWithDic:params withTitle:@"修改微信"];
;
        }else{
            NSLog(@"不能更改");
        }
    };
    _payView.aliPayBtnBlook = ^(){
             if ([weakSelf.orderPostStatus isEqualToString:@"1"]) {
        NSLog(@"支付宝支付回调");
        [payViewSelf.weChatPayBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        [payViewSelf.aliPayBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
        weakSelf.payNameLab.text = @"支付宝支付";
        // actid 为2为支付宝支付
        NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":weakSelf.good_id,@"act":@"pay",@"actid":@"2"};
        [weakSelf modifiyRequestDataWithDic:params withTitle:@"修改支付宝"];
             }else{
                 NSLog(@"不能更改");
             }
    };
    

    
    // 发票信息
    UILabel *line4= [[UILabel alloc]initWithFrame:CGRectMake(0, 335 *kHeightScale, KScreenW, 1)];
    line4.backgroundColor = [UIColor grayColor];
    [bagView addSubview:line4];
    
    UILabel *lab4  = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 350 *kHeightScale, 80 *kWidthScale, 16 *kHeightScale) text:@"备注信息:" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15*kHeightScale];
    [bagView addSubview:lab4];
    
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(100 *kWidthScale, 350*kHeightScale, 240 *kWidthScale, 16 *kHeightScale) text:@"选填:对本次交易的说明(建议填写)" textAlignment:NSTextAlignmentLeft textColor:[UIColor grayColor] bgColor:nil font:14*kHeightScale];
    [bagView addSubview:titleLab];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(15 *kWidthScale, 370 *kHeightScale, KScreenW - 30 *kWidthScale, 60 *kHeightScale)];
    _textView.backgroundColor = RGBA(249, 249, 249, 1);
  //  textView.backgroundColor = [UIColor redColor];
    self.textView.delegate = self;
    [bagView addSubview:_textView];
    
    
    
    return bagView;
}
#pragma mark - textView代理
// 点击return的时候隐藏键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.tableView.contentOffset = CGPointMake(0, 750);
    return YES;
}


#pragma mark - tableView代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OrderNewDetailSectionModel *sectionModel = self.sectionModelArr[section];
    // 根据折叠来状态
    if (self.isFold) {
        return 0;
    }else{
        if (sectionModel.isOpen) {
            return sectionModel.good_attr.count;
        }else{
            return 0;
        }

    }
   
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionModelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderNewDetaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    OrderNewDetailSectionModel *sectionModel = self.sectionModelArr[indexPath.section];
    for (NSDictionary *dic in sectionModel.good_attr) {
        OrderNewDetailListModel *model = [[OrderNewDetailListModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [sectionModel.modelArr addObject:model];
    }
    OrderNewDetailListModel *model = sectionModel.modelArr[indexPath.row];
    cell.goodName.text = model.namestr;
    cell.orderMoneyLab.text = [NSString stringWithFormat:@"%@/个",model.xiaoprice];
    cell.shopNumberLab.text = [NSString stringWithFormat:@"%@件",model.num];
    // 取消cell的点击样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120 *kHeightScale;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OrderNewDetailSectionView *sectionView = [[OrderNewDetailSectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 95 *kHeightScale)];
    OrderNewDetailSectionModel *sectionModel = self.sectionModelArr[section];
    [sectionView.goodImgView sd_setImageWithURL:[NSURL URLWithString:sectionModel.good_img]];
    sectionView.goodNameLab.text = sectionModel.good_name;
    
    // 如果为无属性的时候隐藏旋转按钮
    if (sectionModel.good_attr.count == 0) {
        sectionView.roateBtn.hidden = YES;
    }
    
    //  旋转按钮回调(折叠方式)
    sectionView.roateBtnBloock = ^(BOOL isPen){
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
        [sectionView.roateBtn setImage:roateImg forState:UIControlStateNormal];
    }else{
        UIImage *roateImg = [UIImage imageNamed:@"arrow_before"];
        roateImg = [roateImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [sectionView.roateBtn setImage:roateImg forState:UIControlStateNormal];
        
    }
    

    
    return sectionView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    OrderNewDetailFooterView  *footerView = [[OrderNewDetailFooterView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 25 *kHeightScale)];
    OrderNewDetailSectionModel *sectionModel =self.sectionModelArr[section];

    if (sectionModel.good_attr.count == 0) {    // 无属性时
          footerView.goodNumberLab.text = [NSString stringWithFormat:@"共%@件",sectionModel.good_num];
        double price = [sectionModel.price doubleValue];
        double num = [sectionModel.num doubleValue];
        double totallmoney = price *num;
          footerView.goodPriceLab.text = [NSString stringWithFormat:@"¥%.2f",totallmoney];
    }else{
        // 有属性时
          footerView.goodNumberLab.text = [NSString stringWithFormat:@"共%@种%@件",sectionModel.good_zhong,sectionModel.good_num];
          footerView.goodPriceLab.text = [NSString stringWithFormat:@"¥%@",sectionModel.good_price];
    }
  
  
    
    
    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 110 *kHeightScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 35 *kHeightScale;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 取消订单请求数据
- (void)cancelOrderRequestData
{
    NSString *url = [NSString stringWithFormat:@"%@api/order.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];

    NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":self.good_id,@"act":@"quxiao"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"取消订单请求数据成功%@",responseObject);
        [self refreshData];
    } enError:^(NSError *error) {
          NSLog(@"取消订单请求数据失败%@",error);
    }];
}

#pragma mark - 刷新数据
- (void)refreshData
{
    [self.sectionModelArr removeAllObjects];
    [self.tableView reloadData];
    
    NSString *url =  [NSString stringWithFormat:@"%@api/order.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":self.good_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"请求订单详情数据成功%@",responseObject);
        NSDictionary *dataDic = responseObject;
        
 
        // 为总价赋值
        self.totallMoneyLab.text = @"";
        // 为客服电话赋值
        self.customerTel = @"";
        // 为支付id赋值
        self.pay_id = @"";
        // 为配送id赋值
        self.ship_id = @"";
        // 为总价赋值
        self.totallMoneyLab.text =@"";
        // 为客服电话赋值
        self.customerTel = self.dataDic[@"kefu"];
        // 为支付id赋值
        self.pay_id = [NSString stringWithFormat:@"%@",dataDic[@"pay_id"]];
        // 为配送id赋值
        self.ship_id = [NSString stringWithFormat:@"%@",dataDic[@"shipping_id"]];
        
        self.totallMoneyLab.textColor = [UIColor redColor];
        NSArray *dataArray = responseObject[@"cart_goods"];
        // 清空数据源
        [self.sectionModelArr removeAllObjects];
        for (NSDictionary *dic in dataArray) {
            OrderNewDetailSectionModel *model = [[OrderNewDetailSectionModel alloc]init];
            model.isOpen =YES;
            [model setValuesForKeysWithDictionary:dic];
            [self.sectionModelArr addObject:model];
        }
        
        
            [self setUpTableView];
            [self setUpBottomView];
            [self.tableView reloadData];
       
        self.shipnamelab.text = [NSString stringWithFormat:@"(%@)",dataDic[@"shippingname"]];
        self.payNameLab.text =[NSString stringWithFormat:@"(%@)",dataDic[@"payname"]];
        self.orderStatus = [NSString stringWithFormat:@"%@",dataDic[@"order_status"]];
        if ([self.orderStatus isEqualToString:@"2"]) {
            self.payView.weChatPayBtn.hidden = YES;
            self.payView.aliPayBtn.hidden = YES;
            self.shipView.ziquBtn.hidden = YES;
            self.shipView.mianfeiBtn.hidden = YES;
        }
        if ([self.orderStatus isEqualToString:@"3"]) {
            self.payView.weChatPayBtn.hidden = YES;
            self.payView.aliPayBtn.hidden = YES;
            self.shipView.ziquBtn.hidden = YES;
            self.shipView.mianfeiBtn.hidden = YES;
        }
        
        
    } enError:^(NSError *error) {
        NSLog(@"请求订单详情数据失败%@",error);
    }];

}
#pragma mark  修改地址和支付方式的请求参数
/** 
  @ params  请求参数
  @ param title请求提示
 */
- (void)modifiyRequestDataWithDic:(NSDictionary *)params withTitle:(NSString *)title
{
    NSString *url = [NSString stringWithFormat:@"%@api/order.php",baseUrl];
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
           NSLog(@"%@请求数据成功%@",title,responseObject);
        NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
        
        if ([title isEqualToString:@"修改支付宝"]) {
            if ([status isEqualToString:@"1"]) {
             self.pay_id = @"2";
            }
        }
        if ([title isEqualToString:@"修改微信"]) {
            if ([status isEqualToString:@"1"]) {
                self.pay_id = @"1";
            }

        }


    } enError:^(NSError *error) {
        NSLog(@"%@请求数据失败%@",title,error);
    }];
}

#pragma mark - 支付
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
    
    NSDictionary *params = @{@"order_id":self.dataDic[@"id"]};
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"wexinResult" object:nil userInfo:params];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    
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
    //order.biz_content.out_trade_no =self.payDic[@"sn"];//订单ID（由商家自行制定）
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
            
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"aliPayReslut" object:nil userInfo:dataDic];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
            //             PayDetailViewController *payDetailViewVC = [[PayDetailViewController alloc]init];
            //             // 没有商品名称
            //             payDetailViewVC.shopName =@"测试数据";
            //             payDetailViewVC.orderNumber =dataDic[@"out_trade_no"];
            //             payDetailViewVC.tradingTime =dataDic[@"timestamp"];
            //             payDetailViewVC.payStatus = @"已支付";
            //             payDetailViewVC.payType = @"支付宝";
            //             [[NSNotificationCenter defaultCenter]postNotificationName:@"aliPayReslut" object:nil userInfo:resultDic];
            //
            
            
            
        }];
        
    }
    
    
    
    
    
}







#pragma mark - 微信支付代理

-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:{
                strMsg = @"恭喜您，支付成功!";
                
                // [MYNotificationCenter postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"success"}];
                
                break;
            }
            case WXErrCodeUserCancel:{
                strMsg = @"已取消支付!";
                // [MYNotificationCenter postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"cancle"}];
                break;
            }
            default:{
                
                strMsg = [NSString stringWithFormat:@"支付失败 !"];
                //   [MYNotificationCenter postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"cancle"}];
                break;
            }
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
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

#pragma mark - 支付操作
- (void)payRequstDataWithWeChatOrAlipay
{
    // 支付操作
    UserInfo *userInfo = [UserInfo currentAccount];
    NSString *url = [NSString stringWithFormat:@"%@api/pay.php",baseUrl];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":self.dataDic[@"id"]};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"请求支付数据成功%@",responseObject);
        if ([self.pay_id isEqualToString:@"1"]) {
            // 微信支付
            NSDictionary *data = responseObject[@"sign"];
            [self WXZhiFUWith:data];
        }
        if ([self.pay_id isEqualToString:@"2"]) {
            // 支付宝支付
            NSString *sign =  responseObject[@"sign"];
            [self doAlipayPay:sign];
        }
        
    } enError:^(NSError *error) {
        NSLog(@"请求支付数据失败%@",error);
        
    }];
}
#pragma mark 操作订单请求数据(取消,提醒,确认)
- (void)operationOrderWithAct:(NSString *)act
{
    UserInfo *userInfo = [UserInfo currentAccount];
    
    NSString *url =  [NSString  stringWithFormat:@"%@api/order.php",baseUrl];
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":self.good_id,@"act":act};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
        if ([status isEqualToString:@"1"]) {
            [GFProgressHUD showSuccess:responseObject[@"msg"]];
        }else{
            [GFProgressHUD showFailure:responseObject[@"msg"]];
        }
        
        if ([act isEqualToString:@"zaimai"]) {
            YNTShopingCarViewController *shopCarVC =  [[YNTShopingCarViewController alloc]init];
            [self.navigationController pushViewController:shopCarVC animated:YES];
        }
       

    } enError:^(NSError *error) {
        
    }];
}

@end
