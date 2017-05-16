//
//  HomeReusableHeadView.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/17.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "HomeReusableHeadView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "YNTNetworkManager.h"
#import "CycleDetailViewController.h"
#import "UICollectionReusableView+Controller.h"

@interface HomeReusableHeadView ()<SDCycleScrollViewDelegate>
/**存放要跳转链接的url*/
@property (nonatomic,strong) NSMutableArray *urlArray;
@end
@implementation HomeReusableHeadView
- (NSMutableArray *)urlArray
{
    if (!_urlArray) {
        self.urlArray = [[NSMutableArray alloc]init];
    }
    return _urlArray;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpChildrenViews];
    }
    return self;
}
/**
 *创建子视图
 */
- (void) setUpChildrenViews
{
    // 创建轮播图
    self.imgArr = [[NSMutableArray alloc]init];
    
    // 请求轮播图数据
    NSString *bannerPicUrl = [NSString stringWithFormat:@"%@api/bannerclass.php",baseUrl];

    [YNTNetworkManager requestPOSTwithURLStr:bannerPicUrl paramDic:nil finish:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *returnDic = [NSDictionary dictionaryWithDictionary:responseObject];
        NSArray *returnArray = returnDic[@"data"];
    
        
        for (NSDictionary *dataDic in returnArray) {
            
            NSString *str = dataDic[@"url"];
            [self.urlArray addObject:dataDic[@"link"]];
            [self.imgArr addObject:str];
            
       
            
            
        }
        SDCycleScrollView *cycleScroollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenW, 180*kHeightScale) imageURLStringsGroup:self.imgArr];
        cycleScroollView.delegate = self;
         [self addSubview:cycleScroollView];
        
        
        [self addSubview:cycleScroollView];
    } enError:^(NSError *error) {
        NSLog(@"请求失败");
    }];
    
    
}
#pragma mark ——— SDCyclleScroollView代理

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    CycleDetailViewController *cycleViewController = [[CycleDetailViewController alloc]init];
    cycleViewController.link = self.urlArray[index];
   UIViewController *vc = [self firstViewController];
    if ([self.urlArray[index] isEqualToString:@""]) {
        // 链接为空时不跳转
        return;
    }else{
           [vc.navigationController pushViewController:cycleViewController animated:YES];
    }

}
@end
