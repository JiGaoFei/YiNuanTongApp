//
//  OrderConfirmViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/4/7.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "OrderConfirmViewController.h"
#import "OrderNewDetaiTableViewCell.h"
#import "ShopSectionHeadView.h"
#import "ShopSectionFooterView.h"
#import "OrderConfirmTableHeadView.h"
#import "OrderPayTypeView.h"
#import "YNTUITools.h"
#import "OrderNewCompleteViewController.h"
#import "YNTNetworkManager.h"
#import "OrderShipModel.h"
#import <SDWebImage/SDImageCache.h>
#import "UIImageView+WebCache.h"
#import "OrderConfirmModel.h"
#import "ShopCarModel.h"
#import "OrderNewDetailShipTypeView.h"
#import "AddAddressViewController.h"
#import "AddressViewController.h"
@interface OrderConfirmViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**地址模型*/
@property (nonatomic,strong) OrderShipModel  * addressModel;
/**备注信息*/
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIView *emptyViews;
/**存放sectonModel数组*/
@property (nonatomic,strong) NSMutableArray  * sectionModelArray;

/**地址id*/
@property (nonatomic,copy) NSString *address_id;
/**配送方式id*/
@property (nonatomic,copy) NSString *shipping_id;
/**pay_id*/
@property (nonatomic,copy) NSString *pay_id;
/**备注信息*/
@property (nonatomic,copy) NSString *remarks;
/**总价*/
@property (nonatomic,copy) NSString *zongprice;
/**总数*/
@property (nonatomic,copy) NSString *zongnum;
/**配送方式*/
@property (nonatomic,strong)  OrderNewDetailShipTypeView *shipView;
/**支付*/
@property (nonatomic,strong) OrderPayTypeView *payView;

/**支付name*/
@property (nonatomic,strong) UILabel *payNameLab;
/**物流name*/
@property (nonatomic,strong) UILabel *shipnamelab;
/**客服电话*/
@property (nonatomic,copy) NSString *customerTel;
/**背景view*/
@property (nonatomic,strong) UIView *bagView;
///**折叠数据源*/
//@property (nonatomic,strong) NSMutableArray *foldDataArray;
/**是否折叠*/
@property (nonatomic,assign) BOOL isFold;


@end
static NSString *identifier = @"confirmCell";
@implementation OrderConfirmViewController
#pragma mark -  懒加载
- (NSMutableArray *)sectionModelArray
{
    if (!_sectionModelArray) {
        self.sectionModelArray = [[NSMutableArray alloc]init];
        
    }
    return _sectionModelArray;
}
#pragma mark- 视图周期
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

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    self.view.backgroundColor = [UIColor whiteColor];


    self.remarks = @"";
    self.isFold = NO;
    [self loadData];
    [self setUpNavRightBtn];
}

