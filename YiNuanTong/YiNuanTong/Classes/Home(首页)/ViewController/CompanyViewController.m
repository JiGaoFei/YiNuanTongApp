//
//  CompanyViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/13.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "CompanyViewController.h"
#import "YNTUITools.h"
#import "CompanyCell.h"
#import "DQAreasView.h"
#import "DQAreasModel.h"
#import <AVFoundation/AVFoundation.h>
#import "YNTNetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "LoginViewController.h"
#import "Examine.h"
@interface CompanyViewController ()<UITableViewDelegate,UITableViewDataSource,DQAreasViewDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UIImageView *oneImgView;
@property (nonatomic,strong) UIImageView *twoImgView;
@property (nonatomic,strong) UIImageView *threeImgView;
@property (nonatomic,strong) UIImageView *fourImgView;
@property (nonatomic,strong) UIImageView *fiveImgView;
@property (nonatomic,strong) UIImage *allImage;
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
/**图片1*/
@property (nonatomic,assign) BOOL  isOne;
/**图片2*/
@property (nonatomic,assign) BOOL  isTwo;

/**图片3*/
@property (nonatomic,assign) BOOL  isThree;

/**图片4*/
@property (nonatomic,assign) BOOL  isFour;

/**图片5*/
@property (nonatomic,assign) BOOL  isFive;

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
/**省*/
@property (nonatomic,strong) NSString  * province;
/**市*/
@property (nonatomic,strong) NSString  * city;
/**区*/
@property (nonatomic,strong) NSString  * area;
/**图片标记*/
@property (nonatomic,strong) NSString  * picTag;
/**全局url*/
@property (nonatomic,copy) NSString *url;
/**存放时间和照片act键值对*/
@property (nonatomic,strong) NSMutableDictionary *timeAndPictureDics;

@end
static NSString *companyCell = @"companyCell";
static NSString *cellling =@"cell";

@implementation CompanyViewController
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

// 时间和照片键值对
- (NSMutableDictionary *)timeAndPictureDics
{
    if (!_timeAndPictureDics) {
        self.timeAndPictureDics = [[NSMutableDictionary alloc]init];
    }
    return _timeAndPictureDics;
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
    self.selectAddress = @"请选择省市区";
    self.url = @"";
    

    
    [self loadData];
    [self setUpChildrenViwes];
   }
/**
 *加载数据
 */
