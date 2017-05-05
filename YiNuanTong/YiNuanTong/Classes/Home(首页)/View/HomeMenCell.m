//
//  HomeMenCell.m
//  YiNuanTong
//
//  Created by 纪高飞 on 16/12/14.
//  Copyright © 2016年 纪高飞. All rights reserved.
//

#import "HomeMenCell.h"
#import "HomeMenBtnView.h"
#define Tag 1000


@interface HomeMenCell ()<UIScrollViewDelegate>

    {
        UIView *_backView1;
        UIView *_backView2;
        UIPageControl *_pageControl;
    }


@end
@implementation HomeMenCell

+(instancetype)cellWithTableView:(UITableView *)tableView menuArray:(NSMutableArray *)menuArray {
    static NSString *cellID = @"tangshuoqweqwqeqeqe";
    HomeMenCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[HomeMenCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID menuArray:menuArray];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier menuArray:(NSArray *)menuArray{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        _backView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 160)];
        _backView2 = [[UIView alloc]initWithFrame:CGRectMake(KScreenW, 0, KScreenW, 160)];
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 180)];
    
        scrollView.contentSize = CGSizeMake(KScreenW*2, 180);
     
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
      
        scrollView.showsHorizontalScrollIndicator = NO;
        [scrollView addSubview:_backView1];
        [scrollView addSubview:_backView2];
        [self addSubview:scrollView];
        
  
        for(int i = 0; i < 16; i++) {
            if(i < 4) {
                
                CGRect frame = CGRectMake(i*KScreenW/4, 0, KScreenW/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imagestr = [menuArray[i] objectForKey:@"image"];
                HomeMenBtnView *btnView = [[HomeMenBtnView alloc]initWithFrame:frame title:title imagestr:imagestr];
                btnView.tag = Tag + i;
                [_backView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clicktap:)];
                [btnView addGestureRecognizer:tap];
                
            } else if (i < 8) {
                
                CGRect frame = CGRectMake((i-4)*KScreenW/4, 80, KScreenW/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imagestr = [menuArray[i] objectForKey:@"image"];
                HomeMenBtnView *btnView = [[HomeMenBtnView alloc]initWithFrame:frame title:title imagestr:imagestr];
                btnView.tag = Tag + i;
                [_backView1 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clicktap:)];
                [btnView addGestureRecognizer:tap];
                
            }else if (i < 12) {
                CGRect frame = CGRectMake((i-8)*KScreenW/4, 0, KScreenW/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imagestr = [menuArray[i] objectForKey:@"image"];
                HomeMenBtnView *btnView = [[HomeMenBtnView alloc]initWithFrame:frame title:title imagestr:imagestr];
                btnView.tag = Tag + i;
                [_backView2 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clicktap:)];
                [btnView addGestureRecognizer:tap];
            } else {
                CGRect frame = CGRectMake((i-12)*KScreenW/4, 80, KScreenW/4, 80);
                NSString *title = [menuArray[i] objectForKey:@"title"];
                NSString *imagestr = [menuArray[i] objectForKey:@"image"];
                HomeMenBtnView *btnView = [[HomeMenBtnView alloc]initWithFrame:frame title:title imagestr:imagestr];
                btnView.tag = Tag + i;
                [_backView2 addSubview:btnView];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Clicktap:)];
                [btnView addGestureRecognizer:tap];
            }
        }
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(KScreenW/2-10, 160, 0, 20)];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 2;
   
        [self addSubview:_pageControl];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor greenColor]];
        [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
        
    }
    return self;
}






#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    _pageControl.currentPage = page;
}













-(void)Clicktap:(UITapGestureRecognizer *)sender{
    NSLog(@"tag:%ld",sender.view.tag);
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
