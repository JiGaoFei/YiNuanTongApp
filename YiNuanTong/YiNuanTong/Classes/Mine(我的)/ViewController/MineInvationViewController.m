//
//  MineInvationViewController.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/28.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "MineInvationViewController.h"
#import "YNTUITools.h"
#import "YNTNetworkManager.h"
#import "UIImageView+WebCache.h"
@interface MineInvationViewController ()
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@end

@implementation MineInvationViewController
#pragma mark - 懒加载
- (NSMutableDictionary *)dataDic
{
    if (!_dataDic) {
        self.dataDic = [[NSMutableDictionary alloc]init];
    }
    return _dataDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的邀请";
    [self loadData];


}
// 加载数据
- (void)loadData
{
    UserInfo *userInfo = [UserInfo currentAccount];
    NSString *url = [NSString stringWithFormat:@"%@api/app.php",baseUrl];
    NSDictionary *prams =@{@"user_id":userInfo.user_id,@"act":@"yaoqing"};
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:prams finish:^(id responseObject) {
        self.dataDic = responseObject[@"data"];
            [self setUpChildrenViews];
    } enError:^(NSError *error) {
        
    }];
}
// 加载视图
- (void)setUpChildrenViews
{
   
    
    UILabel *nameLab = [YNTUITools createLabel:CGRectMake(KScreenW/2 - 50 *kWidthScale, 64+25*kHeightScale, 100 *kWidthScale, 20 *kHeightScale) text:@"我的品牌" textAlignment:NSTextAlignmentCenter textColor:nil bgColor:nil font:18 *kHeightScale];
     nameLab.text =[NSString stringWithFormat:@"品牌:%@",self.dataDic[@"bname"]];
     [self.view addSubview:nameLab];
    
    
    //my_invitation_my_brand
    UIImageView *imgView = [YNTUITools createImageView:CGRectMake(KScreenW/ 2 - 90 *kWidthScale, 64+55*kHeightScale, 180 *kWidthScale, 180 *kWidthScale) bgColor:nil imageName:@"my_invitation_my_brand"];
        [imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dataDic[@"erweima"]]]];
    [self.view addSubview:imgView];
    
    UILabel *mineLab =[YNTUITools createLabel:CGRectMake(99 *kWidthScale, 64+250*kHeightScale, 110 *kWidthScale, 20 *kHeightScale) text:@"我的邀请码:" textAlignment:NSTextAlignmentCenter textColor:nil bgColor:nil font:18 *kHeightScale];
    [self.view addSubview:mineLab];
    

    
    UILabel *invationSn =[YNTUITools createLabel:CGRectMake(215 *kWidthScale, 64+250*kHeightScale, 110 *kWidthScale, 20 *kHeightScale) text:self.dataDic[@"yao_num"] textAlignment:NSTextAlignmentLeft textColor:CGRBlue bgColor:nil font:18 *kHeightScale];
    [self.view addSubview:invationSn];
    
    UILabel *linLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 64+305*kHeightScale, KScreenW, 1)];
    linLab.backgroundColor = RGBA(248, 248, 248, 1);
    [self.view addSubview:linLab];
    
    UILabel *iosLab =[YNTUITools createLabel:CGRectMake(48 *kWidthScale, 64+490*kHeightScale, 110 *kWidthScale, 20 *kHeightScale) text:@"苹果客户端" textAlignment:NSTextAlignmentCenter textColor:nil bgColor:nil font:18 *kHeightScale];
    [self.view addSubview:iosLab];

    UILabel *andriodLab =[YNTUITools createLabel:CGRectMake(KScreenW-158 *kWidthScale, 64+490*kHeightScale, 110 *kWidthScale, 20 *kHeightScale) text:@"安卓客户端" textAlignment:NSTextAlignmentCenter textColor:nil bgColor:nil font:18 *kHeightScale];
    [self.view addSubview:andriodLab];
    
    
    
    UIImageView *iosImgView = [[UIImageView alloc]initWithFrame:CGRectMake(22.5 *kWidthScale, 64+330*kHeightScale, 150 *kWidthScale, 150 *kWidthScale)];
    [iosImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dataDic[@"ioserweima"]]]];
    [self.view addSubview:iosImgView];
    
    UIImageView *andriodImgView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW-172.5 *kWidthScale, 64+330*kHeightScale, 150 *kWidthScale, 150 *kWidthScale)];
        [andriodImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.dataDic[@"androiderweima"]]]];
    [self.view addSubview:andriodImgView];
    
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
