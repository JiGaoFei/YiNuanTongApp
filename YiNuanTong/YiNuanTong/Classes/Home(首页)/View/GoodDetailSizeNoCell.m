//
//  GoodDetailSizeNoCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GoodDetailSizeNoCell.h"
#import "YNTUITools.h"
@implementation GoodDetailSizeNoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 加载视图
        [self setUpChildrenViews];
    }
    return self;
}
// 加载视图
- (void)setUpChildrenViews
{
    UILabel *sizeLab = [YNTUITools createLabel:CGRectMake(15 *kWidthScale, 15 *kHeightScale, 80 *kWidthScale, 15 *kHeightScale) text:@"订购数量:" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:15 *kHeightScale];

    
    
    // 创建加减背景
    UIImageView *addImgView = [YNTUITools createImageView:CGRectMake(120*kWidthScale, 10 *kHeightScale, 112*kWidthScale, 24*kHeightScale) bgColor:nil imageName:@"number_frame"];
    addImgView.userInteractionEnabled = YES;
    [self.contentView addSubview:addImgView];
    
    
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(208*kWidthScale, 10 *kHeightScale, 22 *kWidthScale,22*kWidthScale);
    
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addBtn];
    // 数量显示
    self.numberTextField  = [YNTUITools creatTextField:CGRectMake(142*kWidthScale, 10*kHeightScale, 66*kWidthScale, 22*kHeightScale) bgColor:nil borderStyle:UITextBorderStyleNone placeHolder:nil keyboardType:UIKeyboardTypeNumberPad font:14*kHeightScale secureTextEntry:NO clearButtonMode:UITextFieldViewModeWhileEditing];
    _numberTextField.textAlignment =NSTextAlignmentCenter;
    _numberTextField.text = @"1";
    [self.contentView addSubview:_numberTextField];
    
    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame =  CGRectMake(120*kWidthScale, 10*kHeightScale,22*kWidthScale,22*kHeightScale);
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView  addSubview:cutBtn];
    
    
    // 总金额
    self.totallMoneyLab =[[UILabel alloc]initWithFrame:CGRectMake(250*kWidthScale, 10*kHeightScale,KScreenW - 250 *kWidthScale,20*kHeightScale)];
    self.totallMoneyLab.textColor = [UIColor redColor];
    [self addSubview:_totallMoneyLab];
    
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

    
    
    
    UILabel *lineLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 45 *kHeightScale, KScreenW, 10*kHeightScale)];
    lineLab.backgroundColor = RGBA(245, 246, 247, 1);
    
    
    
    [self.contentView addSubview:lineLab];
    
    [self.contentView addSubview:sizeLab];
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
        self.confirmBtnBlock(self.numberTextField.text);
    }
    //  NSLog(@"点击的是键盘上的完成按钮");
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView endEditing:YES];
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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
