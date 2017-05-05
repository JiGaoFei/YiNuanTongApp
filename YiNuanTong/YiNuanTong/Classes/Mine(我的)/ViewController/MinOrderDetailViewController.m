//
//  MinOrderDetailViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "MinOrderDetailViewController.h"
#import "OrderCell.h"
#import "CompanyViewController.h"
@interface MinOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
@end
static NSString *orderCell = @"orderCell";
@implementation MinOrderDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title =_titleStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 加载子视图
    [self setUpChildrenViews];
}

/**
 *加载子视图
 */
- (void)setUpChildrenViews
{
    //创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH -64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册cell
    [self.tableView registerClass:[OrderCell class] forCellReuseIdentifier:orderCell];
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:orderCell forIndexPath:indexPath];
    cell.orderNumberLab.text = @"订单号:56485414646546";
    cell.orderCompleteStatusLab.text = @"已完成";
    cell.shopNumberLab.text = @"数量:80";
    cell.orderTimeLab.text = @"时间:2017-12-06 18:06:57";
    cell.orderMoneyNumberLab.text =@"金额:666.66(已付款)";

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
