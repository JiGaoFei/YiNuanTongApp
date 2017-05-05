//
//  AddressSelectViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/2/9.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "AddressSelectViewController.h"
#import "AddressCell.h"
#import "YNTUITools.h"
#import "AddAddressViewController.h"
#import "MineAddressModel.h"
#import "YNTNetworkManager.h"
#import "AddressEditViewController.h"

@interface AddressSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**地址数组*/
@property (nonatomic,strong) NSMutableArray  * addressModelArr;
/**选中的行数*/
@property (nonatomic,strong) NSIndexPath  * lastIndexPath;


@end
static NSString *addressCell = @"addressCells";
@implementation AddressSelectViewController

#pragma mark - 懒加载
- (NSMutableArray *)addressModelArr
{
    if (!_addressModelArr) {
        self.addressModelArr = [[NSMutableArray alloc ]init];
    }
    return _addressModelArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //每次视图将要出现的时候就刷新视图
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    self.view.backgroundColor = [UIColor whiteColor];
  
}

- (void)loadData
{
    // 加载圈
    [GFProgressHUD showLoading:@"正在加载数据"];
    UserInfo *userInfo = [UserInfo currentAccount];
    // 清空数据源
    [self.addressModelArr removeAllObjects];
    // 请求地址列表数据
    NSString *url = [NSString stringWithFormat:@"%@api/addressclass.php",baseUrl];

    NSDictionary *param = @{@"user_id":userInfo.user_id,@"act":@"list"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"请求成功%@",responseObject);
        // 隐藏加载圏
        [GFProgressHUD hide];
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *dataArr = returnDic[@"data"];
        
        for (NSDictionary *dic in dataArr) {
            MineAddressModel *model = [[MineAddressModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.addressModelArr addObject:model];
            NSLog(@"%@",model.consignee);
        }
        [self setUpChildrenViews];
        
    } enError:^(NSError *error) {
        NSLog(@"请求失败%@",error);
    }];
    
}
/**
 *创建表尾视图
 */
- (UIView *)setUpFootViews
{
    UIButton *addBtn = [YNTUITools createButton:CGRectMake(0, 0, KScreenW, 40) bgColor:CGRBlue title:@"新增地址"  titleColor:[UIColor whiteColor] action:@selector(addBtnAction:) vc:self];
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 40)];
    [footView addSubview:addBtn];
    return footView;
}
- (void)addBtnAction:(UIButton *)sender
{
    NSLog(@"我是新增地址");
    AddAddressViewController *addAddVC  = [[AddAddressViewController alloc]init];
    [self.navigationController pushViewController:addAddVC animated:YES];
}
- (void)setUpChildrenViews
{
    //创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, kScreenH -64) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 表尾视图
    UIView *footView = [self setUpFootViews];
    self.tableView.tableFooterView = footView;
    // 注册cell
    [self.tableView registerClass:[AddressCell class] forCellReuseIdentifier:addressCell];
    [self.view addSubview:self.tableView];
    
    
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressModelArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addressCell forIndexPath:indexPath];
    
    
    MineAddressModel *model = self.addressModelArr[indexPath.row];
    if ([model.isdefault isEqualToString:@"1"]) {
        UIImage *selectedImage = [UIImage imageNamed:@"勾选状态"];
        selectedImage  = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [cell.defaultBtn setImage:selectedImage forState:UIControlStateNormal];
    }
 
    UserInfo *userInfo = [UserInfo currentAccount];
    cell.buttonClicked = ^(NSInteger index){
        if (index == 1930) {
            
            NSString *url = [NSString stringWithFormat:@"%@api/addressclass.php",baseUrl];
            NSDictionary *param = @{@"user_id":userInfo.user_id,@"act":@"edit",@"isdefault":@"1",@"address_id":model.address_id};
            [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
                
                [self.addressModelArr removeAllObjects];
                [self loadData];
                self.settingAdress(model);
                [self.navigationController popViewControllerAnimated:YES];
            } enError:^(NSError *error) {
                NSLog(@"设置默认数据失败%@",error);
                
            }];
            
            
        }
        
        if (index == 1931) {
            
            AddressEditViewController *addressEditVC = [[AddressEditViewController alloc]init];
            MineAddressModel *model = self.addressModelArr[indexPath.row];
            addressEditVC.model = model;
            [self.navigationController pushViewController:addressEditVC animated:YES];
      
         
        }
        
        
        
        if (index == 1932) {
            
            // 删除收货地址接口
            NSLog(@"我是删除收货地址的回调");
            NSString *url = [NSString stringWithFormat:@"%@api/addressclass.php",baseUrl];
            NSDictionary *param = @{@"user_id":userInfo.user_id,@"act":@"del",@"address_id":model.address_id};
            [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
                
                [self loadData];
            } enError:^(NSError *error) {
                NSLog(@"删除数据失败%@",error);
                
            }];
            
        }
        
    };
    
    
    cell.nameLab.text =model.consignee;
    cell.phoneLab.text =model.mobile;
    cell.addressLab.text = [NSString  stringWithFormat:@"%@%@",model.province,model.address];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
    
}@end
