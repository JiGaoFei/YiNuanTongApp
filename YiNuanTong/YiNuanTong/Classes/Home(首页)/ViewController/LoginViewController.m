//
//  LoginViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/13.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "LoginViewController.h"
#import "LookingPasswordViewController.h"
#import "ReviewProgressViewController.h"
#import "RegisterViewController.h"
#import "SingLeton.h"
#import "YNTUITools.h"
#import "YNTNetworkManager.h"
#import "UserInfo.h"
#import "Examine.h"
@interface LoginViewController ()<UITextFieldDelegate>
/**logo图标*/
@property (nonatomic,strong) UIImageView  * logoImageView;
/**登陆账号*/
@property (nonatomic,strong) UITextField  * loginAccountTextField;
/**登陆密码*/
@property (nonatomic,strong) UITextField  * loginPasswordTextField;
/**登陆按钮*/
@property (nonatomic,strong) UIButton *loginBtn;



@end

@implementation LoginViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpChildrenViews];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登陆界面";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    }
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建logo图标
   self.logoImageView =  [YNTUITools createImageView:CGRectMake(84*kPlus *kWidthScale , 144*kPlus *kHeightScale, 582*kPlus *kWidthScale, 188*kPlus *kHeightScale) bgColor:nil imageName:@"title"];
    

    [self.view addSubview:self.logoImageView];
  

    // 创建边框1
    UIImageView *accountBorderImageView = [YNTUITools createImageView:CGRectMake(45*kWidthScale  , 250*kHeightScale, (KScreenW - 45 *2*kWidthScale) , 43 *kHeightScale ) bgColor:nil imageName:@"边框"];
    accountBorderImageView.userInteractionEnabled = YES;
    [self.view addSubview:accountBorderImageView];

    // 创建登陆账号图标
    UIImageView *loginAccountImageView = [YNTUITools createImageView:CGRectMake((84 +31)*kPlus*kWidthScale , 258 *kHeightScale, 46*kPlus , 46*kPlus) bgColor:nil imageName:@"头像"];
    [self.view addSubview:loginAccountImageView];
    
    self.loginAccountTextField = [YNTUITools creatTextField:CGRectMake(85 *kWidthScale,253 *kHeightScale, (self.logoImageView.frame.size.width-101*kPlus-40)*kWidthScale, 76*kPlus *kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleNone placeHolder:@"请输入登陆账号" keyboardType:UIKeyboardTypeDefault   font:17 secureTextEntry:NO clearButtonMode:UITextFieldViewModeAlways];
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.loginAccountTextField];
    
    self.loginAccountTextField.delegate = self;
 
    [self.view addSubview:self.loginAccountTextField];
    
    // 创建边框2
    UIImageView *passwordBorderImageView = [YNTUITools createImageView:CGRectMake(45 *kWidthScale , 310 *kHeightScale, (KScreenW - 90*kWidthScale) , 43*kHeightScale) bgColor:nil imageName:@"边框"];
    passwordBorderImageView.userInteractionEnabled = YES;
    [self.view addSubview:passwordBorderImageView];
    
    // 创建登陆密码图标
    UIImageView *loginPasswordImageView = [YNTUITools createImageView:CGRectMake((84 +31)*kPlus*kWidthScale , 320*kHeightScale, 46*kPlus , 46*kPlus) bgColor:nil imageName:@"密码"];
    [self.view addSubview:loginPasswordImageView];
    
    self.loginPasswordTextField = [YNTUITools creatTextField:CGRectMake(85 *kWidthScale,312 *kHeightScale, (self.logoImageView.frame.size.width-101*kPlus-40)*kWidthScale, 76*kPlus *kHeightScale) bgColor:[UIColor whiteColor] borderStyle:    UITextBorderStyleNone placeHolder:@"请输入登陆密码" keyboardType:UIKeyboardTypeDefault   font:17 secureTextEntry:YES clearButtonMode:UITextFieldViewModeAlways];
    self.loginPasswordTextField.delegate  = self;
    
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.loginPasswordTextField];

   

    [self.view addSubview:self.loginPasswordTextField];
    
    // 找回密码btn
    UIButton *lookPasswordBtn = [YNTUITools createButton:CGRectMake(260*kWidthScale, 360*kHeightScale,142*kPlus*kWidthScale, 31*kPlus*kHeightScale) bgColor:nil title:@"忘记密码?"   titleColor:[UIColor whiteColor] action:@selector(lookPasswordBtnAction:) vc:self];
    
    UIImage *lookPasswordImag = [UIImage imageNamed:@"忘记密码"];
    lookPasswordImag = [lookPasswordImag imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [lookPasswordBtn setImage:lookPasswordImag forState:UIControlStateNormal];
    [self.view addSubview:lookPasswordBtn];
    
    // 登陆btn
    UIButton *loginBtn = [YNTUITools createButton:CGRectMake(84*kPlus *kWidthScale,420*kHeightScale , self.logoImageView.frame.size.width , 99*kPlus*kHeightScale) bgColor:nil title:@""   titleColor:nil action:@selector(loginBtnnAction:) vc:self];



    // 取消系统的渲染色
    UIImage *loginBtnImage = [UIImage imageNamed:@"登录"];
    loginBtnImage = [loginBtnImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

//    [loginBtn setImage:loginBtnImage forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:loginBtnImage forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    
    //快速注册btn
    UIButton *quickRegistBtn = [YNTUITools createButton:CGRectMake(84*kPlus *kWidthScale,495*kHeightScale , self.logoImageView.frame.size.width , 99*kPlus*kHeightScale)  bgColor:nil title:@""   titleColor:[UIColor whiteColor] action:@selector(quickRegistBtnAction:) vc:self];
    UIImage *quickRegistBtnImage = [UIImage imageNamed:@"index_registered"];
   quickRegistBtnImage = [quickRegistBtnImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [quickRegistBtn setImage:quickRegistBtnImage forState:UIControlStateNormal];
    [self.view addSubview:quickRegistBtn];

//    // 审核进度btn
//    UIButton *reviewProgressBtn = [YNTUITools createButton:CGRectMake(KScreenW -(51 +152)*kPlus*kWidthScale, kScreenH - 82*kPlus*kHeightScale, 152*kPlus*kWidthScale, 31*kPlus*kHeightScale) bgColor:nil  title:@"审核进度>>"   titleColor:[UIColor whiteColor] action:@selector(reviewProgressBtnAction:) vc:self];
//    
//    UIImage *reviewProgressBtnImage =[UIImage imageNamed:@"审核进度"];
//    reviewProgressBtnImage = [reviewProgressBtnImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [reviewProgressBtn setImage:reviewProgressBtnImage forState:UIControlStateNormal];
//    
//    [self.view addSubview:reviewProgressBtn];

    }
#pragma mark -监听文字的改变
- (void)textFiledChange:(NSNotification *)info
{
    NSLog(@"账号:%@",self.loginAccountTextField.text);
    NSLog(@"密码%@",self.loginPasswordTextField.text);
    
}
#pragma mark - 找回密码事件
- (void)lookPasswordBtnAction:(UIButton *)sender
{
    NSLog(@"我是找回密码");
    LookingPasswordViewController *lookPasswordVC = [[LookingPasswordViewController alloc]init];
    [self presentViewController:lookPasswordVC animated:YES completion:nil];
}
- (void)loginBtnnAction:(UIButton *)sender
{
    NSLog(@"我是登陆按钮");
    if (self.loginAccountTextField.text.length == 0 || self.loginPasswordTextField.text == 0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"请输入正确的账号和密码!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:  UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            return ;
                   }];
        [alertVC addAction:confirmAction];
        [self presentViewController:alertVC animated:YES completion:nil];
                                        
    }else{
        [self showHUD:@"正在提交"];
        
        NSDictionary *param  = @{@"phone":self.loginAccountTextField.text,@"password":self.loginPasswordTextField.text,@"act":@"login"};
        NSString *url = [NSString stringWithFormat:@"%@api/app.php",baseUrl];
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
            NSLog(@"登陆成功:%@",responseObject);
            [self hiddenHUD];
            //当登陆成功后存储用户信息
            UserInfo *userInfo = [UserInfo currentAccount];
            NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
            // 登陆失败
            if ([code isEqualToString:@"0"]) {
                [GFProgressHUD showFailure:@"登陆失败!"];

            }
            // 登陆成功
            if ([code isEqualToString:@"1"]) {
                NSDictionary *infoDict = responseObject[@"info"];
                
                [GFProgressHUD showSuccess:@"登陆成功"];
                
                [userInfo saveLoginInfo:infoDict withPassword:self.loginPasswordTextField.text withUserName:self.loginAccountTextField.text];
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            
            // 审核中
            if ([code isEqualToString:@"2"]) {
              
                // 当号码存在的时候
                NSDictionary *params = @{@"act":@"shenhejindu",@"phone":self.loginAccountTextField.text};
                [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
                    
                    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
                    NSInteger status = [dic[@"status"]   integerValue];
                    
                    NSLog(@"请求数据成功%@",responseObject);
                    
                    ReviewProgressViewController *reviewProgressVC = [[ReviewProgressViewController alloc]init];
                    reviewProgressVC.status = status;
                    [self presentViewController:reviewProgressVC animated:YES completion:nil];
                } enError:^(NSError *error) {
                    NSLog(@"请求数据失败%@",error);
                }];
                
            }
            

       

            
            
        } enError:^(NSError *error) {
            NSLog(@"请求失败");
            NSLog(@"%@",error);
        }];
        

    }
    
    
    
}
- (void)quickRegistBtnAction:(UIButton *)sender
{
    NSLog(@"我是快速注册");
    RegisterViewController *registerVC = [[RegisterViewController alloc]init];
    [self presentViewController:registerVC animated:YES completion:nil];
}
- (void)reviewProgressBtnAction:(UIButton *)sender
{
    NSLog(@"我是审核进度");
    Examine *userInfo = [Examine currentAccount];
    NSString *url = @"http://shang.fiqie.com/api/app.php";
    if (!userInfo.phone) {
        // 当号码不存在的时候
        [self dismissViewControllerAnimated:NO completion:^{
            [GFProgressHUD showInfoMsg:@"亲,你还没有注册哟!"];
        }];
        
    }else{
        // 当号码存在的时候
        NSDictionary *params = @{@"act":@"shenhejindu",@"phone":userInfo.phone};
                [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
                    
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:responseObject];
            NSInteger status = [dic[@"status"]   integerValue];
            
            NSLog(@"请求数据成功%@",responseObject);
                
            ReviewProgressViewController *reviewProgressVC = [[ReviewProgressViewController alloc]init];
                    reviewProgressVC.status = status;
            [self presentViewController:reviewProgressVC animated:YES completion:nil];
        } enError:^(NSError *error) {
            NSLog(@"请求数据失败%@",error);
        }];
        
    }

  

    
    
}
#pragma mark - textField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
