//
//  ModifiyViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/5/10.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "ModifiyViewController.h"
#import "YNTNetworkManager.h"
#import "YNTUITools.h"
#import "LoginViewController.h"
@interface ModifiyViewController ()<UITextFieldDelegate>
/**老密码*/
@property (nonatomic,strong) UITextField  * oldPasswordTextField;
/**新密码*/
@property (nonatomic,strong) UITextField  * passwordTextField;
/**确认密码*/
@property (nonatomic,strong) UITextField  * confirmNewPasswordTextField;
@end

@implementation ModifiyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"修改密码";
    [self setUpChildrenViews];
    // Do any additional setup after loading the view.
}

- (void)setUpChildrenViews
{
    // 创建手机号输入
    self.oldPasswordTextField = [YNTUITools creatTextField:CGRectMake(20 *kWidthScale, 100*kHeightScale, KScreenW -40*kWidthScale, 50*kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"请输入旧密码" keyboardType:UIKeyboardTypeDefault   font:15 secureTextEntry:YES clearButtonMode:UITextFieldViewModeAlways];
    self.oldPasswordTextField.delegate = self;
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.oldPasswordTextField];
    [self.view addSubview:self.oldPasswordTextField];
    
    
        // 创建手机号输入
    self.passwordTextField = [YNTUITools creatTextField:CGRectMake(20*kWidthScale, 170*kHeightScale, KScreenW -40*kWidthScale, 50*kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"请输入新密码(6到16位)" keyboardType:UIKeyboardTypeDefault   font:15 secureTextEntry:YES clearButtonMode:UITextFieldViewModeAlways];
    self.passwordTextField.delegate  = self;
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.passwordTextField];
    [self.view addSubview:self.passwordTextField];
    // 创建验证码输入
    self.confirmNewPasswordTextField= [YNTUITools creatTextField:CGRectMake(20*kWidthScale, 240*kHeightScale, KScreenW -40*kWidthScale, 50*kHeightScale) bgColor:[UIColor whiteColor] borderStyle:UITextBorderStyleRoundedRect placeHolder:@"再次输入" keyboardType:UIKeyboardTypeDefault   font:15 secureTextEntry:YES clearButtonMode:UITextFieldViewModeAlways];
    self.confirmNewPasswordTextField.delegate = self;
    // 监听文字的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.confirmNewPasswordTextField];
    [self.view addSubview:self.confirmNewPasswordTextField];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake( 37.5 *kWidthScale, 315 *kHeightScale, KScreenW - 70 *kWidthScale, 48 *kHeightScale);
    btn.backgroundColor = CGRBlue;
    [btn setTitle:@"确认修改" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

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
    NSLog(@"手机号:%@",self.oldPasswordTextField);
    NSLog(@"新密码:%@",self.passwordTextField.text);
    NSLog(@"确认新密码:%@",self.confirmNewPasswordTextField.text);
}
#pragma mark - 确认修改点击事件
- (void)confirmBtnAction:(UIButton *)sender
{
    if (self.oldPasswordTextField.text.length == 0 || self.passwordTextField.text.length == 0||self.confirmNewPasswordTextField.text.length == 0 ) {
        // 为空时
        [GFProgressHUD showFailure:@"请填写正确的信息"];
        return;
    }else{
        // 不为空时
        
        
        
        
        if ([self.passwordTextField.text isEqualToString:self.confirmNewPasswordTextField.text]) {
            // 密码输入相同时
            if ((self.passwordTextField.text.length >5)&&(self.passwordTextField.text.length <17)) {
                NSString *url = [NSString stringWithFormat:@"%@api/app.php",baseUrl];
                UserInfo *userInfo = [UserInfo currentAccount];
                NSDictionary *params = @{@"user_id":userInfo.user_id,@"psw":self.oldPasswordTextField.text,@"newpsw":self.passwordTextField.text,@"act":@"editpsw"};
                
                [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
                    NSLog(@"修改密码成功%@",responseObject);
                    NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
                    if ([status isEqualToString:@"1"]) {
                        [GFProgressHUD showSuccess:responseObject[@"msg"]];
                        UserInfo *userInfo = [UserInfo currentAccount];
                        [userInfo logOut];
                        LoginViewController *logVC = [[LoginViewController alloc]init];
                   
                        [self presentViewController:logVC animated:YES completion:^{
                          
                            self.tabBarController.selectedIndex = 0;
                        }];
                    }else{
                        [GFProgressHUD showFailure:responseObject[@"msg"]];
                    }
                } enError:^(NSError *error) {
                    
                }];
            }else{
                [GFProgressHUD showInfoMsg:@"密码长度应在6~16位!"];
            }
            
        }else{
            // 密码不同时
            [GFProgressHUD showFailure:@"两次密码不一致!"];
            
        }
        

        
        
        
        
        
        
        
        
        
    }
    
    
  
   
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
