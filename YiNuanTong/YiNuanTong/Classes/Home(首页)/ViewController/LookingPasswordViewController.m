//
//  LookingPasswordViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/13.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "LookingPasswordViewController.h"
#import "YNTUITools.h"
#import "PasswordSuccessViewController.h"
#import "YNTNetworkManager.h"
@interface LookingPasswordViewController ()<UITextFieldDelegate>
{
    NSInteger _count;
    NSInteger _number;
}
/**手机号*/
@property (nonatomic,strong) UITextField  * iphoneNumberTextField;
/**验证码*/
@property (nonatomic,strong) UITextField  * checkNumberTextField;
/**新密码*/
@property (nonatomic,strong) UITextField  * passwordTextField;
/**确认密码*/
@property (nonatomic,strong) UITextField  * confirmNewPasswordTextField;
/**获取短信btn*/
@property (nonatomic, strong) UIButton *msgBtn;

/**下一步  */
@property (nonatomic,strong) UIButton *nextBtn;

@end

@implementation LookingPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpChildrenViews];
    
}
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建导航栏
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 64)];
    navView.backgroundColor = RGBA(18, 122, 203, 1);
    
    [self.view addSubview:navView];
    
    // 创建titleLab
//    UILabel *titleNavLab = [YNTUITools createLabel:CGRectMake(42 *kPlus , 79, KScreenW - 42 *2*kPlus, 12) text:@"开通订货功能需要您进行手机验证,给您带来的不便请您见谅!" textAlignment:NSTextAlignmentCenter textColor:CGRGray bgColor:nil font:12];
//    [self.view addSubview:titleNavLab];
    
    // 创建返回btn
    UIButton *backBtn = [YNTUITools createButton:CGRectMake(21.5, 20, 25, 32) bgColor: nil title:nil titleColor:nil action:@selector(backBtnAction:) vc:self];
    UIImage *backImg = [UIImage imageNamed:@"返回箭头"];
    backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    
    [self.view addSubview:backBtn];
    
    // 创建审核进度lab
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(KScreenW /2 -40, 20, 80, 40) text:@"找回密码" textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:17];
    [self.view addSubview:titleLab];
    
    // 创建手机号输入
    self.iphoneNumberTextField = [YNTUITools creatTextField:CGRectMake(20 *kWidthScale, 100*kHeightScale, KScreenW -40*kWidthScale, 50*kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"请输入手机号" keyboardType:UIKeyboardTypeDefault   font:15 secureTextEntry:NO clearButtonMode:UITextFieldViewModeAlways];
    
    self.iphoneNumberTextField.delegate = self;
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.iphoneNumberTextField];
    [self.view addSubview:self.iphoneNumberTextField];
    
    
    
    // 创建验证码输入
    self.checkNumberTextField = [YNTUITools creatTextField:CGRectMake(20 *kWidthScale, 160*kHeightScale, 230*kWidthScale, 50*kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"请输入短信验证码" keyboardType:UIKeyboardTypeDefault   font:15 secureTextEntry:NO clearButtonMode:UITextFieldViewModeAlways];
    self.checkNumberTextField.delegate = self;
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.checkNumberTextField];
    [self.view addSubview:self.checkNumberTextField];
    
    
    
    // 创建获取验证码btn
    UIButton *getCheckNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getCheckNumberBtn.layer.cornerRadius = 5;
    getCheckNumberBtn.layer.masksToBounds = YES;
    getCheckNumberBtn.frame = CGRectMake(KScreenW - 124*kWidthScale, 160*kHeightScale, 110*kWidthScale, 50*kHeightScale) ;
    getCheckNumberBtn.backgroundColor = RGBA(18, 122, 203, 1);
    
    [getCheckNumberBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
    [getCheckNumberBtn addTarget:self action:@selector(getCheckNumberBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.msgBtn = getCheckNumberBtn;
    [self.view addSubview:getCheckNumberBtn];
    
    
    
    
    // 创建手机号输入
    self.passwordTextField = [YNTUITools creatTextField:CGRectMake(20*kWidthScale, 220*kHeightScale, KScreenW -40*kWidthScale, 50*kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"请输入新密码" keyboardType:UIKeyboardTypeDefault   font:15 secureTextEntry:YES clearButtonMode:UITextFieldViewModeAlways];
    self.passwordTextField.delegate  = self;
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
    [self.view addSubview:self.passwordTextField];
    // 创建验证码输入
    self.confirmNewPasswordTextField= [YNTUITools creatTextField:CGRectMake(20 *kWidthScale, 280 *kHeightScale, KScreenW -40*kWidthScale, 50*kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"再次输入" keyboardType:UIKeyboardTypeDefault   font:15 secureTextEntry:YES clearButtonMode:UITextFieldViewModeAlways];
    self.confirmNewPasswordTextField.delegate = self;
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.confirmNewPasswordTextField];
    [self.view addSubview:self.confirmNewPasswordTextField];
    
    
    
    
    
    
    // 创建下一步btn
    UIButton *nextBtn = [YNTUITools createButton:CGRectMake(43 *kPlus*kWidthScale, 382*kHeightScale, KScreenW -43 *2 *kPlus*kWidthScale, 50*kHeightScale) bgColor:CGRGray title:@"下一步" titleColor:[UIColor whiteColor] action:@selector(nextBtnAction:) vc:self];
    nextBtn.userInteractionEnabled = NO;
    nextBtn.alpha = 0.3;
    self.nextBtn = nextBtn;
//    UIImage *nextImg = [UIImage imageNamed:@"下一步"];
//    nextImg = [nextImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [nextBtn setImage:nextImg forState:UIControlStateNormal];
    [self.view addSubview:nextBtn];
    
    
}
#pragma mark - 点击事件
-(void)backBtnAction:(UIButton *)sender
{
    NSLog(@"点击返回");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)getCheckNumberBtnAction:(UIButton *)sender
{
    NSLog(@"我是获取验证码");
   [GFProgressHUD showInfoMsg:@"请注意查收验证码"];
    // 在这里发获取验证码的交易
    NSString *url = [NSString stringWithFormat:@"%@api/sms/sms.php",baseUrl];
    NSDictionary *param = @{@"phone":self.iphoneNumberTextField.text,@"act":@"getpsw"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        NSLog(@"获取验证码成功%@",responseObject);
     
    } enError:^(NSError *error) {
        NSLog(@"获取验证码失败%@",error);
    }];
    NSString *msg;
    if ([self.iphoneNumberTextField.text isEqualToString:@""] || self.iphoneNumberTextField.text == NULL) {
        msg = @"手机号不能为空";
    }
    
    if (msg.length !=0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"要处理的事");
        }];
        [alertController addAction:confirmAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    [self performSelector:@selector(sendAction) withObject:nil];
    
    
    
}
// 模拟交易成功
- (void)sendAction
{
    self.msgBtn.enabled = NO;
    _count = 60;
    _number = 0;
    [self.msgBtn setTitle:@"60秒" forState:UIControlStateDisabled];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

- (void)timerFired:(NSTimer *)_timer
{
    if (_count !=0 && _number ==0) {
        _count -=1;
        NSString *str = [NSString stringWithFormat:@"%ld秒", (long)_count];
        [self.msgBtn setTitle:str forState:UIControlStateDisabled];
    }else{
        [_timer invalidate];
        self.msgBtn.enabled = YES;
        [self.msgBtn setTitle:@"点击获取" forState:UIControlStateNormal];
    }
}

#pragma mark - textFiled代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark -监听文字的改变
- (void)textFiledChange:(NSNotification *)info
{
    NSLog(@"手机号:%@",self.iphoneNumberTextField.text);
    NSLog(@"验证码:%@",self.checkNumberTextField.text);
    NSLog(@"请输入密码:%@",self.passwordTextField.text);
    NSLog(@"请再次输入密码:%@",self.confirmNewPasswordTextField.text);
    if ((self.iphoneNumberTextField.text.length == 0) || (self.checkNumberTextField.text.length == 0) || (self.passwordTextField.text.length == 0) || (self.confirmNewPasswordTextField.text.length == 0)) {
        _nextBtn.userInteractionEnabled = NO;
       _nextBtn.alpha = 0.3;
        
        
    }else{
       _nextBtn.userInteractionEnabled = YES;
      _nextBtn.alpha = 1;
    }

}

- (void)nextBtnAction:(UIButton *)sender
{
        NSLog(@"我是下一步");
    [self showHUD:@"正在提交"];
    NSString *url = [NSString stringWithFormat:@"%@api/app.php",baseUrl];

    NSDictionary *param = @{@"act":@"getbackPwd",@"phone":self.iphoneNumberTextField.text,@"code":self.checkNumberTextField.text,@"password":self.passwordTextField.text};
    
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
        [self hiddenHUD];
        NSLog(@"忘记密码请求成功%@",responseObject);
        NSString *msg = responseObject[@"msg"];
        if ([msg isEqualToString:@"success"]) {
        
            PasswordSuccessViewController *passwordVC = [[PasswordSuccessViewController alloc]init];
            passwordVC.mobile = self.iphoneNumberTextField.text;
            passwordVC.password = self.passwordTextField.text;
            [self presentViewController:passwordVC animated:YES completion:^{
                
            [GFProgressHUD showSuccess:responseObject[@"info"]];
                
            }];
          
        }else{
            [GFProgressHUD showFailure:responseObject[@"info"]];
        }
    } enError:^(NSError *error) {
        NSLog(@"忘记密码请求失败%@",error);
    }];
   
    
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
