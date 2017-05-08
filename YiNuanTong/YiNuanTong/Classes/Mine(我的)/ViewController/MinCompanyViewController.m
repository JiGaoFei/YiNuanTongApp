//
//  MinCompanyViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/2/22.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "MinCompanyViewController.h"
#import "YNTUITools.h"
#import "CompanyCell.h"
#import "DQAreasView.h"
#import "DQAreasModel.h"
#import <AVFoundation/AVFoundation.h>
#import "YNTNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+WebCache.h"
#import "UserInfo.h"
#import "MineCompanyModel.h"
                                                                                                                                                                      
@interface MinCompanyViewController ()<UITableViewDelegate,UITableViewDataSource,DQAreasViewDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>


@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UIImageView *oneImgView;
@property (nonatomic,strong) UIImageView *twoImgView;
@property (nonatomic,strong) UIImageView *threeImgView;
@property (nonatomic,strong) UIImageView *fourImgView;
@property (nonatomic,strong) UIImageView *fiveImgView;
/**tableView*/
@property (nonatomic,strong) UITableView  * tableView;
/**占位数组*/
@property (nonatomic,strong) NSMutableArray  * placeHoldTitle;
/**所在地*/
@property (nonatomic, strong) DQAreasView *areasView;
/**城市addressCell*/
@property (nonatomic,strong) UITableViewCell  * addressCell;
// 反馈信息文字框
@property (nonatomic,strong) UITextView *tellMeTextView;
/**存放选择的地址*/
@property (nonatomic,strong) NSString  * selectAddress;

// 占位lab
@property (nonatomic,strong)   UILabel *placeHolderLab;

/**公司名称*/
@property (nonatomic,strong) NSString  * commpanyName;
/**地址*/
@property (nonatomic,strong) NSString  * address;
/**详细地址*/
@property (nonatomic,strong) NSString  * detailAddress;
/**固定电话*/
@property (nonatomic,strong) NSString  * phoneNum;
/**邮编*/
@property (nonatomic,strong) NSString  * zipCode;
/**传真*/
@property (nonatomic,strong) NSString  * fax;
/**图片标记*/
@property (nonatomic,strong) NSString  * picTag;
/**数据模型*/
@property (nonatomic,strong)  MineCompanyModel *model;



@end
static NSString *companyCell = @"companyCell";
static NSString *cellling =@"cell";

@implementation MinCompanyViewController
/**
 *懒加载
 */
- (NSMutableArray *)placeHoldTitle
{
    if (!_placeHoldTitle) {
        self.placeHoldTitle = [[NSMutableArray alloc]init];
        
    }
    return _placeHoldTitle;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(249, 249, 249, 1);
    self.commpanyName = @"";
    self.address= @"";
    self.detailAddress= @"";
    self.phoneNum= @"";
    self.zipCode= @"";
    self. fax= @"";
    self.selectAddress = @"";
    self.title = @"公司基本信息";
    [self loadData];
    

}
/**
 *加载数据
 */
- (void)loadData
{
    UserInfo *userInfo = [UserInfo currentAccount];
    NSString *url = [NSString stringWithFormat:@"%@/api/app.php",baseUrl];
    NSDictionary *params = @{@"uid":userInfo.user_id,@"act":@"userinfo"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        NSLog(@"请求数据成功%@",responseObject);
        self.model = [[MineCompanyModel alloc]init];
        [_model setValuesForKeysWithDictionary:responseObject[@"info"]];
        
        NSString *str = [NSString stringWithFormat:@"%@%@%@",_model.province,_model.city,_model.area];
        self.placeHoldTitle = @[self.model.realname,
                               str,
                               self.model.address,
                               self.model.phone,
                            
                              ].mutableCopy;
        if (self.tableView) {
            [self.tableView reloadData];
        }else{
            [self setUpChildrenViwes];
        }
        
    } enError:^(NSError *error) {
        
    }];


}

/**
 *创建子视图
 */
