//
//  AccountViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/22.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "AccountViewController.h"
#import "YNTUITools.h"
#import "AccountPayCell.h"
#import "YNTNetworkManager.h"
#import "AccountModel.h"
@interface AccountViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView */
@property (nonatomic,strong) UITableView  * tableView;
/**箭头view*/
@property (nonatomic,strong) UIImageView  * rowView;
/**消费记录数据*/
@property (nonatomic,strong) NSMutableArray *modeArray;

@end
static NSString *paycell = @"paycell";
@implementation AccountViewController
/** 懒加载 */
- (NSMutableArray *)modeArray
{
    if (!_modeArray) {
        self.modeArray = [[NSMutableArray alloc]init];
    }
    return _modeArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = YES;
     [self loadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"账户资金";
    self.view.backgroundColor =CGRBlue;
    [self loadData];
    // 加载子视图
    [self setUpChildrenViews];
    // Do any additional setup after loading the view.
}
- (void)loadData
{
    
    UserInfo *userInfo = [UserInfo currentAccount];
    NSString *url = [NSString stringWithFormat:@"%@api/app.php",baseUrl];
    NSDictionary *param = @{@"act":@"buylog",@"user_id":userInfo.user_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"消费记录请求数据成功%@",responseObject);
        // 清空数据源
        [self.modeArray removeAllObjects];
        for (NSDictionary *dic in responseObject) {
            AccountModel *model = [[AccountModel alloc]init];
        
            [model setValuesForKeysWithDictionary:dic];
            [self.modeArray addObject:model];
        }
        
        if (self.tableView) {
            [self.tableView reloadData];
        }else{
            [self setUpChildrenViews];
        }
   
          } enError:^(NSError *error) {
        NSLog(@"消费记录请求数据失败%@",error);
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
    // 注册cell
    [self.tableView registerClass:[AccountPayCell class] forCellReuseIdentifier:paycell];
    [self.view addSubview:self.tableView];
    
    UIView *headerView = [self setUpChildrenHeaderView];
    
    self.tableView.tableHeaderView=headerView;
}
/**
 *创建表头视图
 */
- (UIView *)setUpChildrenHeaderView
{
    UserInfo *userInfo = [UserInfo currentAccount];
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 140 *kHeightScale)];
    bigView.backgroundColor = CGRBlue;
    // 创建返回btn
    UIButton *backBtn = [YNTUITools createButton:CGRectMake(21.5, 18, 25/2, 32/2) bgColor: nil title:nil titleColor:nil action:@selector(backBtnAction:) vc:self];
    UIImage *backImg = [UIImage imageNamed:@"返回箭头"];
    backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    
    [bigView  addSubview:backBtn];
    //创建虚线
    UIImageView *lineView = [YNTUITools createImageView:CGRectMake(KScreenW/ 2, 75 *kHeightScale, 1, 50 *kPlus *kHeightScale) bgColor:nil imageName:@"分割虚线"];
    [bigView addSubview:lineView];
    
    // 创建审核进度lab
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(KScreenW /2 -75, 18, 150, 18) text:@"账户资金" textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:17];
    [bigView addSubview:titleLab];
    
    // 创建账户lab
    UILabel *accountLab = [YNTUITools createLabel:CGRectMake(117 *kPlus *kWidthScale, 75 *kHeightScale, 100, 18 ) text:userInfo.amount textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] bgColor:CGRBlue font:18];
    if (KScreenW == 320) {
        accountLab.font = [UIFont systemFontOfSize:16];
    }
    [bigView addSubview:accountLab];
    // 创建信用币lab
    
    UILabel *creditLab = [YNTUITools createLabel:CGRectMake(KScreenW - (117 *kPlus+100) *kWidthScale, 75 *kHeightScale, 100, 18 ) text:@"0.00" textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] bgColor:CGRBlue font:18];
    if (KScreenW == 320) {
        creditLab.font = [UIFont systemFontOfSize:16];
    }
    [bigView addSubview:creditLab];
    
        // 创建余额btn
   UIButton *accountBtn = [YNTUITools createButton:CGRectMake((117 *kPlus-15) *kWidthScale, 103 *kHeightScale, 100 *kWidthScale, 18 *kHeightScale) bgColor:CGRBlue title:@"账户余额" titleColor:[UIColor whiteColor] action:@selector(accountBtnAction:) vc:self];
    accountBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    if (KScreenW == 320) {
          accountBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    accountBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [bigView addSubview:accountBtn];
    
    // 创建信用币btn
UIButton*creditBtn = [YNTUITools createButton:CGRectMake(KScreenW - (117 *kPlus + 100 +20) *kWidthScale, 103 *kHeightScale, 100 *kWidthScale, 18 *kHeightScale) bgColor:CGRBlue title:@"信用币" titleColor:[UIColor whiteColor] action:@selector(creditBtnAction:) vc:self];
       creditBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    if (KScreenW == 320) {
        creditBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }

 
    [bigView addSubview:creditBtn];
    
    //创建箭头
   self.rowView = [YNTUITools createImageView:CGRectMake(0, 131 *kHeightScale, KScreenW/2 , 38 *kPlus *kHeightScale) bgColor:nil imageName:@"箭头形状"];
    [bigView addSubview:_rowView];
    
    return bigView;
}
#pragma mark - 返回按钮的点击
- (void)backBtnAction:(UIButton *)sender
{
    NSLog(@"返回");
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)accountBtnAction:(UIButton *)sender
{
    NSLog(@"账户余额");
  [UIView animateWithDuration:0.5 animations:^{
      CGRect rect  = self.rowView.frame;
      rect .origin.x = 0;
      self.rowView.frame = rect;
  }
  ];
}
- (void)creditBtnAction:(UIButton *)sender
{
    NSLog(@"信用币余额");
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect  = self.rowView.frame;
        rect .origin.x = KScreenW/2;
        self.rowView.frame = rect;
    }
     ];

}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _modeArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AccountPayCell *cell  =[tableView dequeueReusableCellWithIdentifier:paycell forIndexPath:indexPath];
    AccountModel *model = self.modeArray[indexPath.row];
    cell.nameLab.text = [NSString stringWithFormat:@"订单编号:%@",model.sn];
    cell.timeLab.text = model.add_time;
    cell.priceLab.text = [NSString stringWithFormat:@"-%@",model.amount];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
