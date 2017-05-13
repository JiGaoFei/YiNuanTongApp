//
//  AddressViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/26.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressCell.h"
#import "YNTUITools.h"
#import "AddAddressViewController.h"
#import "MineAddressModel.h"
#import "YNTNetworkManager.h"
#import <MJRefresh/MJRefresh.h>
#import "AddressEditViewController.h"
#import "UIScrollView+EmptyDataSet.h"
#import "OrderConfirmViewController.h"
#import "OrderShipModel.h"
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**地址数组*/
@property (nonatomic,strong) NSMutableArray  * addressModelArr;
/**选中的行数*/
@property (nonatomic,strong) NSIndexPath  * lastIndexPath;
/**地址模型*/
@property (nonatomic,strong) OrderShipModel  * addressModel;
/**新增按钮*/
@property (nonatomic,strong) UIButton  * addBtn;
@end
static NSString *addressCell = @"addressCell";

@implementation AddressViewController
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
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    self.view.backgroundColor = [UIColor whiteColor];
        [self loadData];
    //    // 获取通知中心对象
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        // 添加当前类对象为一个观察者,name 和obeject设置为nil,表示接收一切消息
        [center addObserver:self selector:@selector(receiveNotificiation:) name:@"addDressSuccess" object:nil];
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
            NSLog(@"%@  %@",model.consignee ,model.isdefault);
        }
        
               if (self.tableView) {
            [self.tableView reloadData];
            
        }else{
               [self setUpChildrenViews];
        }
     
        if (self.addressModelArr.count > 0) {
            // 如果不为空就显示新增
            [self setUpFootViews];
            
        }else{
            [self.addBtn removeFromSuperview];
        }

     
    } enError:^(NSError *error) {
        NSLog(@"请求失败%@",error);
         }];
    
}
/**
 *创建表尾视图
 */
- (void)setUpFootViews
{
    self.addBtn = [YNTUITools createButton:CGRectMake(0,kScreenH - 40, KScreenW, 40) bgColor:CGRBlue title:@"新增地址"  titleColor:[UIColor whiteColor] action:@selector(addBtnAction:) vc:self];
 
    [self.view addSubview:_addBtn];

  
}
- (void)addBtnAction:(UIButton *)sender
{
    NSLog(@"我是新增地址");
    AddAddressViewController *addAddVC  = [[AddAddressViewController alloc]init];
    addAddVC.addSuccess =  ^(){
        self.tableView.frame = CGRectMake(0, 0, KScreenW, kScreenH -64);
       
    };
    [self.navigationController pushViewController:addAddVC animated:YES];
}
- (void)setUpChildrenViews
{
    //创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, kScreenH -64-40) style:UITableViewStylePlain];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
       // 表尾视图
    //UIView *footView = [self setUpFootViews];
    //self.tableView.tableFooterView = footView;
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
        UIImage *selectedImage = [UIImage imageNamed:@"order_checked"];
        selectedImage  = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [cell.defaultBtn setImage:selectedImage forState:UIControlStateNormal];
    }else{
        UIImage *selectedImage = [UIImage imageNamed:@"未勾选状态"];
        selectedImage  = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [cell.defaultBtn setImage:selectedImage forState:UIControlStateNormal];
    }
    
    //__weak typeof(cell) weakSelf = cell;
    UserInfo *userInfo = [UserInfo currentAccount];
    // 设置默认
    cell.buttonClicked = ^(NSInteger index){
        if (index == 1930) {
         
            NSString *url = [NSString stringWithFormat:@"%@api/addressclass.php",baseUrl];
            NSDictionary *param = @{@"user_id":userInfo.user_id,@"act":@"default",@"address_id":model.address_id};
            [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
           
                [self.addressModelArr removeAllObjects];
                [self loadData];
                
                if (self.confirmBlockShipiing_id) {
                    OrderShipModel *model1 = [[OrderShipModel alloc]init];
                    model1.consignee =model.consignee;
                    model1.userid = model.userid;
                    model1.address_id=model.address_id;
                    model1.province = model.province;
                    model1.city = model.city;
                    model1.area = model.area;
                    model1.address = model.address;
                    model1.mobile = model.mobile;
                    model1.isdefault = model.isdefault;

                    self.confirmBlockShipiing_id(model1);
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } enError:^(NSError *error) {
                NSLog(@"设置默认数据失败%@",error);
               
            }];

            
    }
        
        if (index == 1931) {
            // 删除编辑地址接口
            NSLog(@"我是编辑的回调");
            AddressEditViewController *addressEditVC = [[AddressEditViewController alloc]init];
            addressEditVC.addSuccess = ^(){
                   self.tableView.frame = CGRectMake(0, 0, KScreenW, kScreenH -64);
                [self loadData];
            };
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
    cell.addressLab.text = [NSString stringWithFormat:@"%@%@%@%@",model.province,model.city,model.area,model.address];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MineAddressModel *model = self.addressModelArr[indexPath.row];
    OrderShipModel *model1 = [[OrderShipModel alloc]init];
    model1.consignee =model.consignee;
    model1.userid = model.userid;
    model1.address_id=model.address_id;
    model1.province = model.province;
    model1.city = model.city;
    model1.area = model.area;
    model1.address = model.address;
    model1.mobile = model.mobile;
    model1.isdefault = model.isdefault;

    if (self.confirmBlockShipiing_id) {
        
          self.confirmBlockShipiing_id(model1);
           [self.navigationController popViewControllerAnimated:YES];
    }
 
    }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    return 120;

}


#pragma mark - 数据为空时处理
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    //[self.addBtn removeFromSuperview];
    return [UIImage imageNamed:@"address_-empty"];
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"address_-empty_to_add"];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    NSLog(@"你要想添加吗");
    AddAddressViewController *addAddressVC = [[AddAddressViewController alloc]init];


    [self.navigationController pushViewController:addAddressVC animated:YES];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"您还没有任何地址,赶快添加吧!";
    
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
#pragma mark - 接收通知
- (void)receiveNotificiation:(NSNotification*)info
{
     // 用通知
       [self loadData];
       self.tableView.frame = CGRectMake(0, 0, KScreenW, kScreenH -64);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
