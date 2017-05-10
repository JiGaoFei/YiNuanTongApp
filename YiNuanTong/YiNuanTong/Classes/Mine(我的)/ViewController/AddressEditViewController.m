//
//  AddressEditViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 17/2/16.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "AddressEditViewController.h"
#import "AddNewAddressCell.h"
#import "AddNewCountyCell.h"
#import "AddressSwitchCell.h"
#import "GFAddressPicker.h"
#import "SingLeton.h"
#import "YNTUITools.h"
#import "YNTNetworkManager.h"
#import "MineAddressModel.h"
@interface AddressEditViewController ()<UITableViewDelegate,UITableViewDataSource,GFAddressPickerDelegate>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**titleArray*/
@property (nonatomic,strong) NSMutableArray  * titleArr;
/**placeHolderArray*/
@property (nonatomic,strong) NSMutableArray  * placeHolderArr;
/**所在地*/
@property (nonatomic, strong) GFAddressPicker *areasView;
@property (nonatomic,strong) AddNewCountyCell *addressCell;
/**是否设置为默认*/
@property (nonatomic,strong) NSString  * isDefault;
/**客户名称*/
@property (nonatomic,strong) NSString  * custormerName;
/**联系人*/
@property (nonatomic,strong) NSString  * contactName;
/**联系方式*/
@property (nonatomic,strong) NSString  * mobile;
/**省市*/
@property (nonatomic,strong) NSString  * provinceAndCity;
/**详细地址*/
@property (nonatomic,strong) NSString  * detaiAdress;

@end
static NSString *addCell = @"addcell";
static NSString *addCountyCell = @"addCountyCell";
static NSString *addressSwitchCell = @"addressSwichCell";

@implementation AddressEditViewController


- (NSMutableArray *)titleArr
{
    if (!_titleArr) {
        self.titleArr = [[NSMutableArray alloc]init];
    }
    return _titleArr;
}
- (NSMutableArray *)placeHolderArr
{
    if (!_placeHolderArr) {
        self.placeHolderArr = [[NSMutableArray alloc]init];
    }
    return _placeHolderArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
 
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.addSuccess) {
         self.addSuccess ();
    }
   
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑地址";
    self.isDefault = @"0";
    self.provinceAndCity = @"0";
    self.view.backgroundColor = [UIColor whiteColor];
    // 加载数据
    [self loadData];
    // 加载子视图
    [self setUpChildrenViews];
    // 加载底部视图
    [self setUpBottomViews];
    
    // Do any additional setup after loading the view.
}
/**
 *加载数据
 */
- (void)loadData
{
    self.titleArr = @[@"联系人",@"联系方式"].mutableCopy;
    self.placeHolderArr = @[@"姓名",@"电话号码"].mutableCopy;
    
}
/**
 *创建加载子视图
 */
- (void)setUpChildrenViews
{
    // 创建tableview
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH-50) style:UITableViewStylePlain];
    // 取消tableView的滚动
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    // 注册cell
    [self.tableView registerClass:[AddNewAddressCell class] forCellReuseIdentifier:addCell];
    [self.tableView registerClass:[AddNewCountyCell class] forCellReuseIdentifier:addCountyCell];
    [self.tableView registerClass:[AddressSwitchCell class] forCellReuseIdentifier:addressSwitchCell];
    
    [self.view addSubview:self.tableView];
    
    
}

/**
 *创建底部视图
 */