- (void)loadData
{
    self.placeHoldTitle = @[@"公司名称或姓名",
                                            @"请选择地址",
                                            @"详细地址(街道,门牌号)",
                                            @"固定电话",
                                            ].mutableCopy;
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
    // 注册cell
    [self.tableView registerClass:[CompanyCell class] forCellReuseIdentifier:companyCell];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellling];
    self.tableView.tableFooterView = [self setUpTalbeFooterViews];
    [self.view addSubview:self.tableView];
    
    
    
}
#pragma mark - 创建表尾视图
- (UIView *)setUpTalbeFooterViews
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 500*kHeightScale)];
    
    view.backgroundColor = RGBA(249, 249, 249, 1);
    
    // *********************** 创建文字输入框 ***************************
    // 创建上传营业执照
    UIImageView *oneImgView = [YNTUITools createImageView:CGRectMake(20*kWidthScale, 10*kHeightScale, 100*kWidthScale, 100*kWidthScale) bgColor:nil imageName:@"图片框"];
    self.oneImgView = oneImgView;
    oneImgView.userInteractionEnabled = YES;
    [view addSubview:oneImgView];
    
    // 添加手势
    UITapGestureRecognizer *tapOneGestrure = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOneGestrureAction:)];
    [oneImgView addGestureRecognizer:tapOneGestrure];
    
    UIImageView *oneTitleImgView = [YNTUITools createImageView:CGRectMake(20*kWidthScale, 110*kHeightScale, 100*kWidthScale, 22*kHeightScale) bgColor:nil imageName:@"上传营业执照"];
    [view addSubview:oneTitleImgView];
    
    // 创建上传店铺形象
    UIImageView *twoImgView = [YNTUITools createImageView:CGRectMake(140*kWidthScale, 10*kHeightScale, 100*kWidthScale, 100*kWidthScale) bgColor:nil imageName:@"图片框"];
    self.twoImgView = twoImgView;
    [view addSubview:twoImgView];
    twoImgView.userInteractionEnabled = YES;
    // 添加手势
    UITapGestureRecognizer *tapTwoGestrure = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTwoGestrureAction:)];
    [twoImgView addGestureRecognizer:tapTwoGestrure];
    UIImageView *twoTitleImgView = [YNTUITools createImageView:CGRectMake(140*kWidthScale, 110*kHeightScale, 210*kWidthScale, 22*kHeightScale) bgColor:nil imageName:@"上传店铺形象"];
    [view addSubview:twoTitleImgView];
    
    
    
    UIImageView *threeImgView = [YNTUITools createImageView:CGRectMake(250*kWidthScale, 10*kHeightScale, 100*kWidthScale, 100*kWidthScale) bgColor:nil imageName:@"图片框"];
    self.threeImgView = threeImgView;
    threeImgView.userInteractionEnabled = YES;
    [view addSubview:threeImgView];
    // 添加手势
    UITapGestureRecognizer *tapThreeGestrure = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapThreeGestrureAction:)];
    [threeImgView addGestureRecognizer:tapThreeGestrure];
    
    // 上传身份证
    // 创建上传营业执照
    UIImageView *fourImgView = [YNTUITools createImageView:CGRectMake(20*kWidthScale, 150*kHeightScale, 100*kWidthScale, 100*kHeightScale) bgColor:nil imageName:@"图片框"];
    self.fourImgView = fourImgView;
    fourImgView.userInteractionEnabled = YES;
    [view addSubview:fourImgView];
    // 添加手势
    UITapGestureRecognizer *tapFourGestrure = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFourGestrureAction:)];
    [fourImgView addGestureRecognizer:tapFourGestrure];
    UIImageView *fourTitleImgView = [YNTUITools createImageView:CGRectMake(20*kWidthScale, 250*kHeightScale, 220*kWidthScale, 22*kHeightScale) bgColor:nil imageName:@"上传身份证正反面"];
    [view addSubview:fourTitleImgView];
    
    UIImageView *fiveImgView = [YNTUITools createImageView:CGRectMake(140*kWidthScale, 150*kHeightScale, 100*kWidthScale, 100*kWidthScale) bgColor:nil imageName:@"图片框"];
    self.fiveImgView  = fiveImgView;
    fiveImgView.userInteractionEnabled = YES;
    [view addSubview:fiveImgView];
    
    // 添加手势
    UITapGestureRecognizer *tapFiveGestrure = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapFiveGestrureAction:)];
    [fiveImgView addGestureRecognizer:tapFiveGestrure];
    
    
    
    self.placeHolderLab= [[UILabel alloc]initWithFrame:CGRectMake(5*kWidthScale, 7*kHeightScale, KScreenW, 20 * kHeightScale)];
    self.placeHolderLab.enabled = NO;
    self.placeHolderLab.text = @"备注信息";
    
    if (KScreenW == 320) {
         self.placeHolderLab.font =[UIFont systemFontOfSize:15];
    }else{
         self.placeHolderLab.font =[UIFont systemFontOfSize:17];
    }
   
    
    
    self.tellMeTextView = [[UITextView alloc]initWithFrame:CGRectMake(20*kWidthScale , 280*kHeightScale , KScreenW - 2 * 20*kWidthScale , 65*kHeightScale )];
 
    self.tellMeTextView.delegate = self;
    self.tellMeTextView.backgroundColor = [UIColor whiteColor];
    
    //监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextViewTextDidChangeNotification object:self.tellMeTextView];
    
    [self.tellMeTextView addSubview:self.placeHolderLab];
    [view addSubview:self.tellMeTextView];
    
    UIButton *submitCheckBtn = [YNTUITools createButton:CGRectMake(40*kWidthScale, 360*kHeightScale, KScreenW-80*kWidthScale, 50*kHeightScale) bgColor:RGBA(18, 122, 203, 1) title:@"提交审核" titleColor:[UIColor whiteColor]  action:@selector(submitCheckBtnAction:) vc:self];
    [view addSubview:submitCheckBtn];
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
        if (KScreenW == 320) {
            self.addressCell.textLabel.font = [UIFont systemFontOfSize:15];
        }
        if (self.selectAddress) {
            self.addressCell.textLabel.text  = self.selectAddress;
        }else{
               self.addressCell.textLabel.text = @"请选择地址";
        }
     
        return _addressCell;
    }
    CompanyCell *cell = [tableView dequeueReusableCellWithIdentifier:companyCell forIndexPath:indexPath];
    // 设置cell的代理
    
    if (!cell) {
        cell = [[CompanyCell alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 40*kHeightScale)];
    }
