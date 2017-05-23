//
//  GFChooseOneViewCell.m
//  YiNuanTong
//
//  Created by 1暖通商城 on 2017/4/21.
//  Copyright © 2017年 纪高飞. All rights reserved.
//

#import "GFChooseOneViewCell.h"
#import "YNTUITools.h"
#import "HomeShopListSizeModel.h"
#import "GoodDetailAttrtypeModel.h"

@interface GFChooseOneViewCell ()
@property (nonatomic,assign)BOOL isStopAdd;
@end
@implementation GFChooseOneViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.isStopAdd = NO;
        //  创建视图
        [self setUpChildrenView];
        
    }
    return self;
}
- (void)setUpChildrenView
{
    
    self.shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale, 10 *kHeightScale, KScreenW -  135 *kWidthScale , 16 *kHeightScale)];
    self.shopNameLabel.font = [UIFont systemFontOfSize:16*kHeightScale];
    self.shopNameLabel.text = @"颜色:亚光粉红;进出口方式:上进下出;口径:4分;中心距:60;术数:30";
    [self.contentView addSubview:self.shopNameLabel];
    
    self.shopPriceLabel =[[UILabel alloc]initWithFrame:CGRectMake(15 *kWidthScale, 39 *kHeightScale, 200 *kWidthScale , 14 *kHeightScale)];
    self.shopPriceLabel.font = [UIFont systemFontOfSize:14*kHeightScale];
    self.shopPriceLabel.text = @"99.99元/个";
    self.shopPriceLabel.textColor = RGBA(178, 178, 178, 1);
    [self.contentView addSubview:self.shopPriceLabel];
    
    
    
    
    // 创建加减背景
    UIImageView *addImgView = [YNTUITools createImageView:CGRectMake(KScreenW - 127*kWidthScale, 10 *kHeightScale, 112*kWidthScale, 24*kHeightScale) bgColor:nil imageName:@"number_frame"];
    addImgView.userInteractionEnabled = YES;
    [self.contentView addSubview:addImgView];
    
    
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(KScreenW - 37*kWidthScale, 11 *kHeightScale, 22 *kWidthScale,22*kWidthScale);
 
    
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addBtn];
    // 数量显示
    self.numberTextField  = [YNTUITools creatTextField:CGRectMake(KScreenW-103*kWidthScale, 11*kHeightScale, 66*kWidthScale, 22*kHeightScale) bgColor:nil borderStyle:UITextBorderStyleNone placeHolder:nil keyboardType:UIKeyboardTypeNumberPad font:14*kHeightScale secureTextEntry:NO clearButtonMode:UITextFieldViewModeWhileEditing];
    _numberTextField.textAlignment =NSTextAlignmentCenter;

    _numberTextField.text = @"0";
    [self.contentView addSubview:_numberTextField];
    
    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame =  CGRectMake(KScreenW - 125*kWidthScale, 11*kHeightScale,22*kWidthScale,22*kHeightScale);

    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView  addSubview:cutBtn];
    
    
    
    // 创建库存数量
    self.stockNumLab =[[UILabel alloc]initWithFrame:CGRectMake(250 *kWidthScale, 39 *kHeightScale, 100 *kWidthScale , 14 *kHeightScale)];
    self.stockNumLab.font = [UIFont systemFontOfSize:14*kHeightScale];
    self.stockNumLab.text = @"库存:999";
    self.stockNumLab.textColor = RGBA(178, 178, 178, 1);
    [self.contentView addSubview:self.stockNumLab];

    
    
    
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
    
    
    
    // 监听是否停止加
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopAdd:) name:@"addStop" object:nil];
    
    
}
#pragma mark - 监听是否是停止 
- (void)stopAdd:(NSNotification *)userInfo
{
    NSString *str = [userInfo.userInfo objectForKey:@"addStop"];
    NSLog(@"%@",str);
    if ([str isEqualToString:@"1"]) {
        self.isStopAdd = YES;
    }
    if ([str isEqualToString:@"0"]) {
          self.isStopAdd = NO;
    }
    
    
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
    
    if (self.isStopAdd) {
        
    }else{
        NSInteger textNumber = [self.numberTextField.text integerValue];
        textNumber +=1 ;
        self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)textNumber];
        
        if (self.addBtnBloock) {
            self.addBtnBloock(self.numberTextField.text);
        }
        
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
#pragma mark - 赋值
- (void)setValueWithModel:(HomeShopListSizeModel *)model andWithAttryModel:(GoodDetailAttrtypeModel *)attrModle
{
    self.shopNameLabel.text = [NSString stringWithFormat:@"%@%@",attrModle.name,model.name];
    self.shopPriceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.stockNumLab.text = [NSString stringWithFormat:@"库存:%@",model.stock];
    self.numberTextField.text = [NSString stringWithFormat:@"%@",model.num];

}
- (void)setValueWithModel:(HomeShopListSizeModel *)model
{
    self.shopNameLabel.text = model.name;
    self.shopPriceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.stockNumLab.text = [NSString stringWithFormat:@"库存:%@",model.stock];
    self.numberTextField.text = [NSString stringWithFormat:@"%@",model.num];
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
