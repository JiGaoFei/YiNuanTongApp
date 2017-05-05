//
//  OptionListViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/27.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "OptionListViewController.h"
#import "SingLeton.h"
#import "YNTUITools.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking/AFNetworking.h>
#import "YNTNetworkManager.h"
@interface OptionListViewController ()<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
// 反馈信息文字框
@property (nonatomic,strong) UITextView *tellMeTextView;
// 占位lab
@property (nonatomic,strong)   UILabel *placeHolderLab;
@property (nonatomic, strong) UIImagePickerController *picker;
/**用来存放上传图片*/
@property (nonatomic,strong) UIImage *uploadImage;
@end

@implementation OptionListViewController
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
    self.title = @"新建反馈";
    self.view.backgroundColor = RGBA(249, 249, 249, 1);
    
    // 加载子视图
    [self setUpChildrenViews];
    // 加载底部视图
    [self setUpBottomViews];
    //  加载添加照片
    [self setUpAddPhotoViews];
 }
/**
 *加载子视图
 */
- (void)setUpChildrenViews
{
    // 创建背景view
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 11+64, KScreenW, 215)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    // 设置占位符
    self.placeHolderLab= [[UILabel alloc]initWithFrame:CGRectMake(0, 7, 100, 24 *kPlus)];
    self.placeHolderLab.enabled = NO;
    self.placeHolderLab.text = @"请输入反馈意见";
    self.placeHolderLab.textColor = CGRGray;
    self.placeHolderLab.font =[UIFont systemFontOfSize:12];

       // 创建输入框
    self.tellMeTextView = [[UITextView alloc]initWithFrame:CGRectMake(42 *kPlus ,75 , KScreenW - 2 * 42 *kPlus , 200 )];
    self.tellMeTextView.delegate = self;
  
  
    //监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextViewTextDidChangeNotification object:self.tellMeTextView];
    
    [self.tellMeTextView addSubview:self.placeHolderLab];

    [self.view addSubview:self.tellMeTextView];
}

- (void)textFieldChanged:(NSNotification *)info
{
    NSLog(@"账号:%@",self.tellMeTextView.text);
   
}
#pragma mark - 创建添加照片
- (void)setUpAddPhotoViews
{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 64 +235, KScreenW, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    // 创建添加btn
    UIButton *addBtn = [YNTUITools createButton:CGRectMake(42 *kPlus, 15, 41 *kPlus, 41 *kPlus) bgColor:nil title:nil titleColor:nil action:@selector(addBtnAction:) vc:self];
    [addBtn setImage:[UIImage imageNamed:@"添加图片的图标"] forState:UIControlStateNormal];
    [backView addSubview:addBtn];
    // 创建lab
    UILabel *titleLab = [YNTUITools createLabel:CGRectMake(42 * kPlus  + 20 +5, 15, 80, 15) text:@"添加照片" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15];
    
    [backView addSubview:titleLab];
    
    // 创建箭头指示
    UIImageView *imgView = [YNTUITools createImageView:CGRectMake(335, 20, 15 *kPlus, 27 *kPlus) bgColor:nil imageName:@"箭头"];
    [backView addSubview:imgView];
    
    
    
}
// 添加照片
- (void)addBtnAction:(UIButton *)sender
{
    NSLog(@"我是添加照片");
    // 取消键盘
    [self.view endEditing:YES];
    // 调用相册
    [self loadAlum];
}

/**
 *创建底部视图
 */
- (void)setUpBottomViews
{
    NSLog(@"创建底部视图");
    UIButton *sendBtn = [YNTUITools createButton:CGRectMake(0, kScreenH - 50, KScreenW, 50) bgColor:CGRBlue title:@"发送" titleColor:[UIColor whiteColor] action:@selector(sendBtnAction:) vc:self];
    [self.view addSubview:sendBtn];
}
#pragma mark tellMeTextView的代理方法
- (void)textViewDidChange:(UITextView *)textView
{
    if (self.tellMeTextView.text.length == 0) {
        [self.tellMeTextView addSubview:self.placeHolderLab];
        
    }else{
        [self.placeHolderLab removeFromSuperview];
    }
}
// 点击return的时候隐藏键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
// 点击空白区域隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark - 发送按钮的点击事件
- (void)sendBtnAction:(UIButton *)sender
{
    NSLog(@"我是发送");
    
    if (self.tellMeTextView.text.length == 0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入要反馈的信息!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            return ;
        }];
        [alertVC addAction:confirmAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else{
        // 提交数据
        [self  commitData];
    }
    
    // 回调刷新
    if (self.editSuccessBlock) {
        self.editSuccessBlock();
    }
  
    
    
}
#pragma mark 提交数据
- (void)commitData
{  // 1.创建一个管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    
    // 2.发送一个请求
    NSString *url = [NSString stringWithFormat:@"%@api/feedback.php",baseUrl];
    UserInfo *userInfo = [UserInfo currentAccount];
    //
    NSDictionary *param = @{@"act":@"fankui",@"user_id":userInfo.user_id,@"content":self.tellMeTextView.text};
    if (self.uploadImage) {
        //上传地址
        [mgr POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            NSData *fileData = UIImageJPEGRepresentation(self.uploadImage, 1.0);
            
            [formData appendPartWithFileData:fileData name:@"upfile" fileName:fileName mimeType:@"image/jpeg"];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"上传成功 %@", responseObject);
            NSString *msg = responseObject[@"msg"];
            if ([msg isEqualToString:@"success"]) {
               
                [self.navigationController popViewControllerAnimated:YES];
                [GFProgressHUD showSuccess:responseObject[@"info"]];
                
            }
            
            
            
            
            
            
            
            
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSLog(@"上传失败%@",error);
        }];
        
    }else{  // 没有照片的时候
        
        [YNTNetworkManager requestPOSTwithURLStr:url paramDic:param finish:^(id responseObject) {
            NSString *msg = responseObject[@"msg"];
            if ([msg isEqualToString:@"success"]) {
                [self.navigationController popViewControllerAnimated:YES];
                [GFProgressHUD showSuccess:responseObject[@"info"]];
            
                NSLog(@"没有照片的时候 上传 成功");
                
            }
            
        } enError:^(NSError *error) {
            NSLog(@"没有照片的时候上传失败");
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
    
    self.uploadImage= editedImage;
    
    // 拍照后保存原图片到相册中
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera && orignalImage) {
        UIImageWriteToSavedPhotosAlbum(orignalImage, self, nil, NULL);
    }
    //上传照片
    [picker dismissViewControllerAnimated:YES completion:^{
        if (editedImage) {
            
            self.uploadImage = editedImage;
            
            
        }
    }];
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