// 加载数据
- (void)loadData
{
  
    NSString *url = [NSString stringWithFormat:@"%@api/checkorder.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"directbuy":self.directbuy};
    
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"确认订单请求数据成功%@",responseObject);
        
        NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
        // 没有收货地址时
        if ([status isEqualToString:@"0"]) {
            //
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"你还没有添加收货地址哟!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confrimAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                AddAddressViewController *addAddressVC = [[AddAddressViewController alloc]init];
                [self.navigationController pushViewController:addAddressVC animated:YES];
            }];
            [alertVC addAction:confrimAction];
            [self presentViewController:alertVC animated:YES completion:nil];
            return ;
        }
        
        
        
        // 总数
        self.zongnum = [NSString stringWithFormat:@"%@",responseObject[@"zongnum"]];
        
        // 总价
        self.zongprice = [NSString stringWithFormat:@"%@",responseObject[@"zongprice"]];
        // 地址id
        self.address_id = responseObject[@"shippads"][@"id"];
       
        
        self.addressModel = [[OrderShipModel alloc]init];
        [self.addressModel setValuesForKeysWithDictionary:responseObject[@"shippads"]];
        NSArray*arr= [[NSArray alloc]init];
        
        arr = responseObject[@"cart_goods"];
        
        
        [self.sectionModelArray removeAllObjects];
        // 无数据
        if (arr.count == 0) {
            [self setUpEmptyViews];
            
//            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"此商品已经提交,去我的订单查看吧!" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *action1 =[UIAlertAction actionWithTitle:@"去看看" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [self.navigationController popViewControllerAnimated:YES];
//                self.tabBarController.selectedIndex = 3;
//            }];
//            
//            
//            [alertVC addAction:action1];
//            [self presentViewController:alertVC animated:YES completion:nil];
            
        }else{
            // 有数据
            [self.emptyViews removeFromSuperview];
            for (NSDictionary *dic in arr) {
                OrderConfirmModel  *model = [[OrderConfirmModel alloc]init];
                // 用来控制是否要展示
                model.isOpen = YES;
                [model setValuesForKeysWithDictionary:dic];
                [self.sectionModelArray addObject:model];
            }
            if (self.tableView) {
                [self.tableView reloadData];
            }else{
                [self setUpChildrenViews];
                [self setUpBottomView];
                
            }

        }
        
        
        } enError:^(NSError *error) {
             NSLog(@"确认订单请求数据失败%@",error);
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
- (void)setUpChildrenViews
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, KScreenW, kScreenH) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    OrderConfirmTableHeadView *confirmTableView = [[OrderConfirmTableHeadView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 120 *kHeightScale)];
    confirmTableView.customerLab.text = [NSString stringWithFormat:@"收货人:%@                                %@",_addressModel.consignee,_addressModel.mobile];
    confirmTableView.addressLab.text = [NSString stringWithFormat:@"收货地址:%@%@%@",_addressModel.province,_addressModel.city,_addressModel.area];
    confirmTableView.backgroundColor = [UIColor whiteColor];
    
    //
    __weak typeof(confirmTableView)weakSelf = confirmTableView;
    confirmTableView.tapActionBlock = ^(){
        NSLog(@"手势回调事件");
        AddressViewController *addressVC = [[AddressViewController alloc]init];
        addressVC.confirmBlockShipiing_id = ^(OrderShipModel *model){
            // 回调赋值
            weakSelf.customerLab.text = [NSString stringWithFormat:@"收货人:%@                                %@",model.consignee,model.mobile];
            weakSelf.addressLab.text = [NSString stringWithFormat:@"收货地址:%@%@%@",model.province,_addressModel.city,model.area];
            weakSelf.backgroundColor = [UIColor whiteColor];

            CGRect rec = self.tableView.frame;
            rec.origin.y = 0;
            self.tableView.frame = rec;
         
       
        };
        
        addressVC.directbuy = self.directbuy;
        [self.navigationController pushViewController:addressVC animated:YES];
    
    };
    self.tableView.tableHeaderView = confirmTableView;
    UIView *tableFooterView = [self setUpListFooterView];
    tableFooterView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = tableFooterView;
    // 注册cell
    [self.tableView registerClass:[OrderNewDetaiTableViewCell class] forCellReuseIdentifier:identifier];
  
    [self.view addSubview:self.tableView];
}
// 创建表尾视图
- (UIView *)setUpListFooterView
{
    
  //  UserInfo *userInfo = [UserInfo currentAccount];
    __weak typeof(self)weakSelf = self;
    
    self.bagView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 550*kHeightScale)];
    
    // 配送方式
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 1)];
    line1.backgroundColor = RGBA(241, 241, 241, 1);
    [_bagView addSubview:line1];
    
    UILabel *lab1  = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 15 *kHeightScale, 80 *kWidthScale, 16 *kHeightScale) text:@"配送方式" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15*kHeightScale];
    [_bagView addSubview:lab1];
    self.shipnamelab = [[UILabel alloc]initWithFrame:CGRectMake(90*kWidthScale, 15*kHeightScale, 120*kWidthScale, 16*kHeightScale)];
    self.shipnamelab.textColor = [UIColor grayColor];
    self.shipnamelab.font = [UIFont systemFontOfSize:15 *kHeightScale];
    self.shipnamelab.textAlignment = NSTextAlignmentLeft;
    [_bagView addSubview:self.shipnamelab];
    
    
    UIImageView *arrow1 = [[UIImageView alloc]init];
    arrow1.frame = CGRectMake(KScreenW - 40 *kWidthScale, 10 *kHeightScale, 25 *kWidthScale, 16 *kHeightScale) ;
    arrow1.image = [UIImage imageNamed:@"arrow@2x"];
    [_bagView addSubview:arrow1];
    
    self.shipView = [[OrderNewDetailShipTypeView alloc]initWithFrame:CGRectMake(0,45 *kHeightScale, KScreenW, 90 *kHeightScale)];
    __weak typeof(_shipView)shipSelf = _shipView;
    _shipView.mianfeiBtnBlook = ^()
    {
        NSLog(@"送货上门");
        
        [shipSelf.mianfeiBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
        [shipSelf.ziquBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
         weakSelf.shipping_id = @"1";
        // actid为1为送货上门
//        NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":weakSelf.good_id,@"act":@"shipping",@"actid":@"1"};
//        [weakSelf modifiyRequestDataWithDic:params withTitle:@"送货上门"];
//        
    };
    _shipView.ziquBtnBlook = ^()
    {
        weakSelf.shipping_id = @"2";
        [shipSelf.mianfeiBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        [shipSelf.ziquBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
//        NSLog(@"上门自取");
//        // actid为2为上门自取
//        NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":weakSelf.good_id,@"act":@"shipping",@"actid":@"2"};
//        [weakSelf modifiyRequestDataWithDic:params withTitle:@"上门自取"];
//        
    };
    
    
    [_bagView addSubview:_shipView];
    
    
    
    // 支付方式
    UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 170 *kHeightScale, KScreenW, 1)];
    line3.backgroundColor = RGBA(241, 241, 241, 1);
    [_bagView addSubview:line3];
    
    UILabel *lab3  = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 180 *kHeightScale, 80 *kWidthScale, 16 *kHeightScale) text:@"支付方式" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15*kHeightScale];
    [_bagView addSubview:lab3];
    self.payNameLab = [[UILabel alloc]initWithFrame:CGRectMake(90*kWidthScale, 180*kHeightScale, 120*kWidthScale, 16*kHeightScale)];
    self.payNameLab.textColor = [UIColor grayColor];
    self.payNameLab.font = [UIFont systemFontOfSize:15 *kHeightScale];
    self.payNameLab.textAlignment = NSTextAlignmentLeft;
    [_bagView addSubview:self.payNameLab];
    
    
    UIImageView *arrow3 = [[UIImageView alloc]init];
    arrow3.frame = CGRectMake(KScreenW - 40 *kWidthScale, 180*kHeightScale, 25 *kWidthScale, 16*kHeightScale) ;
    arrow3.image = [UIImage imageNamed:@"arrow@2x"];
    [_bagView addSubview:arrow3];
    
    self.payView = [[OrderPayTypeView alloc]initWithFrame:CGRectMake(0, 210 *kHeightScale, KScreenW, 90 *kHeightScale)];
    [_bagView addSubview:_payView];
 
    __weak typeof(_payView)payViewSelf = _payView;
    _payView.weChatPayBtnBlook = ^(){
        NSLog(@"微信支付回调");
        [payViewSelf.weChatPayBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
        [payViewSelf.aliPayBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        weakSelf.pay_id = @"1";
      
       
        // actid为1为微信支付
//        NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":weakSelf.good_id,@"act":@"pay",@"actid":@"1"};
//        [weakSelf modifiyRequestDataWithDic:params withTitle:@"修改微信"];
//        ;
    };
    _payView.aliPayBtnBlook = ^(){
        
        NSLog(@"支付宝支付回调");
        [payViewSelf.weChatPayBtn setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        [payViewSelf.aliPayBtn setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
           weakSelf.pay_id = @"2";
        // actid 为2为支付宝支付
//        NSDictionary *params = @{@"user_id":userInfo.user_id,@"oid":weakSelf.good_id,@"act":@"pay",@"actid":@"2"};
//        [weakSelf modifiyRequestDataWithDic:params withTitle:@"修改支付宝"];
    };
    
    
    
    // 发票信息
    UILabel *line4= [[UILabel alloc]initWithFrame:CGRectMake(0, 335 *kHeightScale, KScreenW, 1)];
    line4.backgroundColor =RGBA(241, 241, 241, 1);
    [_bagView addSubview:line4];
    
    UILabel *lab4  = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 350 *kHeightScale, 80 *kWidthScale, 16 *kHeightScale) text:@"备注信息:" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15*kHeightScale];
    [_bagView addSubview:lab4];
    
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(100 *kWidthScale, 350*kHeightScale, 240 *kWidthScale, 16 *kHeightScale) text:@"选填:对本次交易的说明(建议填写)" textAlignment:NSTextAlignmentLeft textColor:[UIColor grayColor] bgColor:nil font:14*kHeightScale];
    [_bagView addSubview:titleLab];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(15 *kWidthScale, 370 *kHeightScale, KScreenW - 30 *kWidthScale, 60 *kHeightScale)];
    _textView.backgroundColor = RGBA(249, 249, 249, 1);
    self.textView.delegate = self;
    [_bagView addSubview:_textView];
    
    
    return _bagView;
}