- (void)setUpBottomViews
{
    NSLog(@"创建底部视图");
    UIButton *bottomBtn = [YNTUITools createButton:CGRectMake(0, kScreenH - 50, KScreenW, 50) bgColor:CGRBlue title:@"保存" titleColor:[UIColor whiteColor] action:@selector(saveBtnAction:) vc:self];
    [self.view addSubview:bottomBtn];
}
#pragma mark - 获取cell上的值
- (void)cellArr
{
    NSArray *cellArr =self.tableView.visibleCells;
    for (int i = 0; i<cellArr.count; i++) {
        switch (i ) {
            case 0:
            {
                AddNewAddressCell *cell = cellArr[i];
                self.contactName =cell.textField.text;
            }
                break;
            case 1:
            {
               
                AddNewAddressCell *cell = cellArr[i];
                self.mobile = cell.textField.text;
            }
                break;
                
            case 2:
            {
                
                
            }
                break;
                
            case 3:
            {
                AddNewAddressCell *cell = cellArr[i];
                self.detaiAdress = cell.textField.text;
            }
                break;
                
            case 4:
            {
             
            }
                break;
            case 5:
            {
                
            }
                break;
                
                
                
            default:
                break;
        }
    }
}
#pragma mark - 保存按钮的点击事件
- (void)saveBtnAction:(UIButton *)sender
{
    // 显示加载圏
    [GFProgressHUD showLoading:@"正在提交数据"];
        // 获取cell上的值
    [self cellArr];
    if ([self.provinceAndCity isEqualToString:@"0"]) {
        self.provinceAndCity = [NSString stringWithFormat:@"%@%@%@",self.model.province,self.model.city,self.model.area];
    }
   
    UserInfo *userInfo = [UserInfo currentAccount];
    NSLog(@"我是保存按钮的点击事件");
    NSString *url = [NSString stringWithFormat:@"%@api/addressclass.php",baseUrl];
    NSDictionary *param = @{@"user_id":userInfo.user_id,@"act":@"edit",@"consignee":self.contactName,@"shengshixian":self.provinceAndCity,@"address":self.detaiAdress,@"isdefault":self.isDefault,@"mobile":self.mobile,@"address_id":self.model.address_id};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        
        NSLog(@"编辑地址请求数据成功%@",responseObject);
        NSString *msg = responseObject[@"msg"];
        if ([msg isEqualToString:@"success"]) {
            
            
            [GFProgressHUD showSuccess:responseObject[@"info"]];
            
        }else{
            [GFProgressHUD showFailure:responseObject[@"info"]];
        }
    
        
        
    } enError:^(NSError *error) {
        NSLog(@"编辑地址请求数据失败%@",error);
        [GFProgressHUD showFailure:@"修改地址失败"];
    }];
    
    
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nameArray = @[@"联系人",@"联系方式"];
    NSArray *textNameArray = @[self.model.consignee,self.model.mobile];
    if (indexPath.row >=0 && indexPath.row <2) {
        AddNewAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addCell forIndexPath:indexPath];
        cell.nameLab.text = nameArray [indexPath.row];
        cell.textField.text =textNameArray[indexPath.row];
        cell.textField.placeholder = self.placeHolderArr[indexPath.row];
        //取消cell的选中颜色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    if (indexPath.row ==2) {
        AddNewCountyCell *cell = [tableView dequeueReusableCellWithIdentifier:addCountyCell forIndexPath:indexPath];
        cell.nameLab.text = @"省/市/县";
        cell.detailNameLab.text = self.model.province;
        cell.detailNameLab.textColor = [UIColor grayColor];
        self.addressCell = cell;
        
        //取消cell的选中颜色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    if (indexPath.row==3) {
        AddNewAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:addCell forIndexPath:indexPath];
        cell.nameLab.text = @"详细地址";
        cell.textField.placeholder = @"请输入详细地址";
        cell.textField.text = self.model.address;
        //取消cell的选中颜色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    if (indexPath.row==4) {
        AddressSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:addressSwitchCell forIndexPath:indexPath];
        cell.nameLab.text = @"设为默认地址";
        cell.swichBtnClick = ^(NSInteger index){
            switch (index) {
                case 1940:
                {
                    // NSLog(@"关着的");
                    
                    self.isDefault = @"0";
                    NSLog(@"取消默认%@",self.isDefault);
                }
                    break;
                case 1941:
                {
                    // NSLog(@"开着的");
                    self.isDefault = @"1";
                    NSLog(@"设置默认%@",self.isDefault);
                }
                    break;
                    
                    
                default:
                    break;
            }
        };
        //取消cell的选中颜色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
    
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==2) {
        NSLog(@"点击的是省市区县");
        [self.view endEditing:YES];
        // 创建城市选择器
        [self.areasView removeFromSuperview];
        self.areasView = [GFAddressPicker new];
        self.areasView  = [[GFAddressPicker alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [self.areasView  updateAddressAtProvince:@"河南省" city:@"郑州市" town:@"金水区"];
        self.areasView .delegate = self;
        self.areasView.font = [UIFont boldSystemFontOfSize:14];
        [self.view addSubview:self.areasView];
    }
    
}
#pragma mark -城市选择器的代理方法
- (void)GFAddressPickerWithProvince:(NSString *)province city:(NSString *)city town:(NSString *)area
{
    self.addressCell.detailNameLab.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    self.provinceAndCity =[NSString stringWithFormat:@"%@ %@ %@",province,city,area];
    [self.areasView removeFromSuperview];
}
- (void)GFAddressPickerCancleAction
{
    [self.areasView removeFromSuperview];
}




@end
