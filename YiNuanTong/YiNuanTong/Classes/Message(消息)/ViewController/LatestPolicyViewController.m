//
//  LatestPolicyViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/1/12.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "LatestPolicyViewController.h"
#import "SystemAnnouncementModel.h"
#import "SystemAnnouncementCell.h"
#import "YNTNetworkManager.h"
#import "MessageWebViewController.h"
@interface LatestPolicyViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**model数据源*/
@property (nonatomic,strong) NSMutableArray  * modelArray;
@end
static NSString *identifier = @"identifier";

@implementation LatestPolicyViewController

#pragma mark - 懒加载
- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        self.modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最新政策";
    [self loadData];
    [self setUpChildViews];
}
/**
 *加载数据
 */
- (void)loadData
{
    NSString *url = [NSString stringWithFormat:@"%@api/getNewsclass.php",baseUrl];
    NSDictionary *param = @{@"cat_id":@"2"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *dataArray = returnDic[@"data"];
        for (NSDictionary *dic in dataArray) {
            SystemAnnouncementModel *model = [[SystemAnnouncementModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            [self.modelArray addObject:model];
            
            
        }
        if (self.tableView) {
            [self.tableView reloadData];
        }else{
            [self setUpChildViews];
        }
        NSLog(@"请求系统公告数据成功%@",responseObject);
    } enError:^(NSError *error) {
        NSLog(@"请求系统公告数据失败%@",error);
    }];
}

/**
 *加载视图
 */
- (void)setUpChildViews
{
    // 创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册cell
    [self.tableView registerClass:[SystemAnnouncementCell class] forCellReuseIdentifier:identifier];
    [self.view addSubview:self.tableView];
    
    
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemAnnouncementCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SystemAnnouncementModel *model = self.modelArray[indexPath.row];
    cell.backgroundColor = RGBA(249, 249, 249, 1);
    [cell setValueWithModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageWebViewController *messageWebVC = [[MessageWebViewController alloc]init];
    SystemAnnouncementModel *model = self.modelArray[indexPath.row];
    messageWebVC.titleUrl = model.article_url;
    [self.navigationController pushViewController:messageWebVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