#pragma mark TextView的代理方法

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
    self.tableView.contentOffset = CGPointMake(0, 700);
    return YES;
}
// 创建底部视图
- (void)setUpBottomView
{    UIView *bagView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - 48 *kHeightScale, KScreenW, 48*kHeightScale)];
    bagView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bagView];
    
    // 合计
    UILabel *totallMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(125 *kWidthScale, 5 *kHeightScale, 140 *kWidthScale, 48 *kHeightScale)];
    totallMoneyLab.text = [NSString stringWithFormat:@"合计:%@",self.zongprice];
    totallMoneyLab.textColor = [UIColor redColor];
    [bagView addSubview:totallMoneyLab];
      // 去付款
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(KScreenW - 100 *kWidthScale , 5 *kHeightScale, 110 *kWidthScale, 48 *kHeightScale);
    payBtn.backgroundColor = RGBA(52, 162, 252, 1);
    [payBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bagView addSubview:payBtn];
    
    
}

// 去付款
- (void)payBtnAction:(UIButton *)sender
{
    NSLog(@"提交订单");
    [self commitRequestData];
    }

#pragma mark - tableView代理
// 开始拖动的时候结束编辑
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
  
    

    OrderConfirmModel *sectionModel =self.sectionModelArray[section];
    
    
    if (self.isFold) {
        // 如果折叠
        return 0;
    }else{
        
        // 如果不折叠
        if (sectionModel.isOpen) {
            return  sectionModel.good_attr.count;
        }else{
            return 0;
        }

        
        
    }
    
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionModelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85 *kHeightScale;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderNewDetaiTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    OrderConfirmModel *sectionModel = self.sectionModelArray[indexPath.section];
    for (NSDictionary *dic in sectionModel.good_attr) {
       ShopCarModel*model = [[ShopCarModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [sectionModel.modelArr addObject:model];
        
    }
    
    ShopCarModel *model = sectionModel.modelArr[indexPath.row];
      cell.goodName.text = model.namestr;
    cell.orderMoneyLab.text = model.attrprice;
    cell.shopNumberLab.text= model.num;
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShopSectionHeadView *shopHeadView =[[ShopSectionHeadView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 95 *kHeightScale)];
     OrderConfirmModel *sectionModel = self.sectionModelArray[section];
   
   
    [shopHeadView.goodImgView  sd_setImageWithURL:[NSURL URLWithString:sectionModel.good_img]];
    shopHeadView.backgroundColor = [UIColor whiteColor];
    shopHeadView.goodNameLab.text = sectionModel.good_name;
    
    
    shopHeadView.addBtn.hidden = YES;
    shopHeadView.cutBtn.hidden = YES;
    shopHeadView.numberTextField.hidden = YES;
    shopHeadView.addImgView.hidden = YES;
    
    if (sectionModel.good_attr.count > 0) {
        // 有属性时隐藏加减框
      
    }else{
        shopHeadView.roateBtn.hidden = YES;
    
    }
    
    
    //  旋转按钮回调(折叠方式)
    shopHeadView.roateSectionBtn = ^(BOOL isPen){
        if (sectionModel.isOpen) {
            // 控制折叠与展开
            sectionModel.isOpen = NO;
            [self.sectionModelArray replaceObjectAtIndex:section withObject:sectionModel];
            [self.tableView reloadData];
            
        }else{
            // 控制折叠与展开
            sectionModel.isOpen =YES;
            [self.sectionModelArray replaceObjectAtIndex:section withObject:sectionModel];
            [self.tableView reloadData];
            
            }
        
    };

    
    //  根据isOpen来判断要显示的图标
    if (sectionModel.isOpen) {
        UIImage *roateImg = [UIImage imageNamed:@"arrow_after"];
        roateImg = [roateImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [shopHeadView.roateBtn setImage:roateImg forState:UIControlStateNormal];
    }else{
        UIImage *roateImg = [UIImage imageNamed:@"arrow_before"];
        roateImg = [roateImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [shopHeadView.roateBtn setImage:roateImg forState:UIControlStateNormal];
        
    }
    

    
    
       return shopHeadView;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    ShopSectionFooterView *shopFooterView = [[ShopSectionFooterView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 32 *kHeightScale)];
    
    OrderConfirmModel *sectionMode = self.sectionModelArray[section];
    if (sectionMode.good_attr.count == 0) {    // 无属性时
        shopFooterView.goodNumberLab.text = [NSString stringWithFormat:@"共%ld件",(long)sectionMode.good_num];
        double price = [sectionMode.price doubleValue];
        double num = [sectionMode.num doubleValue];
        double totallmoney = price *num;
        shopFooterView.goodPriceLab.text = [NSString stringWithFormat:@"¥%.2f",totallmoney];
    }else{
        // 有属性时
        shopFooterView.goodNumberLab.text = [NSString stringWithFormat:@"共%@种%ld件",sectionMode.good_zhong,(long)sectionMode.good_num];

        shopFooterView.goodPriceLab.text = [NSString stringWithFormat:@"¥%.2f",sectionMode.good_price];
    }
    
      
    shopFooterView.backgroundColor = [UIColor whiteColor];
  
    return shopFooterView;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 105 *kHeightScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 32 *kHeightScale;
}

#pragma mark - 提交订单请求数据
- (void)commitRequestData{
  
    if (self.shipping_id.length == 0 || self.pay_id.length == 0) {
        // 没有选择地址和支付方式
        UIAlertController *aletVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"请勾选配送方式和支付方式!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [aletVC addAction:confirmAction];
        [self presentViewController:aletVC animated:YES completion:nil];
    }else{
        // 已经选择支付方式和配送方式
        
        NSString *url = [NSString stringWithFormat:@"%@api/doneorder.php",baseUrl];
        UserInfo *userInfo = [UserInfo currentAccount];
        NSDictionary *params = @{@"user_id":userInfo.user_id,@"directbuy":self.directbuy,@"address_id":self.address_id,@"shipping_id":self.shipping_id,@"remarks":self.textView.text,@"pay_id":self.pay_id};
        
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
            NSLog(@"提交订单请求数据成功%@",responseObject);
            
            OrderNewCompleteViewController *ordelCompleteVC =[[OrderNewCompleteViewController alloc]init];
            ordelCompleteVC.payDic = responseObject;
            ordelCompleteVC.pay_id = self.pay_id;
        
                 [self.navigationController pushViewController:ordelCompleteVC animated:YES];
        
           
            
        } enError:^(NSError *error) {
            NSLog(@"提交订单请求数据失败%@",error);
        }];

    }
    
   }

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
    titleLab.text = @"订单空空的,去挑几件好货吧!";
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
