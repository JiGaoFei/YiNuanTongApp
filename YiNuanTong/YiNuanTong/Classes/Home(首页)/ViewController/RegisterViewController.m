//
//  RegisterViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/13.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "RegisterViewController.h"
#import "YNTUITools.h"
#import "CompanyViewController.h"
#import "YNTNetworkManager.h"
#import "HomeAgreeViewController.h"
@interface RegisterViewController ()<UITextFieldDelegate>
{
    NSInteger _count;
    NSInteger _number;
}
/**手机号*/
@property (nonatomic,strong) UITextField  * iphoneNumberTextField;
/**验证码*/
@property (nonatomic,strong) UITextField  * checkNumberTextField;
/**识别码*/
@property (nonatomic,strong) UITextField  * identifyTextField;
/**获取短信btn*/
@property (nonatomic, strong) UIButton *msgBtn;
/**新密码*/
@property (nonatomic,strong) UITextField  * passwordTextField;
/**确认密码*/
@property (nonatomic,strong) UITextField  * confirmNewPasswordTextField;
/**邀请码*/
@property (nonatomic,strong) UITextField *invitationTextField;

/**下一步*/
@property (nonatomic,strong) UIButton *nextBtn;
/** 是否同意开通 */
@property (nonatomic,assign) BOOL isAgree;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isAgree = NO;
    self.view.backgroundColor = RGBA(249, 249, 249, 1);
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
    UILabel *titleNavLab = [YNTUITools createLabel:CGRectMake(42 *kPlus*kWidthScale , 79*kHeightScale, KScreenW - 42 *2*kPlus*kWidthScale, 12*kHeightScale) text:@"开通订货功能需要您进行手机验证,给您带来的不便请您见谅!" textAlignment:NSTextAlignmentCenter textColor:CGRGray bgColor:nil font:12];
    if (KScreenW == 320) {
        titleNavLab.font = [UIFont systemFontOfSize:10];
    }
    
    
    [self.view addSubview:titleNavLab];
    
    // 创建返回btn
    UIButton *backBtn = [YNTUITools createButton:CGRectMake(21.5, 20, 25, 32) bgColor: nil title:nil titleColor:nil action:@selector(backBtnAction:) vc:self];
    UIImage *backImg = [UIImage imageNamed:@"返回箭头"];
    backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [backBtn setImage:backImg forState:UIControlStateNormal];
   
    [self.view addSubview:backBtn];
    
    // 创建审核进度lab
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(KScreenW /2 -40, 20, 80, 40) text:@"申请开通" textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor] bgColor:nil font:17];
    [self.view addSubview:titleLab];

    // 创建手机号输入
    self.iphoneNumberTextField = [YNTUITools creatTextField:CGRectMake(20 *kWidthScale, 100*kHeightScale, KScreenW -40*kWidthScale, 50*kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"请输入手机号" keyboardType:UIKeyboardTypeDefault   font:15 secureTextEntry:NO clearButtonMode:UITextFieldViewModeAlways];
    self.iphoneNumberTextField.delegate = self;
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.iphoneNumberTextField];
    [self.view addSubview:self.iphoneNumberTextField];
    
    

    // 创建验证码输入
    self.checkNumberTextField = [YNTUITools creatTextField:CGRectMake(20*kWidthScale, 160*kHeightScale, 230*kWidthScale, 50*kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"请输入短信验证码" keyboardType:UIKeyboardTypeDefault   font:15 secureTextEntry:NO clearButtonMode:UITextFieldViewModeAlways];
    self.checkNumberTextField.delegate = self;
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.checkNumberTextField];
    [self.view addSubview:self.checkNumberTextField];
    
    
    
    // 创建获取验证码btn
    UIButton *getCheckNumberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getCheckNumberBtn.frame = CGRectMake(KScreenW - 124*kWidthScale, 160*kHeightScale, 110*kWidthScale, 50*kHeightScale) ;
    getCheckNumberBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    getCheckNumberBtn.backgroundColor = RGBA(18, 122, 203, 1);
    
    
    [getCheckNumberBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
    getCheckNumberBtn.layer.cornerRadius = 5;
    getCheckNumberBtn.layer.masksToBounds = YES;
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
    self.confirmNewPasswordTextField= [YNTUITools creatTextField:CGRectMake(20*kWidthScale, 280*kHeightScale, KScreenW -40*kWidthScale, 50*kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"再次输入" keyboardType:UIKeyboardTypeDefault   font:15 secureTextEntry:YES clearButtonMode:UITextFieldViewModeAlways];
    self.confirmNewPasswordTextField.delegate = self;
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.confirmNewPasswordTextField];
    [self.view addSubview:self.confirmNewPasswordTextField];

    
    // 创建邀请码输入
    
    self.invitationTextField= [YNTUITools creatTextField:CGRectMake(20*kWidthScale, 340*kHeightScale, KScreenW -40*kWidthScale, 50*kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"邀请码" keyboardType:UIKeyboardTypeDefault   font:15 secureTextEntry:YES clearButtonMode:UITextFieldViewModeAlways];
    self.invitationTextField.delegate = self;
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.invitationTextField];
    [self.view addSubview:self.invitationTextField];

    
    // 创建同意按钮
    UIButton *agreeBtn =[YNTUITools createButton:CGRectMake(20 *kWidthScale, 405 *kHeightScale, 14 *kWidthScale, 14 *kWidthScale) bgColor:nil title:nil titleColor:nil action:@selector(agreeBtnAction:) vc:self];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"registered_unchecked"] forState:UIControlStateNormal];
   
    [self.view addSubview:agreeBtn];
    
    // 创建imageView
    UIImageView *agreeImageView  = [YNTUITools createImageView:CGRectMake(50 *kWidthScale, 405*kHeightScale, 207 *kWidthScale, 15 *kHeightScale) bgColor:nil imageName:@"registered_text"];
    [self.view addSubview:agreeImageView];
    
    agreeImageView.userInteractionEnabled = YES;
    // 点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(agreeTapAction:)];
    [agreeImageView addGestureRecognizer:tapGesture];
    
    
    // 创建下一步btn
    UIButton *nextBtn = [YNTUITools createButton:CGRectMake(43 *kPlus*kWidthScale, 442*kHeightScale, KScreenW -43 *2 *kPlus*kWidthScale, 50*kHeightScale) bgColor:RGBA(0, 120, 205, 1) title:@"下一步" titleColor:[UIColor whiteColor] action:@selector(nextBtnAction:) vc:self];
    nextBtn.alpha = 0.3;
    nextBtn.userInteractionEnabled = NO;
    self.nextBtn  = nextBtn;
    
    [self.view addSubview:nextBtn];
    
 
}
// 同意按钮点击
- (void)agreeBtnAction:(UIButton *)sender
{
    if (self.isAgree) {
        // 不同意
          [sender setBackgroundImage:[UIImage imageNamed:@"registered_unchecked"] forState:UIControlStateNormal];
        self.isAgree = NO;
    }else{
        // 同意
          [sender setBackgroundImage:[UIImage imageNamed:@"registered_checked"] forState:UIControlStateNormal];
        self.isAgree = YES;
    }
  
}
// 手势点击
- (void)agreeTapAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"手势点击");
    HomeAgreeViewController *agreeeVC = [[HomeAgreeViewController alloc ]init];
    [self presentViewController:agreeeVC animated:YES completion:nil];
    
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
    NSString *url =[NSString stringWithFormat:@"%@api/sms/sms.php",baseUrl];
        NSDictionary *param = @{@"phone":_iphoneNumberTextField.text};
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
            NSLog(@"获取验证码成功%@",responseObject);
            NSDictionary *dic = responseObject[@"request"];
            NSString *err_code = [NSString stringWithFormat:@"%@",dic[@"err_code"]];
            
            if ([err_code isEqualToString:@"1"]) {
                [GFProgressHUD showFailure:@"该手机号已注册"];
            }else{
                [GFProgressHUD showInfoMsg:@"请注意查收验证码"];

            }
            
            
        } enError:^(NSError *error) {
            NSLog(@"获取验证码失败%@",error);
        }];


    // 在这里发获取验证码的交易
    
    
    NSString *msg;
    if ([self.iphoneNumberTextField.text isEqualToString:@""] || self.iphoneNumberTextField.text == NULL) {
        msg = @"手机号不能为空";
    }
    
    if (msg.length !=0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         
            return ;
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
    NSLog(@"新密码:%@",self.passwordTextField.text);
    NSLog(@"确认新密码:%@",self.confirmNewPasswordTextField.text);
    if ((self.iphoneNumberTextField.text.length == 0) || (self.checkNumberTextField.text.length == 0) || (self.passwordTextField.text.length == 0) || (self.confirmNewPasswordTextField.text.length == 0)) {
        
        self.nextBtn.alpha = 0.3;
        self.nextBtn.userInteractionEnabled = NO;
        
    }else{
        self.nextBtn.alpha = 1.0;
        
        self.nextBtn.userInteractionEnabled = YES;
    }

}

