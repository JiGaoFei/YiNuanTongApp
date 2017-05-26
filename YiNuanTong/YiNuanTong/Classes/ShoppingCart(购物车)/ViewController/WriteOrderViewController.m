//
//  WriteOrderViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "WriteOrderViewController.h"
#import "WriteOrderRecevieCell.h"
#import "YNTUITools.h"
#import "WriteOrderLabCell.h"
#import "WriteOrderTextfileldCell.h"
#import "WritePaymentAccountCell.h"
#import "SingLeton.h"
#import "SubmitOrderViewController.h"
#import "BirthdayDatePickView.h"
#import "YNTNetworkManager.h"
#import "WriteModel.h"
#import "AddressSelectViewController.h"
#import "MineAddressModel.h"
@interface WriteOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**全局cell日期*/
@property (nonatomic,strong)  WriteOrderLabCell *cell;
/**发货日期*/
@property (nonatomic,strong) NSString  * shiping_time;
/**地址cell*/
@property (nonatomic,strong) WriteOrderRecevieCell *addressCell ;
/*备注消息*/
@property (nonatomic,strong) NSString  * note;
@end
static NSString *writeReceiveCell = @"writeReceiveCell";
static NSString *writeLabCell = @"writeLabCell";
static NSString *writeTextFieldCell = @"writeTextFieldCell";
static NSString *writePaymentCell = @"writePaymentCell";
@implementation WriteOrderViewController

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
    self.title = @"填写订单";
    self.view.backgroundColor =  RGBA(249, 249, 249, 1);
    self.shiping_time = @"";
    self.note = @"";
    // 加载子视图
    [self setUpChildrenViews];
    [self setUpFooterViews];
  
}
/**
 *加载子视图
 */
- (void)setUpChildrenViews
{
    // 创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH -220) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;

    // 注册cell
    [self.tableView registerClass:[WriteOrderRecevieCell class] forCellReuseIdentifier:writeReceiveCell];
    [self.tableView registerClass:[WriteOrderLabCell class] forCellReuseIdentifier:writeLabCell];
    [self.tableView registerClass:[WriteOrderTextfileldCell class] forCellReuseIdentifier:writeTextFieldCell];
    [self.tableView registerClass:[WritePaymentAccountCell class] forCellReuseIdentifier:writePaymentCell];
    
    [self.view addSubview:self.tableView];
    
    
    }
/**
 *加载表尾视图
 */
- (void)setUpFooterViews
{
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH-175*kHeightScale, KScreenW, 220*kHeightScale)];
    [self.view addSubview:bigView];
    bigView.backgroundColor = RGBA(249, 249, 249, 1);
    
    UILabel *countLab = [YNTUITools createLabel:CGRectMake(165 *kWidthScale, 85*kHeightScale, 105*kWidthScale, 13 *kHeightScale ) text:[NSString stringWithFormat:@"共%@件商品",self.goodsnum] textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:13];
    [bigView addSubview:countLab];
    UILabel *allCountLab = [YNTUITools createLabel:CGRectMake(250 *kWidthScale, 83*kHeightScale, 60*kWidthScale, 15*kHeightScale) text:@"小计:" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    [bigView addSubview:allCountLab];
    
    UILabel *moneyLab = [YNTUITools createLabel:CGRectMake(290*kWidthScale, 83*kHeightScale, 100*kWidthScale, 18*kHeightScale) text:self.totalMoney textAlignment:NSTextAlignmentLeft textColor:[UIColor redColor] bgColor:nil font:18];
    [bigView addSubview:moneyLab];
    UIView *linView = [[UIView alloc]initWithFrame:CGRectMake(160 *kWidthScale, 103 *kHeightScale, 185*kWidthScale, 1)];
    linView.backgroundColor = CGRGray;
    [bigView addSubview:linView];

    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 120 *kHeightScale, KScreenW - 115*kWidthScale, 55*kHeightScale)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bigView addSubview:bottomView];
    
    
    UILabel *bottomLab = [YNTUITools createLabel:CGRectMake(44  *kPlus *kWidthScale, 140*kHeightScale, 42*kWidthScale, 14*kHeightScale) text:@"金额:" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:[UIColor whiteColor] font:14];
    [bigView addSubview:bottomLab];

    
    UILabel *bottomMoneyLab = [YNTUITools createLabel:CGRectMake(75*kWidthScale, 138*kHeightScale, 180*kWidthScale, 19*kHeightScale) text:self.totalMoney textAlignment:NSTextAlignmentLeft textColor:[UIColor redColor] bgColor:[UIColor whiteColor]  font:19];
    [bigView addSubview:bottomMoneyLab];
    
    UIButton *submitBtn = [YNTUITools createButton:CGRectMake(KScreenW - 115*kWidthScale , 120*kHeightScale, 115*kWidthScale, 55*kHeightScale) bgColor:RGBA(18, 122, 201, 1) title:@"提交订单" titleColor:[UIColor whiteColor] action:@selector(submitBtnAction:) vc:self];

    [bigView addSubview:submitBtn];
    }
