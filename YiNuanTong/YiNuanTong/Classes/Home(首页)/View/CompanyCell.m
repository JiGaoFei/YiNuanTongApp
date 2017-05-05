//
//  CompanyCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/13.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "CompanyCell.h"



@interface CompanyCell ()<UITextFieldDelegate>

@end
@implementation CompanyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpChildrenViews];
        [self.textFiled addTarget:self action:@selector(cellTextFieldChange:forIndexPath:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;

}

// 创建子视图
- (void)setUpChildrenViews
{
    self.textFiled = [[UITextField alloc]initWithFrame:CGRectMake(20*kWidthScale, 0, KScreenW -40*kWidthScale, 40*kHeightScale)];
    
    self.textFiled.delegate = self;
    [self addSubview:self.textFiled];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
#pragma mark - textFiled代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark  - 代理方法
- (void)cellTextFieldChange:(NSString *)str  forIndexPath:(NSIndexPath *)indexPath
{
    // 调用代理方法,告诉代理,哪一行的文本属性了改变
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellTextFieldChange:forIndexPath:)]) {
        [self.delegate cellTextFieldChange:self.textFiled.text forIndexPath:indexPath];
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
