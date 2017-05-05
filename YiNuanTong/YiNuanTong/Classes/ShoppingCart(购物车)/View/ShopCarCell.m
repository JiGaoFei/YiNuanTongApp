//
//  ShopCarCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/17.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "ShopCarCell.h"
#import "YNTUITools.h"
#import "UIImageView+WebCache.h"
@implementation ShopCarCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        
        // 创建子视图
        [self setUpChildrenViews];
    }
    return self;
}
/**
 *创建子视图
 */
- (void)setUpChildrenViews
{
    // 创建imageView
    self.shopImageView = [YNTUITools createImageView:CGRectMake(9*kWidthScale, 15*kHeightScale, 100*kWidthScale, 93*kHeightScale) bgColor:nil imageName:@"女1"];
    [self.contentView  addSubview:self.shopImageView];
    // 创建产品lab
    self.nameLabel = [YNTUITools createLabel:CGRectMake(135*kWidthScale, 15*kHeightScale, 240*kWidthScale, 40*kHeightScale) text:@"凯萨-PPR-φ25  等径三通" textAlignment:NSTextAlignmentLeft textColor:nil bgColor:nil font:16 *kHeightScale];
    self.nameLabel.numberOfLines = 0;
    [self.contentView addSubview:self.nameLabel];
    // 创建编号lab
    self.shopNumberLabel = [YNTUITools createLabel:CGRectMake(135*kWidthScale, 56*kHeightScale, 200*kWidthScale, 12*kHeightScale) text:@"1NT_000423" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:12 *kHeightScale];
    
    [self.contentView addSubview:self.shopNumberLabel];
    
 
    
    // 创建规格lab
    self.sizeLabel = [YNTUITools createLabel:CGRectMake(135 *kWidthScale, 73 *kHeightScale, 200 *kWidthScale, 16 *kHeightScale) text:@"规格：φ25" textAlignment:NSTextAlignmentLeft textColor:CGRGray bgColor:nil font:16 *kHeightScale];
    [self.contentView addSubview:self.sizeLabel];
    
    // 创建价格lab
    self.priceLabel= [YNTUITools createLabel:CGRectMake(135*kWidthScale, 91 *kHeightScale, 200*kWidthScale, 17*kHeightScale) text:@"100" textAlignment:NSTextAlignmentLeft textColor:[UIColor redColor]bgColor:nil font:17 *kHeightScale];
   
    [self.contentView addSubview:self.priceLabel];
    
    
    //选中按钮
    self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectBtn.selected = self.isSelected;
    self.selectBtn.frame = CGRectMake(16 *kWidthScale, 135*kHeightScale, 65 *kPlus*kWidthScale, 65 *kPlus *kHeightScale);
    [self.selectBtn setImage:[UIImage imageNamed:@"圆圈"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"勾选a"] forState:UIControlStateSelected];
    [self.selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectBtn];
    
    // 删除按钮
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBtn.frame =  CGRectMake(70*kWidthScale, 135*kHeightScale, 65 *kPlus *kWidthScale, 65 *kPlus *kHeightScale);
    [self.deleteBtn setImage:[UIImage imageNamed:@"删除按钮"] forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView  addSubview:self.deleteBtn];
    
// 创建加减背景
    UIImageView *addImgView = [YNTUITools createImageView:CGRectMake(160 *kWidthScale, 135*kHeightScale, 368 *kPlus *kWidthScale, 68*kPlus*kHeightScale) bgColor:nil imageName:@"添加"];
    addImgView.userInteractionEnabled = YES;
    [self.contentView addSubview:addImgView];
    
    
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       addBtn.frame = CGRectMake(305 *kWidthScale, 135*kHeightScale, 36 *kWidthScale,68 *kPlus *kHeightScale);
    [addBtn setImage:[UIImage imageNamed:@"右加"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:addBtn];
    
    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cutBtn.frame =  CGRectMake(160 *kWidthScale, 135*kHeightScale,36 *kWidthScale,68 *kPlus *kHeightScale);
    [cutBtn setImage:[UIImage imageNamed:@"添加左减"] forState:UIControlStateNormal];
    [cutBtn addTarget:self action:@selector(cutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView  addSubview:cutBtn];
    


    self.numberTextField = [YNTUITools creatTextField:CGRectMake(195*kWidthScale, 135*kHeightScale, 110 *kWidthScale, 68 *kPlus *kHeightScale) bgColor:nil borderStyle:UITextBorderStyleNone placeHolder:nil keyboardType:UIKeyboardTypePhonePad font:17*kHeightScale secureTextEntry:NO clearButtonMode:UITextFieldViewModeNever];
    self.numberTextField.text = @"1";
    self.numberTextField.textAlignment = NSTextAlignmentCenter;
   
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
#pragma mark - 完成点击事件
- (void)confrimBtnAction:(UIButton *)sender
{
    if (self.confirmBtnBlock) {
        self.confirmBtnBlock();
    }
   //  NSLog(@"点击的是键盘上的完成按钮");
    [UIView animateWithDuration:0.3 animations:^{
            [self.contentView endEditing:YES];
    }];
    
    

}

#pragma mark - 监听文字的改变
- (void)textFiledChange:(UITextField *)sender
{
    NSLog(@"%@",self.numberTextField.text);
    if (self.numberTextFiledInputText) {
        self.numberTextFiledInputText(self.numberTextField.text);
    }
}
#pragma mark - 删除按钮的点击事件
- (void)deleteBtnAction:(UIButton *)sender
{
    NSLog(@"我是删除按钮");
    if (self.deleteBtnBlock) {
        self.deleteBtnBlock();
    }
}
#pragma mark - 赋值
- (void)setDataWithModel:(ShopCartModel *)model
{
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.nameLabel.text = model.name;
    self.shopNumberLabel.text =model.psn;

    self.priceLabel.text = model.saleprice;
   //  self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)model.buynum];
     self.numberTextField.text = [NSString stringWithFormat:@"%ld",(long)model.buynum];
    self.sizeLabel.text = model.size;
    self.selectBtn.selected = self.isSelected;


}
#pragma mark - 选中按钮的点击事件
- (void)selectBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (self.carBlock) {
        self.carBlock(sender.selected);
    }

    NSLog(@"我已经被选中");
}

// 数量加按钮
-(void)addBtnClick
{
    if (self.numberAddBlock) {
        self.numberAddBlock();
    }
}

//数量减按钮
-(void)cutBtnClick
{
    if (self.numberCuttBlock) {
        self.numberCuttBlock();
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