#pragma mark -点击提交订单按钮
- (void)submitBtnAction:(UIButton *)sender
{
    NSLog(@"我是提交订单");
    // 获取备注消息
    [self cellArr];
    UserInfo *userInfo = [UserInfo currentAccount];
        //  请求提交订单数据
    NSString *url = [NSString stringWithFormat:@"%@api/orderclass.php",baseUrl];
 
    
     NSDictionary *param = @{@"user_id":userInfo.user_id,@"order_id":self.order_id,@"act":@"dosubmitinfo",@"address_id":self.model.address_id,@"shipping_time":self.shiping_time   ,@"note":self.note};
    
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"请求提交订单数据%@",responseObject);
        NSString *msg = responseObject[@"msg"];
        if ([msg isEqualToString:@"success"]) {
            
            SubmitOrderViewController *submitVC = [[SubmitOrderViewController alloc]init];
            submitVC.order_id = responseObject[@"order_id"];
            submitVC.order_sn = responseObject[@"order_sn"];
            submitVC.order_amount= responseObject[@"order_amount"];
            [self.navigationController pushViewController:submitVC animated:YES];

        }else{
            [GFProgressHUD showFailure:responseObject[@"info"]];
        }
        
    } enError:^(NSError *error) {
        NSLog(@"请求提交订单数据失败%@",error);
    }];
    
    }

#pragma mark- tableView的代理方法
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
    if (indexPath.row == 0) {
        self.addressCell = [tableView dequeueReusableCellWithIdentifier:writeReceiveCell forIndexPath:indexPath];
          self.addressCell.titleLab.text = @"收货信息";
          self.addressCell.nameLab.text =self.model.consignee;
          self.addressCell.phoneLab.text  =self.model.mobile;
        self.addressCell.addressLab.text =[NSString stringWithFormat:@"%@%@",self.model.shengshi,self.model.address];
             self.addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _addressCell;
    }
    if (indexPath.row == 1) {
        WriteOrderLabCell *cell = [tableView dequeueReusableCellWithIdentifier:writeLabCell forIndexPath:indexPath];
      
        cell.nameLab.text = @"发货日期";
        cell.detailNameLab.text = @"请选择";
        self.cell = cell;
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 2) {
        WriteOrderTextfileldCell *cell = [tableView dequeueReusableCellWithIdentifier:writeTextFieldCell forIndexPath:indexPath];
        
        cell.nameLab.text = @"备注信息";
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
        return cell;
    }
    
    if (indexPath.row == 3) {
        WriteOrderLabCell *cell = [tableView dequeueReusableCellWithIdentifier:writeLabCell forIndexPath:indexPath];
        
        cell.nameLab.text = @"配送方式";
        cell.detailNameLab.text = self.arrwuliuDic[@"name"];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }

    if (indexPath.row == 4) {
        WritePaymentAccountCell*cell = [tableView dequeueReusableCellWithIdentifier:writePaymentCell forIndexPath:indexPath];
        
        cell.titleLab.text = @"收款账号";
        cell.bankNameLab.text= @"开户银行:农业银行";
        cell.accountLab.text = @"账户名称:北京明天凯萨 电子商务有限公司";
        cell.accountNumLab.text = @"开户账号:6335 7712  8813 991";
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }


        return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 120;
    }
    if (indexPath.row > 0 && indexPath.row<4) {
        return 50;
    }
    if (indexPath.row == 4) {
        return 110;
    }
    
    return 20;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        AddressSelectViewController *addressSelectVC = [[AddressSelectViewController alloc]init];
        addressSelectVC.settingAdress = ^(MineAddressModel *model){
            self.model.consignee=model.consignee;
            self.model.mobile =model.tel;
            self.model.address = model.address;
            [self.tableView reloadData];
            NSLog(@"地址进行了回调");
        };
        [self.navigationController pushViewController:addressSelectVC animated:YES];
    }
    
    if (indexPath.row == 1) {
    BirthdayDatePickView *datePickVC = [[BirthdayDatePickView alloc] initWithFrame:self.view.bounds];
 
       ;

    // datePickVC.date = [NSDate date];
        datePickVC.date =  [[NSDate alloc]initWithTimeIntervalSinceNow:9*60*60];

    //设置字体颜色
    datePickVC.fontColor = [UIColor redColor];
    //日期回调
    datePickVC.completeBlock = ^(NSString *selectDate) {
       self.cell.detailNameLab.text = selectDate;
        self.shiping_time = selectDate;
    };
    //配置属性
    [datePickVC configuration];
   
    [self.view addSubview:datePickVC];
}
}
#pragma makr - 备注消息
- (void)cellArr
{
    NSArray *cellArr = self.tableView.visibleCells;
    WriteOrderTextfileldCell *cell = cellArr[2];
    self.note = cell.textField.text;
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