cell.textFiled.placeholder = self.placeHoldTitle[indexPath.row];
    
      
    cell.textFiled.font = [UIFont systemFontOfSize:15];
    cell.textFiled.tag = indexPath.row;
    [cell.textFiled addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1) {
        NSLog(@"我是下拉选择");
        [self.view endEditing:YES];
        [self.areasView startAnimationFunction];
    }
    
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

#pragma mark -城市选择器的代理方法

- (void)clickAreasViewEnsureBtnActionAreasDate:(DQAreasModel *)model{
    
  self.addressCell.textLabel.text = [NSString stringWithFormat:@"%@ %@ %@",model.Province,model.city,model.county];
    
    self.selectAddress =  [NSString stringWithFormat:@"%@ %@ %@",model.Province,model.city,model.county];
    // 赋值
    self.province = model.Province;
    self.city = model.city;
    self.area = model.county;
}
#pragma mark - 监听输入框的改变
- (void)textFieldChanged:(NSNotification *)info {
    

    NSLog(@"%@",self.tellMeTextView.text);
    
    
}
#pragma mark tellMeTextView的代理方法
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.tableView.contentOffset = CGPointMake(0, 352);
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (self.tellMeTextView.text.length == 0) {
        [self.tellMeTextView addSubview:self.placeHolderLab];
        
    }else{
        [self.placeHolderLab removeFromSuperview];
    }
}

// 点击return回收键盘

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
   
    if([text isEqualToString:@"\n"]) {
         self.tableView.contentOffset = CGPointMake(0, 0 );
        
        [textView resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
    
}
//点击屏幕隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
      self.tableView.contentOffset = CGPointMake(0, 0);
}

#pragma mark  - 点击手势上传图片
- (void)tapOneGestrureAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"我是图片1");
    self.isOne = YES;
    self.isTwo = NO;
    self.isThree = NO;
    self.isFour = NO;
    self.isFive = NO;
    self.url = @"http://shang.fiqie.com/api/appzhizhao.php";
    [self loadAlum];

}
- (void)tapTwoGestrureAction:(UITapGestureRecognizer *)sender
{   self.isOne =NO;
    self.isTwo = YES;
    self.isThree = NO;
    self.isFour = NO;
    self.isFive = NO;
   self.url = @"http://shang.fiqie.com/api/appmendian1.php";
    [self loadAlum];
  
    NSLog(@"我是图片2");

}

- (void)tapThreeGestrureAction:(UITapGestureRecognizer *)sender
{
    self.isOne = NO;
    self.isTwo = NO;
    self.isThree = YES;
    self.isFour = NO;
    self.isFive = NO;
self.url = @"http://shang.fiqie.com/api/appmendian2.php";
    [self loadAlum];
    NSLog(@"我是图片3");
    
}

- (void)tapFourGestrureAction:(UITapGestureRecognizer *)sender
{
    self.isOne = NO;
    self.isTwo = NO;
    self.isThree = NO;
    self.isFour = YES;
    self.isFive = NO;
self.url = @"http://shang.fiqie.com/api/appidcardfront.php";
     [self loadAlum];
    NSLog(@"我是图片4");
    
}

- (void)tapFiveGestrureAction:(UITapGestureRecognizer *)sender
{
    self.isOne = NO;
    self.isTwo = NO;
    self.isThree = NO;
    self.isFour = NO;
    self.isFive = YES;
self.url = @"http://shang.fiqie.com/api/appidcardback.php";
     [self loadAlum];
    NSLog(@"我是图片5");

}

