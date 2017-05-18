//
//  YNTMineViewController.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/12.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "YNTMineViewController.h"
#import "YNTUITools.h"
#import "AccountCell.h"
#import "MinHeadReusableView.h"
#import "MinHeadElseReusableView.h"
#import "MinFourBtnCell.h"
#import "MinSixCell.h"
#import "MinLineCell.h"
#import "LogoutCell.h"
#import "AccountViewController.h"
#import "CreditViewController.h"
#import "MinOrderDetailViewController.h"
#import "MinCompanyViewController.h"
#import "AddressViewController.h"
#import "CommenProblemViewController.h"
#import "OrderProcessViewController.h"
#import "OptionViewController.h"
#import "ContactViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AFNetworking/AFNetworking.h>
#import "YNTNetworkManager.h"
#import "ApplyRefundViewController.h"
#import "CreditViewController.h"
#import "YNTNewOrderViewController.h"
#import "ConfirmGoodsViewController.h"
#import "PhoneAccessViewController.h"
#import "LoginViewController.h"
#import "MineInvationViewController.h"
#import "ModifiyViewController.h"
@interface YNTMineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
/**collectionView*/
@property (nonatomic,strong) UICollectionView  * collectionView;
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic,strong) UIImageView *oneImgView;
/**创建布局对象*/
@property (nonatomic,strong) UICollectionViewFlowLayout  * flowLayout;
/**表头视图*/
@property (nonatomic,strong) MinHeadReusableView  * headView;
/**空的表头视图*/
@property (nonatomic,strong) MinHeadElseReusableView*headElseView;

/**sixCell数组标题*/
@property (nonatomic,strong) NSMutableArray *sixCellTitleArr;
/**line数组标题*/
@property (nonatomic,strong) NSMutableArray  * lineTitleArr;
/**账户title数据源*/
@property (nonatomic,strong) NSMutableArray  * accountTitleArr;
/**账户content数据源*/
@property (nonatomic,strong) NSMutableArray  * accountContentArr;
/**personData*/
@property (nonatomic,strong) NSMutableDictionary  * personDic;
@end
static NSString *accountCell = @"accountCell";
static NSString *headViewidentifier = @"headView";
static NSString *headViewElse = @"headViewElse";
static NSString *fourBtnCell = @"fourBtnCell";
static NSString *sixCell = @"sixCell";
static NSString *minLineCell = @"minLineCell";
static NSString *minLogout = @"logoutCell";
@implementation YNTMineViewController
- (NSMutableDictionary *)personDic
{
    if (!_personDic) {
        self.personDic = [[NSMutableDictionary alloc]init];
    }
    return _personDic;
}
/**
 *懒加载数组
 */
- (NSMutableArray *)sixCellTitleArr
{
    if (!_sixCellTitleArr) {
        self.sixCellTitleArr=[[NSMutableArray alloc]init];
    }
    return _sixCellTitleArr;
}
- (NSMutableArray *)lineTitleArr
{
    if (!_lineTitleArr) {
        self.lineTitleArr = [[NSMutableArray alloc]init];
        
    }
    return _lineTitleArr;
}
- (NSMutableArray *)accountTitleArr
{
    if (!_accountTitleArr) {
        self.accountTitleArr = [[NSMutableArray alloc]init];
        
    }
    return _accountTitleArr;
}
- (NSMutableArray *)accountContentArr
{
    if (!_accountContentArr) {
        self.accountContentArr = [[NSMutableArray alloc]init];
    }
    return _accountContentArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    // 加载数据
    [self loadData];
   
    

  
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.collectionView removeFromSuperview];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
}

/**
 *加载数据
 */
