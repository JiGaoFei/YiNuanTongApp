//
//  GFShopTableViewCell.m
//  1暖通购物车列表
//
//  Created by 纪高飞 on 17/4/2.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GFShopTableViewCell.h"
#import "YNTUITools.h"

// 宏定义当前屏幕的宽度
#define KScreenW [UIScreen mainScreen].bounds.size.width
// 宏定义当前屏幕的高度
#define kScreenH [UIScreen mainScreen].bounds.size.height
// 屏幕宽的比例
#define kWidthScale [UIScreen mainScreen].bounds.size.width / 375
// 屏幕高的比例
#define kHeightScale [UIScreen mainScreen].bounds.size.height / 667

@interface GFShopTableViewCell ()
@property (nonatomic,assign) BOOL isSelect;

@end
@implementation GFShopTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.isSelect = YES;
        //  创建视图
        [self setUpChildrenView];
        
    }
    return self;
}
- (void)setUpChildrenView
{
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.selectBtn.frame = CGRectMake(15*kWidthScale, 33 *kHeightScale, 18*kWidthScale, 18 *kWidthScale);
   // [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"unchecked@2x"] forState:UIControlStateNormal];
    
    [self.selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn];
    
    self.shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(43 *kWidthScale, 10 *kHeightScale, 180 *kWidthScale , 60 *kHeightScale)];
    self.shopNameLabel.font = [UIFont systemFontOfSize:11*kHeightScale];
    self.shopNameLabel.numberOfLines = 0;
    self.shopNameLabel.text = @"颜色:亚光粉红;进出口方式:上进下出;口径:4分;中心距:60;术数:30";
    self.shopNameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.shopNameLabel];
    
    self.shopPriceLabel =[[UILabel alloc]initWithFrame:CGRectMake(43 *kWidthScale, 60 *kHeightScale, 200 *kWidthScale , 15 *kHeightScale)];
    self.shopPriceLabel.font = [UIFont systemFontOfSize:12*kHeightScale];
    self.shopPriceLabel.text = @"99.99元/个";
    self.shopPriceLabel.textColor = [UIColor colorWithRed:247.0/255 green:87.0/255 blue:50.0/255 alpha:1.0];

    [self.contentView addSubview:self.shopPriceLabel];
    
    
    
    
    // 创建加减背景
    UIImageView *addImgView = [YNTUITools createImageView:CGRectMake(KScreenW - 137*kWidthScale, 30 *kHeightScale, 112*kWidthScale, 24*kHeightScale) bgColor:nil imageName:@"number_frame"];
    addImgView.userInteractionEnabled = YES;
    [self.contentView addSubview:addImgView];
    
    
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(KScreenW - 47*kWidthScale, 35 *kHeightScale, 22 *kWidthScale,22*kWidthScale);
    
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addBtn];
    // 数量显示
    self.numberTextField  = [YNTUITools creatTextField:CGRectMake(KScreenW-118*kWidthScale, 32*kHeightScale, 66*kWidthScale, 22*kHeightScale) bgColor:nil borderStyle:UITextBorderStyleNone placeHolder:nil keyboardType:UIKeyboardTypeNumberPad font:14*kHeightScale secureTextEntry:NO clearButtonMode:UITextFieldViewModeWhileEditing];
    _numberTextField.textAlignment =NSTextAlignmentCenter;
    _numberTextField.text = @"0";
    [self.contentView addSubview:_numberTextField];

    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame =  CGRectMake(KScreenW - 136*kWidthScale, 35*kHeightScale,22*kWidthScale,22*kHeightScale);
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView  addSubview:cutBtn];
    
    // 监听变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.numberTextField];
    
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, KScreenW,30)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(KScreenW - 60, 7,50, 20)];
    [button addTarget:self action:@selector(confrimBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"完成"forState:UIControlStateNormal];
    [button setTitleColor:CGRBlue forState:UIControlStateNormal];
    [bar addSubview:button];
    _numberTextField.inputAccessoryView = bar;
    [self.contentView addSubview:self.numberTextField];

    
}
#pragma mark - 文字输入框实时输入
- (void)textFiledChange:(NSNotification *)userInf
{
    NSLog(@"%@",self.numberTextField.text);
    if (self.numberTextFiledInputText) {
        self.numberTextFiledInputText(self.numberTextField.text);
    }
}
#pragma mark - 文字输入完成 
- (void)confrimBtnAction:(UIButton *)sender
{
    if (self.confirmBtnBlock) {
        if ([self.numberTextField.text isEqualToString:@"0"]) {
            
        }
        self.confirmBtnBlock(self.numberTextField.text);
    }
    //  NSLog(@"点击的是键盘上的完成按钮");
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView endEditing:YES];
    }];
    

}
#pragma mark - 点击选中按钮事件
- (void)selectBtnAction:(UIButton *)sender
{
    if (self.isSelect) {
       // [sender setBackgroundImage:[UIImage imageNamed:@"unchecked@2x"] forState:UIControlStateNormal];
             self.isSelect  = NO;
        // 取消选中回调事件
        if (self.selectBtnBlock) {
            self.selectBtnBlock(NO);
        }
    }else{
     //  [sender setBackgroundImage:[UIImage imageNamed:@"checked@2x"] forState:UIControlStateNormal];
        self.isSelect  = YES;
        // 选中回调事件
        if (self.selectBtnBlock) {
            self.selectBtnBlock(YES);
        }

    }
}
- (void)addBtnClick:(UIButton *)sender
{
    NSLog(@"点击的是加号");
   NSInteger textNumber = [self.numberTextField.text integerValue];
    textNumber +=1;
    
    self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)textNumber];
    if (self.addBtnBloock) {
        self.addBtnBloock(self.numberTextField.text);
    }
    
}
- (void)cutBtnClick:(UIButton *)sender
{
    NSLog(@"点击的是减号");
    NSInteger textNumber = [self.numberTextField.text integerValue];
    textNumber -=1;
    if (textNumber <1) {
        return;
    }
       self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)textNumber];
    if (self.cutBtnBloock) {
        self.cutBtnBloock(self.numberTextField.text);
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
  }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    }

@end
