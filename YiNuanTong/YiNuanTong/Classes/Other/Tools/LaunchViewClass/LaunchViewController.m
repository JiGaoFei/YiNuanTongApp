//
//  LaunchViewController.m
//  FruitSupermarket
//
//  Created by lanouhn on 16/6/23.
//  Copyright © 2016年 lanouhn. All rights reserved.
//

#import "LaunchViewController.h"
#import "YNTTabBarViewController.h"
#import "UIImageView+WebCache.h"
#import <AFNetworking/AFNetworking.h>
#import "YNTUITools.h"
#define kUserDefaults [NSUserDefaults standardUserDefaults]
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";
@interface LaunchViewController ()
@property (strong, nonatomic) UIImageView *launchImageView;
@property (strong, nonatomic)  UIView *adContainView;
@property (nonatomic, strong) UIImageView *adView;
@property (nonatomic,strong) NSTimer *timer;
@property (strong, nonatomic) UIButton *jumpBtn;
@end

@implementation LaunchViewController
// 重写界面加载后再实现动画
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  

     }

- (void)viewDidLoad {
    [super viewDidLoad];
  
   //  [self setUpChildrenViews];
    [self setupAdvert];

 
    

    
    // Do any additional setup after loading the view from its nib.
}
/** 创建子视图 */
- (void)setUpChildrenViews
{
    // 创建定时器
    _timer =  [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    _jumpBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    _jumpBtn.frame = CGRectMake(KScreenW - 70 *kWidthScale, 30 *kHeightScale, 65 *kWidthScale, 25 *kHeightScale);
    _jumpBtn.backgroundColor = RGBA(0, 0, 0, 0.6);
    _jumpBtn.layer.cornerRadius = 5;
    _jumpBtn.layer.masksToBounds = YES;
    [_jumpBtn setTitle:@"跳转(3)" forState:UIControlStateNormal];
    _jumpBtn.titleLabel.font = [UIFont systemFontOfSize:17 *kHeightScale];
    [_jumpBtn addTarget:self action:@selector(jumpBtnAction:) forControlEvents:UIControlEventTouchUpInside];
   
   

    self.adView.frame = CGRectMake(0, 0, KScreenW, kScreenH);
    [self.view addSubview:_adView];
     [_adView addSubview:_jumpBtn];
    
    // NSArray *picArr = @[@"http://c.hiphotos.baidu.com/image/pic/item/9d82d158ccbf6c81927f8fe8be3eb13533fa4061.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/b17eca8065380cd7538232eda344ad3459828116.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/0824ab18972bd407b60bbaf779899e510eb309ef.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/060828381f30e924f230662e4e086e061d95f71d.jpg",@"http://g.hiphotos.baidu.com/image/pic/item/060828381f30e924363b22384e086e061d95f718.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/58ee3d6d55fbb2fb31c9af124d4a20a44723dcd4.jpg",@"http://f.hiphotos.baidu.com/image/pic/item/14ce36d3d539b60087baa6b7eb50352ac65cb7be.jpg",@"http://e.hiphotos.baidu.com/image/pic/item/838ba61ea8d3fd1f1534ca30324e251f95ca5ffe.jpg",@"http://c.hiphotos.baidu.com/image/h%3D200/sign=39226eeaf503918fc8d13aca613d264b/9213b07eca80653856d29d1995dda144ad3482fb.jpg",@"http://f.hiphotos.baidu.com/image/pic/item/b3b7d0a20cf431ad2eadfd394936acaf2edd98b7.jpg"];
    
   //  int i = arc4random()%9;
    
    // NSURL *url = [NSURL URLWithString:picArr[i]];
 //   NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
 //_adView.image = [UIImage imageWithContentsOfFile:filePath];
    self.adView.image = [UIImage imageNamed:@"广告图"];
  
}
- (void)jumpBtnAction:(UIButton *)sender
{
    NSLog(@"倒计时按钮的点击事件");
    // 获取当前的window
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 获得storyboard中的tabBarController
    UITabBarController *tabBarController = [[YNTTabBarViewController alloc] init];
    
    // 设置tabBarController为当前app的主window的rootViewController
    keyWindow.rootViewController = tabBarController;
    
    // 销毁定时器
    [_timer invalidate];
}

- (UIImageView *)adView
{
    if (_adView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [self.adContainView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        
        imageView.userInteractionEnabled = YES;
        
        
        _adView = imageView;
    }
    
    return _adView;
}
//  点击广告界面调用
- (void)tap
{
    // 跳转到界面 => safari
    NSURL *url = [NSURL URLWithString:@"http://www.1nuantong.com"];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
 
}
/**设置启动图片 */
- (void)timeChange
{
    // 倒计时
    static int i = 3;
    
    if (i == 1) {
        
        [self jumpBtnAction:nil];
        
        
    }
    
    i--;
    
    // 设置跳转按钮文字
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳转 (%d)",i] forState:UIControlStateNormal];
}

#pragma mark - 处理广告页

/**
 *  设置启动页广告
 */
- (void)setupAdvert {
        // 1.判断沙盒中是否存在广告图片，如果存在，直接显示
        NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (isExist) { // 图片存在
        [self setUpChildrenViews];
    }else{
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        // 获得storyboard中的tabBarController
        UITabBarController *tabBarController = [[YNTTabBarViewController alloc] init];
        
        // 设置tabBarController为当前app的主window的rootViewController
        keyWindow.rootViewController = tabBarController;

    }
    
        // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [self getAdvertisingImage];
}

/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage {
    
    // TODO 请求广告接口
    // 这里原本应该采用广告接口，现在用一些固定的网络图片url代替
    
    NSArray *imageArray = @[@"http://c.hiphotos.baidu.com/image/pic/item/9d82d158ccbf6c81927f8fe8be3eb13533fa4061.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/b17eca8065380cd7538232eda344ad3459828116.jpg",@"http://d.hiphotos.baidu.com/image/pic/item/0824ab18972bd407b60bbaf779899e510eb309ef.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/060828381f30e924f230662e4e086e061d95f71d.jpg",@"http://c.hiphotos.baidu.com/image/pic/item/58ee3d6d55fbb2fb31c9af124d4a20a44723dcd4.jpg",@"http://f.hiphotos.baidu.com/image/pic/item/14ce36d3d539b60087baa6b7eb50352ac65cb7be.jpg",@"http://e.hiphotos.baidu.com/image/pic/item/838ba61ea8d3fd1f1534ca30324e251f95ca5ffe.jpg"];
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    // 获取图片名:43-130P5122Z60-50.jpg
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist){ // 如果该图片不存在，则删除老图片，下载新图片
        
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
    }
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage {
    
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName {
    
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
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