- (void)loadData
{
    UserInfo *userInfo = [UserInfo currentAccount];
    
    // 请求个人中心数据
    NSString *url =[NSString stringWithFormat:@"%@api/app.php",baseUrl];
    
    NSDictionary *params = @{@"user_id":userInfo.user_id,@"act":@"info"};
    
    [YNTNetworkManager requestPOSTwithURLStr:url paramDic:params finish:^(id responseObject) {
        self.personDic = responseObject;
        NSString *ishaveNew = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"has_new_order"]];
        if ([ishaveNew isEqualToString:@"1"]) {
            //  确认收货new
            self.sixCellTitleArr = @[@"公司信息",@"mine-收获地址",@"我的订单",@"信用申请",@"确认收货new",@"申请退换"].mutableCopy;
        }else{
            self.sixCellTitleArr = @[@"公司信息",@"mine-收获地址",@"我的订单",@"信用申请",@"mine-确认收货",@"申请退换"].mutableCopy;
        }
        
        //分区一数据源
        self.accountTitleArr = @[@"账户余额",@"信用币"].mutableCopy;
        self.accountContentArr = @[userInfo.amount,@"0.00"].mutableCopy;
        
        self.lineTitleArr = @[@"常见问题",@"订货流程",@"意见反馈",@"联系我们1",@"mine_change_the_password",@"我的邀请"].mutableCopy;
     
        [self setUpChildrenViews];
        [self.collectionView reloadData];
    } enError:^(NSError *error) {
        
    }];
    
    
    
    
    
    
    
    
    

    
    // 六个cell数据源
//    self.sixCellTitleArr = @[@"公司信息",@"mine-收获地址",@"我的订单",@"信用申请",@"mine-确认收货",@"申请退换"].mutableCopy;
 
   
 //   self.lineTitleArr = @[@"常见问题",@"订货流程",@"意见反馈",@"联系我们1",@"mine_change_the_password",@"我的邀请"].mutableCopy;
    
    
    
}

/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    self.headView = [[MinHeadReusableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 200)];
    self.headElseView = [[MinHeadElseReusableView alloc]init];

    
    // 创建collectionView
    
    // 创建布局对象
    self.flowLayout = [[UICollectionViewFlowLayout alloc]init];
    // 初始化collectionView对象
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, kScreenH-49) collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
   self.collectionView.backgroundColor = [UIColor whiteColor];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.flowLayout.headerReferenceSize = CGSizeMake(KScreenW, 160);
    // 注册accountCell
    [self.collectionView registerClass:[AccountCell class] forCellWithReuseIdentifier:accountCell];
    [self.collectionView registerClass:[MinFourBtnCell class] forCellWithReuseIdentifier:fourBtnCell];
    [self.collectionView registerClass:[MinSixCell class] forCellWithReuseIdentifier:sixCell];
    [self.collectionView registerClass:[MinLineCell class] forCellWithReuseIdentifier:minLineCell];
    [self.collectionView registerClass:[LogoutCell class] forCellWithReuseIdentifier:minLogout];
    

    // 注册头视图
    [self.collectionView registerClass:[MinHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewidentifier];
    [self.collectionView registerClass:[MinHeadElseReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewElse];

    


    [self.view addSubview:self.collectionView];
   
    
    
}


#pragma mark - collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    if (section == 1) {
        return 6;
    }
    if (section ==2) {
        // 判断是否显示邀请码
        UserInfo *userInfo = [UserInfo currentAccount];
        NSString *group_id = [NSString stringWithFormat:@"%@",userInfo.groupid];
        if ([group_id isEqualToString:@"14"]) {
            return 6;
        }else{
            return 5;
        }
      
    }
    if (section == 3) {
        return 1;
        
    }
    if (section == 4) {
        return 1;
    }

        return 1;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 4;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {

               return 60;
    }
    if (section == 2) {
        return 20;
    }
    if (section ==3) {
        return 20;
    }
    if (section == 4) {
        return 0;
    }
    return 20;
}
// 设置分区头的高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(KScreenW, 214 *kHeightScale);
    }
    if (section == 3) {
        return CGSizeMake(KScreenW, 20);

    }
