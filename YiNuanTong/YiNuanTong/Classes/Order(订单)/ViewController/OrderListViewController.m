//
//  OrderListViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/20.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderStatusCell.h"
#import "OrderDetailLineCell.h"
#import "OrderTransprotLabCell.h"
#import "OrderTransportCell.h"
#import "SingLeton.h"
#import "YNTUITools.h"
#import "YNTNetworkManager.h"
#import "OrderDetailModer.h"
#import "SecondBuyViewController.h"
@interface OrderListViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**model数据*/
@property (nonatomic,strong) OrderDetailModer  * model;
@end
 static NSString * statuscell = @"statuscell";
static NSString *detailincell = @"detaillinecell";
static NSString *transportLabCell = @"transportLabcell";
static NSString *transportCell = @"transportCell";
@implementation OrderListViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    SingLeton *singLeton = [SingLeton shareSingLetonHelper];
    self.tabBarController.tabBar.hidden = YES;
    singLeton.middleRoundBtn.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    SingLeton *singLeton = [SingLeton shareSingLetonHelper];
    self.tabBarController.tabBar.hidden = NO;
    singLeton.middleRoundBtn.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = RGBA(249, 249, 249, 1);
    // 加载数据
    [self loadData];
    // 加载子视图
    [self setUpChildrenViews];
   
}
- (void)loadData
{
    UserInfo *userInfo = [UserInfo currentAccount];
    // 请求订货详单数据
    NSString *url = [NSString stringWithFormat:@"%@api/orderclass.php",baseUrl];
    NSDictionary *param = @{@"user_id":userInfo.user_id,@"act":@"detail",@"order_id":self.order_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *dataArr =returnDic[@"data"];
        // 为空时直接返回
        if (dataArr.count == 0) {
            return ;
        }
        for (NSDictionary *dic in dataArr) {
            self.model = [[OrderDetailModer alloc]init];
            [_model setValuesForKeysWithDictionary:dic];

        }
        [self.tableView reloadData];
            NSLog(@"订单详情请求数据成功%@",responseObject);
    } enError:^(NSError *error) {
        NSLog(@"订单详情请求数据失败%@",error);

    }];
    
}

/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH) style:UITableViewStylePlain];
  
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //注册cell
    [self.tableView registerClass:[OrderStatusCell class] forCellReuseIdentifier:statuscell];
    [self.tableView registerClass:[OrderDetailLineCell class] forCellReuseIdentifier:detailincell];
    [self.tableView registerClass:[OrderTransprotLabCell class] forCellReuseIdentifier:transportLabCell];
  [self.tableView registerClass:[OrderTransportCell class] forCellReuseIdentifier:transportCell];
    // 创建表视图
    UIView *footerView = [self setUpFootViews];

   
    self.tableView.tableFooterView = footerView;
    
    [self.view addSubview:self.tableView];
    
}
/**
 *创建表尾视图
 */
- (UIView *)setUpFootViews
{
    UIButton *buyBtn = [YNTUITools createButton:CGRectMake(0, 0, KScreenW, 40) bgColor:RGBA(18, 122, 203, 1) title:@"再次购买"  titleColor:[UIColor whiteColor] action:@selector(buyAction:) vc:self];
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 40)];
    [footView addSubview:buyBtn];
    return footView;
}
/**
 *再次购买点击事件
 */
- (void)buyAction:(UIButton *)sender
{
    NSLog(@"点击的是再次购买");
    
    
        SecondBuyViewController *secondVC = [[SecondBuyViewController alloc]init];
        secondVC.order_id =self.order_id;
    
          [self.navigationController pushViewController:secondVC animated:YES];
 
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section>0 && section<3) {
        return 1;
    }
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        OrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:statuscell forIndexPath:indexPath];
        cell.companyNamelLab.text = [NSString stringWithFormat:@"公司名称:%@",self.model.companyname];
        cell.orderNumberLab.text = [NSString stringWithFormat:@"订货单号:%@",self.model.sn];
      
        cell.orderTimeLab.text =[NSString stringWithFormat:@"下单时间:%@",self.model.pay_code];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
      if (indexPath.section >0 &&indexPath.section <3) {
        OrderDetailLineCell *cell = [tableView dequeueReusableCellWithIdentifier:detailincell forIndexPath:indexPath];
        cell.backgroundColor = RGBA(249, 249, 249, 1);
        if (indexPath.section == 1) {
            cell.titleLab.text = @"订单金额";
            cell.contentLab.text = self.model.order_amount;
        }
        if (indexPath.section == 2) {
            cell.titleLab.text = @"付款记录";
            if ([self.model.pay_status isEqualToString:@"0"]) {
                cell.contentLab.text = @"待付款";
            }
            if ([self.model.pay_status isEqualToString:@"1"]) {
                cell.contentLab.text = @"已付款";
            }

        
        }

         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
  
    if (indexPath.section == 3) {
        OrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:statuscell forIndexPath:indexPath];
        cell.titleLab.text = @"出库/发货记录:";
        cell.companyNamelLab.text = [NSString stringWithFormat:@"物流公司:%@",self.model.shipping_name];
        cell.orderNumberLab.text = [NSString  stringWithFormat:@"%@",self.model.shipping_sn];
        
        cell.orderTimeLab.text = [NSString stringWithFormat:@"发货日期:%@",self.model.shipping_time];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    if (indexPath.section >3 &&indexPath.section <6) {
        OrderDetailLineCell *cell = [tableView dequeueReusableCellWithIdentifier:detailincell forIndexPath:indexPath];
        cell.backgroundColor = RGBA(249, 249, 249, 1);
        if (indexPath.section == 4) {
            cell.titleLab.text = @"买家留言";
            cell.contentLab.text = self.model.note;
        }
        if (indexPath.section == 5) {
            cell.titleLab.text = @"商品详单";
            cell.contentLab.text = [NSString stringWithFormat:@"商品总数%@",self.model.goodsnum];
        }
        
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    if ( indexPath.section ==6) {
        OrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:statuscell forIndexPath:indexPath];
   
            cell.titleLab.text = @"收货信息";
        cell.companyNamelLab.text = [NSString stringWithFormat:@"%@    %@",self.model.consignee,self.model.mobile];
        cell.orderNumberLab.text = self.model.address;
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
             return cell;
    }
    if (indexPath.section == 7) {
        OrderTransprotLabCell *cell = [tableView dequeueReusableCellWithIdentifier:transportLabCell forIndexPath:indexPath];
        cell.titleLab.text = @"物流追踪:";

           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if (indexPath.section == 8) {
        OrderTransportCell *cell = [tableView dequeueReusableCellWithIdentifier:transportCell forIndexPath:indexPath];
        cell.titleLab.text = @"订单生成 ";
        cell.contentLab.text = @"郑州张三电料有限公司";
        cell.timeLab.text = @"2017-12-06 19:17:20";
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100;
    }
    if (indexPath.section >0 && indexPath.section <3) {
        return 40;
    }
    if (indexPath.section == 3) {
        return 100;
    }
    if (indexPath.section >3 && indexPath.section <6) {
        return 40;
    }
    if (indexPath.section == 6) {
        return 100;
    }
    if (indexPath.section == 7) {
        return 32;
    }
    if (indexPath.section == 8) {
        return 50;
    }
    

    return 10;
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
