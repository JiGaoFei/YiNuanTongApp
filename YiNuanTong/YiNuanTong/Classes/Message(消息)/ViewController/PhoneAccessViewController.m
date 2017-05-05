//
//  PhoneAccessViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/14.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "PhoneAccessViewController.h"
#import "PhoneListCell.h"
#import "YNTNetworkManager.h"
#import "PhoneAccessModel.h"
@interface PhoneAccessViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**存放数据模型*/
@property (nonatomic,strong) NSMutableArray  * modelArray;
@end
static NSString *phoneCell = @"phoneCell";
@implementation PhoneAccessViewController
#pragma mark -懒加载
- (NSMutableArray *)modelArray
{
    if (!_modelArray) {
        self.modelArray = [[NSMutableArray alloc]init];
    }
    return _modelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电话咨询";
    self.view.backgroundColor =[UIColor whiteColor];
    // 加载数据
    [self loadData];
    [self setUpChildrenViews];
    // Do any additional setup after loading the view.
}
/**
 *加载数据
 */
- (void)loadData
{
    UserInfo *userInfo = [UserInfo currentAccount];
    // 请求电话列表数据
    NSString *url = [NSString stringWithFormat:@"%@api/hotphonelist.php",baseUrl];
    
    NSDictionary *param = @{@"user_id":userInfo.user_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"请求电话列表数据成功%@",responseObject);
        
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *dataArray = returnDic[@"data"];
        for (NSDictionary *dic  in dataArray) {
            PhoneAccessModel *model = [[PhoneAccessModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.modelArray addObject:model];
            
            }
        if (self.tableView) {
            [self.tableView reloadData];
            
        }else{
            [self setUpChildrenViews];
        }
    } enError:^(NSError *error) {
        NSLog(@"请求电话列表数据失败%@",error);
    }];
}
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH) style:UITableViewStylePlain];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerClass:[PhoneListCell class] forCellReuseIdentifier:phoneCell];
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
    PhoneListCell *cell = [tableView dequeueReusableCellWithIdentifier:phoneCell forIndexPath:indexPath];
    PhoneAccessModel *model = self.modelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    cell.titleLab.text = model.type;
    cell.contentLab.text =model.telphone;
    cell.imgView.image  =  [UIImage imageNamed:@"客服"];
   __weak typeof(cell)  weakSelf = cell;
    cell.buttonClicked = ^(NSInteger index) {
        if (index == 1810) {
            NSLog(@"我要打电话了");
            
           
            UIWebView *webView = [[UIWebView alloc]init];
            [weakSelf.contentView addSubview:webView];
             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",model.telphone]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [webView loadRequest:request]; 
            
        }
    };
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


@end