//    if (section == 4) {
//        return CGSizeMake(KScreenW, 40);
//    }
    return CGSizeMake(KScreenW, 20);
}
// 返回列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    // 在这里设置每个分区的item大小
    if (section == 0) {
        // 设置第一个分区item大小
        self.flowLayout.itemSize = CGSizeMake(KScreenW/2, 60 *kHeightScale);
//        if (KScreenW == 414) {
//            self.flowLayout.itemSize = CGSizeMake(KScreenW/2 *kHeightScale, 60*kHeightScale );
//            }
        
        return 0;
    }else if (section ==1){
        // 设置其它分区item大小
        self.flowLayout.itemSize = CGSizeMake(110 *kWidthScale, 80 *kHeightScale);
   self.flowLayout.sectionInset = UIEdgeInsetsMake(10 , 0, 0, 10);
        return 0;

    }else if (section == 2){
        // 设置其它分区item大小
        self.flowLayout.itemSize = CGSizeMake(KScreenW, 20 *kHeightScale);
        return 0;

    } else if (section == 3){
        // 设置其它分区item大小
        self.flowLayout.itemSize = CGSizeMake(KScreenW, 60 *kHeightScale);

    }else{
        // 设置其它分区item大小
        self.flowLayout.itemSize = CGSizeMake(KScreenW, 40 *kHeightScale);
        return 0;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AccountCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:accountCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[AccountCell alloc]initWithFrame:CGRectMake(0, 0, KScreenW , 40 *kHeightScale)];
        }
        cell.accountLab.text = self.accountContentArr[indexPath.row];
    
        cell.accountDetailLab.text = self.accountTitleArr[indexPath.row];
        if (indexPath.row == 1) {
            cell.lineLab.hidden = YES;
        }
            return cell;

    }
    
    
    if (indexPath.section ==1) {
        MinSixCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:sixCell forIndexPath:indexPath];
        
        cell.imageView.image = [UIImage imageNamed:self.sixCellTitleArr[indexPath.row]];
        return cell;
    }
    if (indexPath.section == 2) {
       MinLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:minLineCell forIndexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:self.lineTitleArr[indexPath.row]];
        return cell;
        
    }
    if (indexPath.section == 3) {
        LogoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:minLogout forIndexPath:indexPath];
        cell.buttonClicked  = ^(NSInteger index)
        {
            NSLog(@"我是退出的回调");
            UIAlertController *alertVC =[UIAlertController alertControllerWithTitle:@"温馨提示:" message:@"你确定要退出吗?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *action2=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
                UserInfo *userInfo = [UserInfo currentAccount];
                [userInfo logOut];
                self.headView.companyImageView.image = [UIImage imageNamed:@"头像图片"];
                
                LoginViewController *logVC = [[LoginViewController alloc]init];
                [self presentViewController:logVC animated:YES completion:^{
                    self.tabBarController.selectedIndex = 0;
                }];

                
            }];
            
            [alertVC addAction:action1];
            [alertVC addAction:action2];
            [self presentViewController:alertVC animated:YES completion:nil];
        
            
            
        };
        return cell;
    }
    
    return 0;
}
// 返回区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
  

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
      
           
        if (indexPath.section == 0) {
       
            UserInfo *userInfo = [UserInfo currentAccount];
            self.headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewidentifier  forIndexPath:indexPath];
            self.headView.companyNameLab.text = userInfo.realname;
          
            __weak typeof(self) weakSelf = self;
            self.headView.companyImageViewClicked = ^(){
              // weakSelf.headView.companyImageView.image = weakSelf.oneImgView.image;
                NSLog(@"我是头像点击的回调");
                [weakSelf loadAlum];
            };
                        return self.headView;
          
            

        }else{
            self.headElseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headViewElse  forIndexPath:indexPath];
        }
        
     
            
            return  self.headElseView;
            
              }
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
               
            case 0:
            {
                                NSLog(@"点击的是账户余额");
//                AccountViewController *accountVC = [[AccountViewController alloc]init];
//                [self.navigationController pushViewController:accountVC animated:YES];

                
            }
                break;
            case 1:
            {
//                             NSLog(@"点击的是信用币");
//                CreditViewController *creditViewVC = [[CreditViewController alloc]init];
//                [self.navigationController pushViewController:creditViewVC animated:YES];

            }
                break;

    }
    }
    
    if (indexPath.section ==1) {
        switch (indexPath.row) {
            case 0:
            {
                MinCompanyViewController *companyVC = [[MinCompanyViewController alloc]init];
                [self.navigationController pushViewController:companyVC animated:YES];
                NSLog(@"点击的是公司信息");
            }
                break;
            case 1:
            {
                AddressViewController *addressVC = [[AddressViewController alloc]init];
                [self.navigationController pushViewController:addressVC animated:YES];
                   NSLog(@"点击的是收货地址 ");
            }
                break;

            case 2:
            {
                    NSLog(@"点击的是我的订单");
                YNTNewOrderViewController *orderVC =  [[YNTNewOrderViewController alloc]init];
             
                [self.navigationController pushViewController:orderVC animated:YES];
                
                
            }
                break;

            case 3:
            {
                     NSLog(@"点击的是信用申请");
                CreditViewController *creditVC = [[CreditViewController alloc]init];
                [self.navigationController pushViewController:creditVC animated:YES];
            }
                break;

            case 4:{
                   NSLog(@"点击的是确认收货");
                ConfirmGoodsViewController *confirmVC = [[ConfirmGoodsViewController alloc]init];
                [self.navigationController pushViewController:confirmVC animated:YES];
            }

                break;
            case 5:
            {
                NSLog(@"点击的是申请退换");
//                ApplyRefundViewController *applyRefundVC = [[ApplyRefundViewController alloc]init];
//                [self.navigationController pushViewController:applyRefundVC animated:YES];
                
                
                [GFProgressHUD showInfoMsg:@"此功能暂未开通!"];
            }
                break;

                
            default:
                break;
        }
        

    }

    if (indexPath.section ==2) {
        switch (indexPath.row) {
            case 0:
            {
                     NSLog(@"点击的是常见问题");
                CommenProblemViewController *commenVC = [[CommenProblemViewController alloc]init];
                [self.navigationController pushViewController:commenVC animated:YES];
            }
                break;
                
            case 1:
            {       NSLog(@"点击的是订货流程");
                OrderProcessViewController *orderVC= [[OrderProcessViewController alloc]init];
                [self.navigationController pushViewController:orderVC animated:YES];
                
               
            }
                break;

            case 2:
            {
                OptionViewController *optionVC = [[OptionViewController alloc]init];
                
                [self.navigationController pushViewController:optionVC animated:YES];
                   NSLog(@"点击的是意见反馈");            }
                break;

            case 3:
                {
                    PhoneAccessViewController *phoneVC = [[PhoneAccessViewController alloc]init];
                    [self.navigationController pushViewController:phoneVC animated:YES];
                    NSLog(@"点击的是联系我们");
            }
                break;
            case 4:
            {
                ModifiyViewController *modifiyVC = [[ModifiyViewController alloc]init];
                
              [self.navigationController pushViewController:modifiyVC animated:YES];
                NSLog(@"点击的是我的邀请码");
            }
                break;

            case 5:
            {
                MineInvationViewController *mineInvationVC = [[MineInvationViewController alloc]init];
                
                [self.navigationController pushViewController:mineInvationVC animated:YES];
                NSLog(@"点击的是我的邀请码");
            }
                break;

                
            default:
                break;
        }
        
    }
    

}
#pragma mark - scrollView的代理方法
// 监听滚动关闭弹簧效果
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y <= 0)
    {
        CGPoint offset = scrollView.contentOffset;
        offset.y = 0;
        scrollView.contentOffset = offset;
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
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
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
    
    self.oneImgView.image = editedImage;
    
    // 拍照后保存原图片到相册中
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera && orignalImage) {
        UIImageWriteToSavedPhotosAlbum(orignalImage, self, nil, NULL);
    }
    //上传照片
    [picker dismissViewControllerAnimated:YES completion:^{
        if (editedImage) {
            
            self.headView.companyImageView.image = editedImage;
            
              [self doUploadPhoto:editedImage];
            
        }
    }];
}




