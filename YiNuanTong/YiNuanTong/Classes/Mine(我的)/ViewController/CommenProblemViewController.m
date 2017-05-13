//
//  CommenProblemViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "CommenProblemViewController.h"
#import "CommentProblemCell.h"
#import "YNTNetworkManager.h"
#import "CommenProblemModel.h"
#import "CommentProblemDetaiViewController.h"
@interface CommenProblemViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**问题数组*/
@property (nonatomic,strong) NSMutableArray  * problemArr;
/**答案数组*/
@property (nonatomic,strong) NSMutableArray  * questionArr;
@end
static NSString *commentCell = @"commentCell";
@implementation CommenProblemViewController

/**
 *懒加载创建数组
 */
- (NSMutableArray *)problemArr
{
    if (!_problemArr) {
        self.problemArr = [[NSMutableArray alloc]init];
        
    }
    return _problemArr;
}
- (NSMutableArray *)questionArr
{
    if (!_questionArr) {
        self.questionArr = [[NSMutableArray alloc]init];
    }
    return _questionArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常见问题";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    // 加载子视图
    [self setUpChildrenViews];
    
    // Do any additional setup after loading the view.
}
#pragma mark - 加载数据
- (void)loadData
{
    NSString *url = [NSString stringWithFormat:@"%@api/problem.php",baseUrl];
    NSDictionary *params = @{@"page":@"1",@"act":@"list",@"pagesize":@"100"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"请求常见问题数据成功%@",responseObject);
        // 清空数据源
        [self.problemArr removeAllObjects];
        
        NSArray *arr = responseObject[@"data"];
        for (NSDictionary *dic in arr) {
            CommenProblemModel *model = [[CommenProblemModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.problemArr addObject:model];
        }
        
        if (self.tableView) {
            [self.tableView reloadData];
        }else{
            [self setUpChildrenViews];
        }
    } enError:^(NSError *error) {
        NSLog(@"请求常见问题数据失败%@",error);
    }];
}
/**
 *加载子视图
 */
- (void)setUpChildrenViews
{
    self.tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 *kHeightScale, KScreenW, kScreenH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
  
    // 注册cell
    [self.tableView registerClass:[CommentProblemCell class] forCellReuseIdentifier:commentCell];
    [self.view addSubview:self.tableView];
    
}
#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.problemArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCell forIndexPath:indexPath];
    CommenProblemModel *model = self.problemArr[indexPath.row];
    cell.nameLab.text = model.title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48 *kHeightScale;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentProblemDetaiViewController *commentProblemDetailVC = [[CommentProblemDetaiViewController alloc]init];
    CommenProblemModel *model = self.problemArr[indexPath.row];
    commentProblemDetailVC.problem_id = model.problem_id;
    [self.navigationController pushViewController:commentProblemDetailVC animated:YES];
}
@end
