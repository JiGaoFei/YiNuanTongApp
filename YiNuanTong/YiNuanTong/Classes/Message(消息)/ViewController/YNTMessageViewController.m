//
//  YNTMessageViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTMessageViewController.h"
#import "PhoneAccessViewController.h"
#import "MessageListCell.h"
#import "SystemAnnouncementViewController.h"
#import "LatestPolicyViewController.h"
@interface YNTMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**图片数据源*/
@property (nonatomic,strong) NSMutableArray  * picImgArr;
@end
static NSString *messagListCell = @"messageListCell";
@implementation YNTMessageViewController
/**
 *懒加载
 */
- (NSMutableArray *)picImgArr
{
    if (!_picImgArr) {
        self.picImgArr = [[NSMutableArray alloc]init];
        
    }
    return _picImgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.view.backgroundColor = [UIColor greenColor];
    // 加载视图
    [self setUpChildrenViews];
    // 加载数据
    [self loadData];
    // Do any additional setup after loading the view.
}
/**
 *加载数据
 */
- (void)loadData
{
    self.picImgArr = @[@"message_online",@"message_phone",@"message_announcement",@"message_announcement"].mutableCopy;
}
/**
 *加载子视图
 */
- (void)setUpChildrenViews
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH) style:UITableViewStylePlain];
    self.view.backgroundColor = [UIColor orangeColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    // 注册cell
    [self.tableView registerClass:[MessageListCell class] forCellReuseIdentifier:messagListCell];
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:messagListCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *arr = @[@"在线咨询",@"电话咨询",@"系统公告",@"最新政策",@"升级公告"];
    
    cell.titleLab.text = arr[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:self.picImgArr[indexPath.row]];
    cell.contentLab.text = @"业务,订单,售后电话咨询客服";
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==1 ) {
        PhoneAccessViewController *phoneVC = [[PhoneAccessViewController alloc]init];
        [self.navigationController pushViewController:phoneVC animated:YES];
        
    }
    if (indexPath.row == 2) {
        SystemAnnouncementViewController *systemAnnouncementVC = [[SystemAnnouncementViewController alloc]init];
        [self.navigationController pushViewController:systemAnnouncementVC animated:YES];
    }
    if (indexPath.row == 3) {
        LatestPolicyViewController *latestPolicyVC = [[LatestPolicyViewController alloc]init];
        [self.navigationController pushViewController:latestPolicyVC animated:YES];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

@end