//上传头像
- (void)doUploadPhoto:(UIImage *)image{
    UserInfo *userInfo = [UserInfo currentAccount];
    
    
    // 1.创建一个管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    //
    
    // 2.发送一个请求
    NSString *url = [NSString stringWithFormat:@"%@api/app.php",baseUrl];
    //封装参数(这个字典只能放非文件参数)
    NSDictionary *param = @{@"act":@"modifyhead",@"uid":userInfo.user_id};
   
    //上传地址
    [mgr POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        NSData *fileData = UIImageJPEGRepresentation(image, 1.0);
        
       
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"yyyyMMddHHmmss";
        NSString *str=[formatter stringFromDate:[NSDate date]];
        NSString *fileName=[NSString stringWithFormat:@"%@.jpg",str];
        
        [formData appendPartWithFileData:fileData name:@"upfile" fileName:fileName mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"上传成功 %@", responseObject);
      
        NSString *msg = responseObject[@"msg"];
        
        if ([msg isEqualToString:@"success"]) {
            [GFProgressHUD showSuccess:responseObject[@"info"]];
            UserInfo *userInfo = [UserInfo currentAccount];
            [userInfo updateHeadImage:responseObject[@"url"]];
        }
        
      
        
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        NSLog(@"上传失败%@",error);
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

@end
