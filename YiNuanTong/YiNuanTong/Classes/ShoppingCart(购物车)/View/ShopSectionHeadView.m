//
//  ShopSectionHeadView.m
//  1暖通购物车列表
//
//  Created by 1暖通商城 on 2017/4/5.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "ShopSectionHeadView.h"
#import "YNTUITools.h"
// 宏定义当前屏幕的宽度
#define KScreenW [UIScreen mainScreen].bounds.size.width
// 宏定义当前屏幕的高度
#define kScreenH [UIScreen mainScreen].bounds.size.height
// 屏幕宽的比例
#define kWidthScale [UIScreen mainScreen].bounds.size.width / 375
// 屏幕高的比例
#define kHeightScale [UIScreen mainScreen].bounds.size.height / 667


@interface ShopSectionHeadView ()
@property (nonatomic,assign) BOOL selcetBtnIsSelect;
@end

@implementation ShopSectionHeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 加载视图
        [self setUpChildrenViews];
        self.selcetBtnIsSelect = YES;
    }
    return self;
}
#pragma mark - 加载视图
- (void)setUpChildrenViews
{
    UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 10 *kHeightScale)];
    lineLab.backgroundColor = [UIColor grayColor];
    [self addSubview:lineLab];
    //选中按钮
   self.selectBtn = [YNTUITools createButton:CGRectMake(15 *kWidthScale, 49 *kHeightScale, 18 *kWidthScale, 18 *kWidthScale) bgColor:nil title:@"" titleColor:nil action:@selector(btnAction:) vc:self];
   
    [self addSubview:_selectBtn];
    
    // 商品图片
    self.goodImgView = [[UIImageView alloc]initWithFrame:CGRectMake(43 *kWidthScale, 20 *kHeightScale, 76*kWidthScale, 76 *kWidthScale)];
    _goodImgView.image = [UIImage imageNamed:@"1"];
    [self addSubview:_goodImgView];
    // 商品 名字
    self.goodNameLab = [YNTUITools createLabel:CGRectMake(128 *kWidthScale, 25 *kHeightScale, 180 *kWidthScale, 40 *kHeightScale) text:@"凯萨散热器钢制散热器凯萨散热器钢制散热器" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15 *kHeightScale];
    self.goodNameLab.numberOfLines = 0;
    
    [self addSubview:_goodNameLab];
    

    self.roateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _roateBtn.frame =CGRectMake(KScreenW - 30 *kWidthScale, 48 *kHeightScale, 22 *kWidthScale, 22 *kHeightScale);
    [self.roateBtn addTarget:self action:@selector(roateBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *roateImg = [UIImage imageNamed:@"arrow_bofore"];
    roateImg = [roateImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.roateBtn setImage:roateImg forState:UIControlStateNormal];
    [self addSubview:self.roateBtn];
    
    
    
    
    
    
    
    // 创建加减背景
    self.addImgView = [YNTUITools createImageView:CGRectMake(KScreenW - 142*kWidthScale, 70 *kHeightScale, 112*kWidthScale, 24*kHeightScale) bgColor:nil imageName:@"number_frame"];
    _addImgView.userInteractionEnabled = YES;
    [self addSubview:_addImgView];
    
    
    //数量加按钮
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _addBtn.frame = CGRectMake(KScreenW - 52*kWidthScale, 75 *kHeightScale, 22 *kWidthScale,22*kWidthScale);
    
    [_addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addBtn];
    // 数量显示
    self.numberTextField  = [YNTUITools creatTextField:CGRectMake(KScreenW-123*kWidthScale, 72*kHeightScale, 66*kWidthScale, 22*kHeightScale) bgColor:nil borderStyle:UITextBorderStyleNone placeHolder:nil keyboardType:UIKeyboardTypeNumberPad font:14*kHeightScale secureTextEntry:NO clearButtonMode:UITextFieldViewModeWhileEditing];
    _numberTextField.textAlignment =NSTextAlignmentCenter;
    _numberTextField.text = @"0";
    [self addSubview:_numberTextField];
    
    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame =  CGRectMake(KScreenW - 141*kWidthScale, 75*kHeightScale,22*kWidthScale,22*kHeightScale);
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self  addSubview:cutBtn];
    
    // 监听变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledChange:) name:UITextFieldTextDidChangeNotification object:self.numberTextField];
    
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, KScreenW,30)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(KScreenW - 60, 7,50, 20)];
    [button addTarget:self action:@selector(confrimBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"完成"forState:UIControlStateNormal];
    [button setTitleColor:CGRBlue forState:UIControlStateNormal];
    [bar addSubview:button];
    _numberTextField.inputAccessoryView = bar;
    [self addSubview:self.numberTextField];
    

    
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
        self.confirmBtnBlock();
    }
    //  NSLog(@"点击的是键盘上的完成按钮");
    [UIView animateWithDuration:0.3 animations:^{
        [self endEditing:YES];
    }];
    
    
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
    if (textNumber <0) {
        return;
    }
    self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)textNumber];
    if (self.cutBtnBloock) {
        self.cutBtnBloock(self.numberTextField.text);
    }
    
}

#pragma mark - 旋转按钮
- (void)roateBtnAction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
       //   NSLog(@"点击的是展开");
        if (self.roateSectionBtn) {
            self.roateSectionBtn(YES);
            [sender setBackgroundImage:[UIImage imageNamed:@"arrow_after"] forState:UIControlStateNormal];
        }
        
    }else{
    //NSLog(@"点击的是关闭");
        if (self.roateSectionBtn) {
            self.roateSectionBtn(NO);
            [sender setBackgroundImage:[UIImage imageNamed:@"arrow_bofore"] forState:UIControlStateNormal];
        }

        
        
    }
    


}
//#pragma mark - 选中按钮的点击事件
- (void)btnAction:(UIButton *)sender
{
   
    if (self.selcetBtnIsSelect) {
        [sender setBackgroundImage:[UIImage imageNamed:@"order_unchecked"] forState:UIControlStateNormal];
        self.selcetBtnIsSelect = NO;
        if (self.shopSectionBtn) {
            self.shopSectionBtn(0);
        }


          }else{
              [sender setBackgroundImage:[UIImage imageNamed:@"order_checked"] forState:UIControlStateNormal];
              self.selcetBtnIsSelect = YES;
              if (self.shopSectionBtn) {
                  self.shopSectionBtn(1);
              }


           }
    
      // NSLog(@"点击的是选中按钮");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