#pragma mark - 上传照片
#pragma mark - 返回按钮的点击方法
- (void)backBtnAction:(UIButton *)sender
{
    NSLog(@"我是返回按钮点击");
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 提交审核点击方法
- (void)submitCheckBtnAction:(UIButton *)sender
{
       [self.view endEditing:YES];
    // 点击提交的时候收起键盘
    self.tableView.contentOffset = CGPointMake(0, 0);
    
    if ((self.commpanyName.length == 0) ||(self.area.length == 0)||(self.city.length == 0)||(self.province.length == 0)||(self.phoneNum.length == 0)) {
        // 如果有一个为空
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"请填写相关信息!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }else{
        NSLog(@"点击审核提交方法");
        //手机号属性传值传过来
        NSString *url = [NSString stringWithFormat:@"%@api/app.php",baseUrl];
        // 这个里面不能有空值,
        NSDictionary *param = @{@"phone":self.iphone,@"password":self.password,@"realname":self.commpanyName,@"address":self.detailAddress,@"act":@"register",@"tel":self.phoneNum,@"remark":self.tellMeTextView.text,@"pid":self.invitationSn,@"province":self.province,@"city":self.city,@"area":self.area};
        
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
            NSLog(@"提交审核请求数据成功%@",responseObject);
            if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                [GFProgressHUD showSuccess:responseObject[@"info"]];
                UIViewController *vc =self.presentingViewController;
                
                //LoginViewController要跳转的界面
                Examine *userInfo = [Examine currentAccount];
                userInfo.phone = self.phoneNum;
                [userInfo saveLoginInfo:self.phoneNum];
                
                // 上传多图1
                [self upLoadMorePics:self.oneImgView andPicName:self.timeAndPictureDics[@"zhizhao"] andAct:@"zhizhao"];
                // 上传多图2
                [self upLoadMorePics:self.twoImgView andPicName:self.timeAndPictureDics[@"mendian1"] andAct:@"mendian1"];
                // 上传多图3
                [self upLoadMorePics:self.threeImgView andPicName:self.timeAndPictureDics[@"mendian2"] andAct:@"mendian2"];
                // 上传多图4
                [self upLoadMorePics:self.fourImgView andPicName:self.timeAndPictureDics[@"idcardfront"] andAct:@"idcardfront"];
                // 上传多图5
                [self upLoadMorePics:self.fiveImgView andPicName:self.timeAndPictureDics[@"idcardback"] andAct:@"idcardback"];
                
                
                while (![vc isKindOfClass:[LoginViewController class]]) {
                    vc = vc.presentingViewController;
                    
                }
                [vc dismissViewControllerAnimated:YES completion:nil];
                
            }else{
                [GFProgressHUD showFailure:responseObject[@"info"]];
            }
            
        } enError:^(NSError *error) {
            NSLog(@"提交审核提交数据失败%@",error);
            [GFProgressHUD showFailure:@"提交失败"];
        }];
  
    }

   }
#pragma mark - 调用相册
- (void)loadAlum
{
    __block typeof (self) weak_self = self;
    
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
    _picker.allowsEditing = YES;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择一张照片"
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {}];
    UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"从相册中选" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {
        weak_self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [weak_self presentViewController:weak_self.picker animated:YES completion:nil];
        NSLog(@"从相册选择");
    }];
    UIAlertAction* fromCameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault                                                             handler:^(UIAlertAction * action) {
        NSLog(@"相机");
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if(! [UIImagePickerController isSourceTypeAvailable:sourceType]){
            NSString *tips = @"相机不能用";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相机不可用" message:tips preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"取消");
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"确定");
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            return;
        }
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_picker animated:YES completion:nil];
        if (![self getCameraRecordPermisson]) {
            NSString *tips = @"请允许使用相机";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相机不可用" message:tips preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                NSLog(@"取消");
            }];
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"确定");
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:fromCameraAction];
    [alertController addAction:fromPhotoAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

#pragma mark UIImagePickerControllerDelegate
//选择图或者拍照后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *orignalImage = [info objectForKey:UIImagePickerControllerOriginalImage];//原图
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];//编辑后的图片
    
    self.allImage = editedImage;
    if (self.isOne) {
        
         self.oneImgView.image = editedImage;

    }
    if (self.isTwo) {
        self.twoImgView.image = editedImage;
        
    }

    if (self.isThree) {
     
        self.threeImgView.image = editedImage;
    }

    if (self.isFour) {
        self.fourImgView.image = editedImage;
        
    }
    if (self.isFive) {
        self.fiveImgView.image = editedImage;
        
    }

    
    // 拍照后保存原图片到相册中
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera && orignalImage) {
        UIImageWriteToSavedPhotosAlbum(orignalImage, self, nil, NULL);
    }
    //上传照片
    [picker dismissViewControllerAnimated:YES completion:^{
        if (editedImage) {
            
            
            if (self.isOne) {
                self.oneImgView.image = editedImage;
                
            }
            if (self.isTwo) {
                
                
                self.twoImgView.image = editedImage;
                
            }
            
            if (self.isThree) {
                
                self.threeImgView.image = editedImage;
            }
            
            if (self.isFour) {
                self.fourImgView.image = editedImage;
                
            }
            if (self.isFive) {
                self.fiveImgView.image = editedImage;
                
            }
            
      
            // 在这里上传
   [self doUploadPhoto:editedImage andURL:self.url];
            
        }
    }];
}




