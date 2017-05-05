//
//  GuideViewController.m
//  VTravel
//
//  Created by lanouhn on 16/6/1.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "GuideViewController.h"
#import "LaunchViewController.h"
@interface GuideViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;
// 约束的宽度  也可以拖成属性
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraints;

@end

@implementation GuideViewController
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    // 设置backView的宽度为当前引导页的宽度
    self.widthConstraints.constant = KScreenW *self.imageArray.count;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    for (int i = 0; i < self.imageArray.count; i++) {
        // 创建引导页要展示的imageView
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW * i, 0, KScreenW, kScreenH)];
        
        [imageView setImage:[UIImage imageNamed:self.imageArray[i]]];
        
        [self.backView addSubview:imageView];
        // 设置imageView的图片为外界传进来的图片
        // 判断当前引导页是最后一页,添加进入应用按钮
        if (i == self.imageArray.count - 1) {
            UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeSystem];
      
            enterButton.frame = CGRectMake((KScreenW - 220 *kWidthScale ) / 2, kScreenH - 130 *kHeightScale, 220 *kWidthScale, 50*kHeightScale);
            
            [imageView addSubview:enterButton];
            // 打开交互
            imageView.userInteractionEnabled = YES;
           //  enterButton.backgroundColor = [UIColor redColor];
            // enterButton添加点击事件
            [enterButton addTarget:self action:@selector(enterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        

    }
    
    
    
    
    
    
    
    
}
- (void)enterButtonClicked:(id)sender{
    
    // 当用户点击进入应用按钮时,将启动动画设置成当前应用的主window的rootViewController
    
    
 LaunchViewController *launchVC = [[LaunchViewController alloc]init];
    // 获得当前应用的主window 并将launchVC设置成rootViewController
    UIWindow *keywindow = [UIApplication sharedApplication].keyWindow;
    keywindow.rootViewController = launchVC;
    
    
    
    
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
