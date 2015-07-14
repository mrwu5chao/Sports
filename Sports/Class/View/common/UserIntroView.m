//
//  BaseViewController.h
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "UserIntroView.h"

#define SELF_FRAME  self.frame
#define WIDTH       self.frame.size.width
#define HEIGHT      self.frame.size.height
#define IMG_NUM 5
#define IMG_NAME @"appIntroduce_%d.jpg"
#define GuideVersion @"GuideVersion"

@implementation UserIntroView
// 当需要显示才显示
+ (void)showWhileVersionChange {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:GuideVersion] isEqualToString:version] == NO) {
        [[NSUserDefaults standardUserDefaults] setObject:version forKey:GuideVersion];
        UserIntroView *guideView = [[UserIntroView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] addSubview:guideView];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initGuide];
    }
    return self;
}

- (void)initGuide
{
    //255,145,0
   // self.backgroundColor = [UIColor colorWithRed:225.0f/255.0f green:145.0f/255.0f blue:0.0/255.0f alpha:1.0];
    
    CGRect rect = SELF_FRAME;
    CGFloat width = WIDTH;
    CGFloat height = HEIGHT;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    [_scrollView setContentSize:CGSizeMake(width*IMG_NUM, 0)];
    [_scrollView setDelegate:self];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];//隐藏水平滚动条
    [_scrollView setPagingEnabled:YES];  //视图整页显示
    [_scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    _scrollView.backgroundColor = [UIColor clearColor];
    
    
    for (int i=0; i<IMG_NUM; i++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:IMG_NAME,i+1]];
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(i*width, 0, width,HEIGHT )];
        
        imageview.backgroundColor = [UIColor clearColor];
        
        [imageview setImage:image];
        //imageview.contentMode = UIViewContentModeTop;
        
        [_scrollView addSubview:imageview];

        
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview5上加载一个透明的button
        [_skipBtn setTitle:nil forState:UIControlStateNormal];
        [_skipBtn setFrame:CGRectMake(100+width*4, height-200, 120, 37)];
        [_skipBtn setBackgroundColor:[UIColor clearColor]];
        [_skipBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [_skipBtn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:_skipBtn];
        //_skipBtn.hidden = YES;
        
    }
    self.backgroundColor = [UIColor cyanColor];
    [self addSubview:_scrollView];
    //[scrollView release];
    
    //页面控制小工具
    //它会在底部绘制小圆点标志当前显示页面
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height-30,width, 20)];
    //设置页面的数量
    [_pageControl setNumberOfPages:3];
   // [self addSubview:_pageControl];
    
    //NSLog(@"%@",NSStringFromCGRect(button.frame));
    
    
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
   
    _pageControl.currentPage = page;
    NSLog(@"page = %d",page);
    
    if (page==IMG_NUM-1) {
        scrollView.bounces = YES;
        scrollView.contentSize = CGSizeMake(WIDTH*IMG_NUM, 0);
        
    }
    else {
        scrollView.bounces = NO;
  }
    NSLog(@"%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x>(IMG_NUM-1)*WIDTH) {
        [self gotoNext];
         [self removeFromSuperview];
    }
}
#pragma mark --进入主界面
- (void)gotoNext{
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(goToHomeController)]) {
        [self.delegate goToHomeController];
    }
}

- (void)removeView {
    [self removeFromSuperview];
    [self gotoNext];
}
@end
