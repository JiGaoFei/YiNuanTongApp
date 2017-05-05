//
//  OptionViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "OptionViewController.h"
#import "OptionCell.h"
#import "SingLeton.h"
#import "YNTUITools.h"
#import "OptionListViewController.h"
#import "YNTNetworkManager.h"
#import <MJExtension/MJExtension.h>
#import "MineConmentListModel.h"
#import "UIScrollView+EmptyDataSet.h"

@interface OptionViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**存放数据*/
@property (nonatomic,strong) NSMutableArray  * dataArray;
/**新增反馈地址*/
@property (nonatomic,strong)  UIButton *addOptionBtn;
@end
static NSString *optionCell = @"optionCell";
@implementation OptionViewController
#pragma mark - 懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        self.dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
 
    self.tabBarController.tabBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
        self.tabBarController.tabBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
  
  }
    // 加载数据
- (void)loadData
{
    // 清空数据源
    [self.dataArray removeAllObjects];
    UserInfo *userInfo = [UserInfo currentAccount];
// 请求列表数据
    NSString *url = [NSString stringWithFormat:@"%@api/feedback.php",baseUrl];
    NSDictionary *params = @{@"user_id":userInfo.user_id};
    
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *dataArr = returnDic[@"data"];
        
            
        for (NSDictionary *dic in dataArr) {
                MineConmentListModel *model = [[MineConmentListModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:model];
             
                
            }
      
            if (self.tableView) {
                [self.tableView reloadData];
            }else{
                // 加载子视图
                [self setUpChildrenViews];
             
            }
          
        if (self.dataArray.count >0) {
            // 加载底部视图
            [self setUpBottomViews];
        }
        
     
        
    } enError:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
/**
 *加载子视图
 */
- (void)setUpChildrenViews
{
    // 创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, kScreenH-64-52) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.tableFooterView = [UIView new];
    // 注册cell
    [self.tableView registerClass:[OptionCell class] forCellReuseIdentifier:optionCell];
       [self.view  addSubview:self.tableView];
    
}
/**
 *创建底部视图
 */
- (void)setUpBottomViews
{
   // NSLog(@"创建底部视图");
    UIButton *addOptionBtn = [YNTUITools createButton:CGRectMake(0, kScreenH - 50, KScreenW, 50) bgColor:CGRBlue title:@"新增反馈" titleColor:[UIColor whiteColor] action:@selector(addOptionBtnAction:) vc:self];
    self.addOptionBtn = addOptionBtn;
    [self.view addSubview:addOptionBtn];
}
#pragma mark - 新增按钮的点击事件
- (void)addOptionBtnAction:(UIButton *)sender
{
    NSLog(@"我是新增地址反馈");
    OptionListViewController *optionListVC = [[OptionListViewController alloc]init];
    optionListVC.editSuccessBlock = ^(){
        self.tableView.frame =CGRectMake(0, 0, KScreenW, kScreenH-64-52);
        [self loadData];
    };
    
    [self.navigationController pushViewController:optionListVC animated:YES];
    
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:optionCell forIndexPath:indexPath];
    MineConmentListModel *model = self.dataArray[indexPath.row];
    
    
    [cell setValueWithModel:model];

    // 取消cell的选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArray.count == 0) {
        return 0;
    }
        MineConmentListModel *model=self.dataArray[indexPath.row];

  
    NSDictionary *fontDic=@{NSFontAttributeName:[UIFont systemFontOfSize:14 * kHeightScale]};
    CGSize size1=CGSizeMake(KScreenW,0);
    CGSize titleLabelSize=[model.content boundingRectWithSize:size1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading   attributes:fontDic context:nil].size;
    if (titleLabelSize.height < 30 *kHeightScale) {
        return 70 *kHeightScale;
  
          }
          return  titleLabelSize.height + 55 *kHeightScale ;
  }

#pragma mark - 数据为空时处理
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    [self.addOptionBtn removeFromSuperview];
    return [UIImage imageNamed:@"feedback_empty"];
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"address_-empty_to_add"];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    NSLog(@"你要想添加吗");
    OptionListViewController *optionListVC = [[OptionListViewController alloc]init];
    optionListVC.editSuccessBlock = ^(){
        self.tableView.frame =CGRectMake(0, 0, KScreenW, kScreenH-64-52);
        [self loadData];
    };
    
    [self.navigationController pushViewController:optionListVC animated:YES];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"请告诉我们,您遇到的问题!";
    
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
