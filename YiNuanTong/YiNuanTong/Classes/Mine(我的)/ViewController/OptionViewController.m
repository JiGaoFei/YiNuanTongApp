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


@interface OptionViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**存放数据*/
@property (nonatomic,strong) NSMutableArray  * dataArray;
/**emptyViews*/
@property (nonatomic,strong) UIView  * emptyViews;
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
            [self.emptyViews removeFromSuperview];
        }else{
            [self setUpEmptyViews];
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

#pragma mark - 空数据处理

- (void)setUpEmptyViews
{
    self.emptyViews = [[UIView alloc]initWithFrame:CGRectMake(0, 105, KScreenW, kScreenH)];
    self.emptyViews.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.emptyViews];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW / 2 - 50 *kWidthScale, 83 *kHeightScale, 100 *kWidthScale, 124 *kHeightScale)];
    imgView.image = [UIImage imageNamed:@"feedback_empty"];
    [self.emptyViews addSubview:imgView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(65 *kWidthScale, 296 *kHeightScale, KScreenW - 130 *kWidthScale, 16*kHeightScale)];
    titleLab.font = [UIFont systemFontOfSize:16 *kHeightScale];
    titleLab.text = @"请告诉我们,您遇到的问题";
    titleLab.textColor = RGBA(102, 102, 102, 1);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.emptyViews addSubview:titleLab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(147 *kWidthScale, 330 *kHeightScale, 80 *kWidthScale, 30 *kHeightScale);
    [btn setImage:[UIImage imageNamed:@"address_-empty_to_add"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goButAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.emptyViews addSubview:btn];
    
    
}
- (void)goButAction:(UIButton *)sender
{
    OptionListViewController *optionListVC = [[OptionListViewController alloc]init];
    optionListVC.editSuccessBlock = ^(){
        self.tableView.frame =CGRectMake(0, 0, KScreenW, kScreenH-64-52);
        [self loadData];
    };
    
    [self.navigationController pushViewController:optionListVC animated:YES];
}


@end