//上传头像
- (void)doUploadPhoto:(UIImage *)image andURL:(NSString *)URL
{
    // 1.创建一个管理者
  //  AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
   // NSData *fileData = UIImageJPEGRepresentation(self.allImage, 1.0);
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat=@"yyyyMMddHHmmss";
    NSString *str=[formatter stringFromDate:[NSDate date]];

    
    if (self.isOne) {
        self.picTag = @"zhizhao";
        [self.timeAndPictureDics setObject:str forKey:@"zhizhao"];
        NSLog(@"上传营业执照");
    }
    if (self.isTwo) {
        self.picTag = @"mendian1";
           [self.timeAndPictureDics setObject:str forKey:@"mendian1"];

          NSLog(@"上传店铺1");
    }
    
    if (self.isThree) {
        
        self.picTag = @"mendian2";
           [self.timeAndPictureDics setObject:str forKey:@"mendian2"];
        NSLog(@"上传店铺2");

    }
    
    if (self.isFour) {
       self.picTag = @"idcardfront";
           [self.timeAndPictureDics setObject:str forKey:@"idcardfront"];
        NSLog(@"身份证正");

    }
    if (self.isFive) {
      self.picTag = @"idcardback";
           [self.timeAndPictureDics setObject:str forKey:@"idcardback"];
        NSLog(@"身份证反");

        
    }
    

    
//    NSString *url = [NSString stringWithFormat:@"%@api/appupload.php",baseURL];
//    NSDictionary *param = @{@"act":self.picTag,@"phone":self.iphone};
//    //上传地址
//    [mgr POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//        
//        NSData *fileData = UIImageJPEGRepresentation(self.allImage, 1.0);
////        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
////        formatter.dateFormat=@"yyyyMMddHHmmss";
////        NSString *str=[formatter stringFromDate:[NSDate date]];
//      //  NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
//             [formData appendPartWithFileData:fileData name:@"upfile" fileName:str mimeType:@"image/jpeg"];
//       
//        
//       
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         NSLog(@"上传成功:%@",responseObject);
//        
//        
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"上传失败");
//        [GFProgressHUD showFailure:@"上传失败"];
//    }];
    
}

//获得设备是否有访问相机权限
-(BOOL)getCameraRecordPermisson
{
    NSString * mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied)
    {
        return NO;
    }
    return YES;
}

#pragma mark  上传多图
/** 
 @ param picName图片名字
 @ param actValue     act值
 */
- (void)upLoadMorePics:(UIImageView *)imgeView andPicName:(NSString *)picName andAct:(NSString *)actValue
{
    // 1.创建一个管理者
      AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
     NSData *fileData = UIImageJPEGRepresentation(imgeView.image, 1.0);
    
    
        NSString *url = [NSString stringWithFormat:@"%@api/appupload.php",baseUrl];
        NSDictionary *param = @{@"act":actValue,@"phone":self.iphone};
        //上传地址
        [mgr POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
                     [formData appendPartWithFileData:fileData name:@"upfile" fileName:self.timeAndPictureDics[actValue] mimeType:@"image/jpeg"];
        
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"上传成功:%@",responseObject);
    
    
    
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传失败");
            [GFProgressHUD showFailure:@"上传失败"];
        }];
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }



@end