- (void)nextBtnAction:(UIButton *)sender
{
    NSLog(@"我是下一步");
    if (self.isAgree) {
        [self commitDataWithNext];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"需要您同意注册协议!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
}
#pragma mark  - 提交数据
- (void)commitDataWithNext
{
    if ([self.passwordTextField.text isEqualToString:self.confirmNewPasswordTextField.text] ) {
        
        // 是否传密码
        NSString *url = [NSString stringWithFormat:@"%@api/regcheck.php",baseUrl];
        NSDictionary *param = @{@"mobile":self.iphoneNumberTextField.text,@"mobile_code":self.checkNumberTextField.text};
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
            NSLog(@"短信验证成功%@",responseObject);
            // 如果验证成功进入一下界面
            if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                CompanyViewController *companyVC = [[CompanyViewController alloc]init];
                companyVC.password = self.passwordTextField.text;
                companyVC.iphone = self.iphoneNumberTextField.text;
                companyVC.invitationSn = self.invitationTextField.text;
                [self presentViewController:companyVC animated:YES completion:nil];
            }else{
                [GFProgressHUD showFailure:responseObject[@"info"]];
            }
            
        } enError:^(NSError *error) {
            NSLog(@"短信验证失败%@",error);
            [GFProgressHUD showFailure:@"验证失败"];
        }];
        
        
    }else{
        UIAlertController *alertVC  = [UIAlertController alertControllerWithTitle:@"温馨提示:"message:@"密码不一致请重新输入!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        [alertVC addAction:action1];
        [alertVC addAction:action2];
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
