//
//  ApplyRefundViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/13.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "ApplyRefundViewController.h"
#import "OrderCell.h"
#import "OrderListViewController.h"
#import "YNTNetworkManager.h"
#import "OrderModel.h"
#import "ApplyRefundDetailViewController.h"
#import "UIScrollView+EmptyDataSet.h"
@interface ApplyRefundViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**存放数组的model*/
@property (nonatomic,strong) NSMutableArray  * modelArr;
@end
static NSString *orderCell = @"orderCell";
@implementation ApplyRefundViewController

#pragma mark - 懒加载
- (NSMutableArray *)modelArr
{
    if (!_modelArr) {
        self.modelArr = [[NSMutableArray alloc]init];
    }
    return _modelArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"申请退换货";
    // 加载视图
    [self setUpChildrenViews];
    [self loadData];
}

- (void)loadData
{ UserInfo *userInfo = [UserInfo currentAccount];
    // 清空数据源
    [self.modelArr removeAllObjects];
    // 请求订货单列表数据
    NSString *url = [NSString stringWithFormat:@"%@api/orderclass.php",baseUrl];
    NSDictionary *param= @{@"user_id":userInfo.user_id,@"act":@"list",@"status":@"4"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        
        NSLog(@"请求订货单列表数据成功%@",responseObject);
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        
        NSArray *dataArray = returnDic[@"data"];
        
        
        for (NSDictionary *dic in dataArray) {
            OrderModel *model = [[OrderModel alloc]init];

            [model setValuesForKeysWithDictionary:dic];
            
            if ([model.status isEqualToString:@"4"]) {
                [self.modelArr addObject:model];
            }
           
        }
        if (self.tableView) {
            [self.tableView reloadData];
        }else{
            [self setUpChildrenViews];
        }
    } enError:^(NSError *error) {
        NSLog(@"请求订货单列表数据失败%@",error);
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
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    // 注册cell
    [self.tableView registerClass:[OrderCell class] forCellReuseIdentifier:orderCell];
    
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCell forIndexPath:indexPath];
    OrderModel *model = self.modelArr[indexPath.row];
    cell.orderNumberLab.text = [NSString stringWithFormat:@"订单号:%@",model.sn];
    cell.orderCompleteStatusLab.text = @"已完成";
    cell.shopNumberLab.text = [NSString stringWithFormat:@"数量:%@",model.goodsnum];
    cell.orderTimeLab.text = [NSString stringWithFormat:@"时间:%@",model.add_time];
    cell.orderMoneyNumberLab.text =[NSString stringWithFormat:@"金额:%@(已付款)",model.order_amount];
    
    cell.remindSendGoodBtn.hidden = YES;
    ApplyRefundDetailViewController *applyRefundDetailVC = [[ApplyRefundDetailViewController alloc]init];
    
    if ([model.returnstatus isEqualToString:@"0"]) {
          cell.orderCompleteStatusLab.text = @"已收货";
    }
    if ([model.returnstatus isEqualToString:@"1"]) {
        cell.orderCompleteStatusLab.text = @"处理中";
        cell.immediatelyBtn.hidden = YES;
        cell.secondTimeBtn.hidden = YES;
    }

    if ([model.returnstatus isEqualToString:@"2"]) {
        cell.orderCompleteStatusLab.text = @"处理完成";
        cell.immediatelyBtn.hidden = YES;
        cell.secondTimeBtn.hidden = YES;
    }

    UIImage * seconImgs =[UIImage imageNamed:@"申请退货"];
    seconImgs = [seconImgs imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [cell.secondTimeBtn setImage: seconImgs forState:UIControlStateNormal];
    
   
    UIImage *immediatelyImgs =[UIImage imageNamed:@"申请换货"];
    immediatelyImgs = [immediatelyImgs imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

      [cell.immediatelyBtn setImage:immediatelyImgs forState:UIControlStateNormal];
    
    cell.buttonClicked = ^(NSInteger index){
        switch (index) {
            case 2200:
            {
                NSLog(@"点击的是申请退货");
                UserInfo *userInfo = [UserInfo currentAccount];
                // 向服务器传送数据
                NSString *url = [NSString stringWithFormat:@"%@api/orderreturnclass.php",baseUrl];
                NSDictionary *params = @{@"order_id":model.order_id,@"user_id":userInfo.user_id,@"act":@"returngoods"};
                
                [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
                    NSLog(@"申请退货请求成功%@",responseObject);
                    [self loadData];
                } enError:^(NSError *error) {
                    NSLog(@"申请退货请求失败%@",error);
                }];
                applyRefundDetailVC.titleName =@"申请退货";
                [self.navigationController pushViewController:applyRefundDetailVC animated:YES];
            }
                break;
            case 2201:
            {
                NSLog(@"点击的是申请换货");
                UserInfo *userInfo = [UserInfo currentAccount];
                // 向服务器传送数据
                NSString *url = [NSString stringWithFormat:@"%@api/orderreturnclass.php",baseUrl];
                NSDictionary *params = @{@"order_id":model.order_id,@"user_id":userInfo.user_id,@"act":@"returngoods"};
                
                [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
                    NSLog(@"申请退货请求成功%@",responseObject);
                    [self loadData];
                } enError:^(NSError *error) {
                    NSLog(@"申请退货请求失败%@",error);
                }];

                
                applyRefundDetailVC.titleName =@"申请换货";
                [self.navigationController pushViewController:applyRefundDetailVC animated:YES];

            }
                break;

            case 2202:
            {
                NSLog(@"点击的是提醒发货");
            }
                break;

                
            default:
                break;
        }
    };
    
    // 取消cell的选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListViewController *orderListVC = [[OrderListViewController alloc]init];
    [self.navigationController pushViewController:orderListVC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderModel *model = self.modelArr[indexPath.row];
    if (![model.returnstatus isEqualToString:@"0"]) {
        return 100;
    }

    return 125;
}
#pragma mark - 数据为空时处理
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"no_data"];
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"visit-"];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    NSLog(@"你要想添加吗");
    self.tabBarController.selectedIndex = 0;
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"空空哒,快去逛逛吧!";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
@end