- (void)setUpChildrenViwes
{
    // 创建导航栏
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 64)];
    navView.backgroundColor = RGBA(18, 122, 203, 1);
    
    [self.view addSubview:navView];
    
    
    // 创建返回btn
    UIButton *backBtn = [YNTUITools createButton:CGRectMake(21.5, 20, 25, 32) bgColor: nil title:nil titleColor:nil action:@selector(backBtnAction:) vc:self];
    UIImage *backImg = [UIImage imageNamed:@"返回箭头"];
    backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    
    [self.view addSubview:backBtn];
    
    // 创建审核进度lab
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(KScreenW /2 -70, 20, 140, 40) text:@"完善公司基本信息" textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:17];
    [self.view addSubview:titleLab];
    
    // 创建城市选择器
    self.areasView = [DQAreasView new];
    self.areasView.delegate = self;
    
    
    // 创建tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, kScreenH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    // 取消cell的滚动状态
    self.tableView.scrollEnabled = NO;
    // 注册cell
    [self.tableView registerClass:[CompanyCell class] forCellReuseIdentifier:companyCell];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellling];
    self.tableView.tableFooterView = [self setUpTalbeFooterViews];
    [self.view addSubview:self.tableView];
    
    
    
}
- (void)backBtnAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 创建表尾视图
- (UIView *)setUpTalbeFooterViews
{
    UserInfo *userInfo = [UserInfo currentAccount];
    if (!userInfo) {
        return 0;
    }

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 450*kHeightScale)];
    
    view.backgroundColor = RGBA(249, 249, 249, 1);
    //  view.backgroundColor = [UIColor redColor];
    
    
    // *********************** 创建文字输入框 ***************************
    // 创建上传营业执照
    UIImageView *oneImgView = [YNTUITools createImageView:CGRectMake(20*kWidthScale, 10*kHeightScale, 100*kWidthScale, 100*kWidthScale) bgColor:nil imageName:@"图片框"];
   
    [oneImgView sd_setImageWithURL:[NSURL URLWithString:self.model.zhizhao]];
    self.oneImgView = oneImgView;
    oneImgView.userInteractionEnabled = YES;
    [view addSubview:oneImgView];
    
    
    UIImageView *oneTitleImgView = [YNTUITools createImageView:CGRectMake(20*kWidthScale, 110*kHeightScale, 100*kWidthScale, 22*kHeightScale) bgColor:nil imageName:@"营业执照"];
    
    [view addSubview:oneTitleImgView];
    
    // 创建上传店铺形象
    UIImageView *twoImgView = [YNTUITools createImageView:CGRectMake(140*kWidthScale, 10*kHeightScale, 100*kWidthScale, 100*kWidthScale) bgColor:nil imageName:@"图片框"];
    [twoImgView sd_setImageWithURL:[NSURL URLWithString:self.model.mendian1]];
    self.twoImgView = twoImgView;
    [view addSubview:twoImgView];
    twoImgView.userInteractionEnabled = YES;
   
    UIImageView *twoTitleImgView = [YNTUITools createImageView:CGRectMake(140*kWidthScale, 110*kHeightScale, 210*kWidthScale, 22*kHeightScale) bgColor:nil imageName:@"店铺形象"];
    [view addSubview:twoTitleImgView];
    
    
    
    UIImageView *threeImgView = [YNTUITools createImageView:CGRectMake(250*kWidthScale, 10*kHeightScale, 100*kWidthScale, 100*kWidthScale) bgColor:nil imageName:@"图片框"];
    
      [threeImgView sd_setImageWithURL:[NSURL URLWithString:self.model.mendian2]];
    self.threeImgView = threeImgView;
    threeImgView.userInteractionEnabled = YES;
    [view addSubview:threeImgView];
    
    // 上传身份证
   
    UIImageView *fourImgView = [YNTUITools createImageView:CGRectMake(20*kWidthScale, 150*kHeightScale, 100*kWidthScale, 100*kHeightScale) bgColor:nil imageName:@"图片框"];
      [fourImgView sd_setImageWithURL:[NSURL URLWithString:self.model.idcardfront]];
    self.fourImgView = fourImgView;
    fourImgView.userInteractionEnabled = YES;
    [view addSubview:fourImgView];
      UIImageView *fourTitleImgView = [YNTUITools createImageView:CGRectMake(20*kWidthScale, 250*kHeightScale, 220*kWidthScale, 22*kHeightScale) bgColor:nil imageName:@"身份证正反面"];
    [view addSubview:fourTitleImgView];
    
    UIImageView *fiveImgView = [YNTUITools createImageView:CGRectMake(140*kWidthScale, 150*kHeightScale, 100*kWidthScale, 100*kWidthScale) bgColor:nil imageName:@"图片框"];
      [fiveImgView sd_setImageWithURL:[NSURL URLWithString:self.model.idcardback]];
    self.fiveImgView  = fiveImgView;
    fiveImgView.userInteractionEnabled = YES;
    [view addSubview:fiveImgView];
    
    return view;
    
}
#pragma mark  - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row ==1) {
        self.addressCell = [tableView dequeueReusableCellWithIdentifier:cellling forIndexPath:indexPath];
        if (!_addressCell) {
            _addressCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellling];
            
        }
        self.addressCell.textLabel.text =  [NSString stringWithFormat:@"%@%@%@",_model.province,_model.city,_model.area];

        self.addressCell.textLabel.font = [UIFont systemFontOfSize:15];
        self.addressCell.textLabel.textColor = CGRGray;
        // 取消cell的选中样式
        _addressCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return _addressCell;
    }
    CompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:companyCell forIndexPath:indexPath];
    // 设置cell的代理
    
    if (!cell) {
        cell = [[CompanyCell alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 40*kHeightScale)];
    }
    cell.textFiled.text = self.placeHoldTitle[indexPath.row];
    cell.textFiled.textColor = CGRGray;
    // 禁止textFiled输入
    cell.textFiled.userInteractionEnabled = NO;
    // 取消cell的选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textFiled.font = [UIFont systemFontOfSize:15];
    cell.textFiled.tag = indexPath.row;
    [cell.textFiled addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
#pragma mark - 监听cell中textField的输入
- (void)textFieldWithText:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            self.commpanyName = textField.text;
            break;
        case 1:
            NSLog(@"这是选择地址");
            break;
        case 2:
            self.detailAddress = textField.text;
            break;
        case 3:
            self.phoneNum = textField.text;
            break;
        case 4:
            self.zipCode = textField.text;
            break;
        case 5:
            self.fax = textField.text;
            break;
            
            
        default:
            break;
    }
}

@end;
