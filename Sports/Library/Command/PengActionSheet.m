//
//  PengActionSheet.m
//  Peng
//
//  Created by huihenduo on 14-9-30.
//  Copyright (c) 2014年 wuchao. All rights reserved.
//

#import "PengActionSheet.h"
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]

#define BUTTON_INTERVAL_HEIGHT                  10
#define BUTTON_HEIGHT                           40
#define BUTTON_INTERVAL_WIDTH                   20
#define BUTTON_WIDTH                            260
#define BUTTONTITLE_FONT                        [UIFont systemFontOfSize:17]
#define BUTTON_BORDER_WIDTH                     0.5f
#define BUTTON_BORDER_COLOR                     [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8].CGColor


#define TITLE_INTERVAL_HEIGHT                   15
#define TITLE_HEIGHT                            35
#define TITLE_INTERVAL_WIDTH                    20
#define TITLE_WIDTH                             260
#define TITLE_FONT                              [UIFont systemFontOfSize:17]
#define SHADOW_OFFSET                           CGSizeMake(0, 0.8f)
#define TITLE_NUMBER_LINES                      2

#define ANIMATE_DURATION                        0.25f

@interface PengActionSheet ()

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) NSString *actionTitle;
@property (nonatomic,assign) NSInteger postionIndexNumber;
@property (nonatomic,assign) BOOL isHadTitle;
@property (nonatomic,assign) BOOL isHadDestructionButton;
@property (nonatomic,assign) BOOL isHadOtherButton;
@property (nonatomic,assign) BOOL isHadCancelButton;
@property (nonatomic,assign) CGFloat LXActionSheetHeight;
@property (nonatomic,assign) id<PengActionSheetDelegate>delegate;

@end

@implementation PengActionSheet

#pragma mark - Public method

-(id)initWithTitle:(NSString *)title delegate:(id<PengActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles,...{
    
    self = [super init];
    if (self) {
        
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        if (delegate) {
            self.delegate = delegate;
        }
        
        NSMutableArray*otherButtonTitlesArray=[NSMutableArray array];
        
        va_list arguments;
        
        id eachObject;
        
        if (otherButtonTitles) {
            
//            NSLog(@"%@",otherButtonTitles);
            [otherButtonTitlesArray addObject:otherButtonTitles];
            va_start(arguments,otherButtonTitles);
            
            while ((eachObject = va_arg(arguments, id))) {
                
//                NSLog(@"%@",eachObject);
                [otherButtonTitlesArray addObject:eachObject];
            }
            
            va_end(arguments);
            
        NSMutableArray*otherButtonTitlesArray=nil;
        if (otherButtonTitles) {
            
            otherButtonTitlesArray=[NSMutableArray array];
            
            va_list arguments;
            id eachObject;
            if (otherButtonTitles) {
                
//                NSLog(@"%@",otherButtonTitles);
                [otherButtonTitlesArray addObject:otherButtonTitles];
                
                va_start(arguments, otherButtonTitles);
                
                while ((eachObject = va_arg(arguments, id))) {
                    
//                    NSLog(@"%@",eachObject);
                    [otherButtonTitlesArray addObject:eachObject];
                }
                
                va_end(arguments);
                
            }
            
        }
        
        [self creatButtonsWithTitle:title cancelButtonTitle:cancelButtonTitle destructionButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitlesArray];
        }
    }
    return self;
    
}

- (void)showInView:(UIView *)view
{
//    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    [[UIApplication sharedApplication].delegate.window bringSubviewToFront:self];
}

#pragma mark - CreatButtonAndTitle method

- (void)creatButtonsWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructionButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray
{
    //初始化
    self.isHadTitle = NO;
    self.isHadDestructionButton = NO;
    self.isHadOtherButton = NO;
    self.isHadCancelButton = NO;
    
    //初始化LXACtionView的高度为0
    self.LXActionSheetHeight = 0;
    
    //初始化IndexNumber为0;
    self.postionIndexNumber = 0;
    
    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width -20, 0)];
    self.backGroundView.backgroundColor = [UIColor whiteColor];
    [self.backGroundView.layer setCornerRadius:7];
    //给LXActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
    
    [self addSubview:self.backGroundView];
    
    if (title) {
        self.isHadTitle = YES;
        UILabel *titleLabel = [self creatTitleLabelWith:title];
        self.LXActionSheetHeight = self.LXActionSheetHeight + 2*TITLE_INTERVAL_HEIGHT+TITLE_HEIGHT;
        [self.backGroundView addSubview:titleLabel];
    }
    
    if (destructiveButtonTitle) {
        self.isHadDestructionButton = YES;
        
        UIButton *destructiveButton = [self creatDestructiveButtonWith:destructiveButtonTitle];
        destructiveButton.tag = self.postionIndexNumber;
        [destructiveButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.isHadTitle == YES) {
            //当有title时
            [destructiveButton setFrame:CGRectMake(destructiveButton.frame.origin.x, self.LXActionSheetHeight, destructiveButton.frame.size.width, destructiveButton.frame.size.height)];
            
            if (otherButtonTitlesArray && otherButtonTitlesArray.count > 0) {
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height+BUTTON_INTERVAL_HEIGHT/2;
            }
            else{
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
            }
        }
        else{
            //当无title时
            if (otherButtonTitlesArray && otherButtonTitlesArray.count > 0) {
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT+(BUTTON_INTERVAL_HEIGHT/2));
            }
            else{
                self.LXActionSheetHeight = self.LXActionSheetHeight + destructiveButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
            }
        }
        [self.backGroundView addSubview:destructiveButton];
        
        self.postionIndexNumber++;
    }
    
    if (otherButtonTitlesArray) {
        
        if (otherButtonTitlesArray.count > 0) {
            self.isHadOtherButton = YES;
            
            //当无title与destructionButton时
            if (self.isHadTitle == NO && self.isHadDestructionButton == NO) {
                for (int i = 0; i<otherButtonTitlesArray.count; i++) {
                    UIButton *otherButton = [self creatOtherButtonWith:[otherButtonTitlesArray objectAtIndex:i] withPostion:i];
                    
                    otherButton.tag = self.postionIndexNumber;
                    [otherButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
                    
                    if (i != otherButtonTitlesArray.count - 1) {
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT/2);
                    }
                    else{
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
                    }
                    
                    [self.backGroundView addSubview:otherButton];
                    
                    self.postionIndexNumber++;
                }
            }
            
            //当有title或destructionButton时
            if (self.isHadTitle == YES || self.isHadDestructionButton == YES) {
                for (int i = 0; i<otherButtonTitlesArray.count; i++) {
                    UIButton *otherButton = [self creatOtherButtonWith:[otherButtonTitlesArray objectAtIndex:i] withPostion:i];
                    
                    otherButton.tag = self.postionIndexNumber;
                    [otherButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
                    [otherButton setFrame:CGRectMake(otherButton.frame.origin.x, self.LXActionSheetHeight, otherButton.frame.size.width, otherButton.frame.size.height)];
                    
                    if (i != otherButtonTitlesArray.count - 1) {
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT/2);
                    }
                    else{
                        self.LXActionSheetHeight = self.LXActionSheetHeight + otherButton.frame.size.height+(BUTTON_INTERVAL_HEIGHT);
                    }
                    
                    [self.backGroundView addSubview:otherButton];
                    
                    self.postionIndexNumber++;
                }
            }
        }
    }
    
    if (cancelButtonTitle) {
        self.isHadCancelButton = YES;
        
        UIButton *cancelButton = [self creatCancelButtonWith:cancelButtonTitle];
        
        cancelButton.tag = self.postionIndexNumber;
        [cancelButton addTarget:self action:@selector(clickOnButtonWith:) forControlEvents:UIControlEventTouchUpInside];
        
        //当没title destructionButton otherbuttons时
        if (self.isHadTitle == NO && self.isHadDestructionButton == NO && self.isHadOtherButton == NO) {
            self.LXActionSheetHeight = self.LXActionSheetHeight + cancelButton.frame.size.height+(2*BUTTON_INTERVAL_HEIGHT);
        }
        
        //当有title或destructionButton或otherbuttons时
        if (self.isHadTitle == YES || self.isHadDestructionButton == YES || self.isHadOtherButton == YES) {
            [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, self.LXActionSheetHeight -10, cancelButton.frame.size.width, cancelButton.frame.size.height)];
            self.LXActionSheetHeight = self.LXActionSheetHeight + cancelButton.frame.size.height+BUTTON_INTERVAL_HEIGHT;
        }
        
        [self.backGroundView addSubview:cancelButton];
        
        self.postionIndexNumber++;
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height-self.LXActionSheetHeight +10, [UIScreen mainScreen].bounds.size.width -20, self.LXActionSheetHeight - 15)];
    } completion:^(BOOL finished) {
    }];
}

- (UILabel *)creatTitleLabelWith:(NSString *)title
{
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_INTERVAL_WIDTH, TITLE_INTERVAL_HEIGHT, TITLE_WIDTH, TITLE_HEIGHT)];
    titlelabel.backgroundColor = [UIColor clearColor];
    [titlelabel setNumberOfLines:0];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.shadowColor = [UIColor blackColor];
    titlelabel.shadowOffset = SHADOW_OFFSET;
    titlelabel.font = TITLE_FONT;
    titlelabel.text = title;
    titlelabel.textColor = [UIColor colorWithRed:247/255 green:71/255 blue:71/255 alpha:1];
    titlelabel.numberOfLines = TITLE_NUMBER_LINES;
    return titlelabel;
}

- (UIButton *)creatDestructiveButtonWith:(NSString *)destructiveButtonTitle
{
    UIButton *destructiveButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
    
    destructiveButton.backgroundColor = [UIColor clearColor];
    [destructiveButton setTitle:destructiveButtonTitle forState:UIControlStateNormal];
    destructiveButton.titleLabel.font = BUTTONTITLE_FONT;
    
    [destructiveButton setTitleColor:[UIColor colorWithRed:247/255.00f green:71/255.00f blue:71/255.00f alpha:1] forState:UIControlStateNormal];
    [destructiveButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    UIView *otherView = [[UIView alloc] initWithFrame:CGRectMake(-5, destructiveButton.frame.size.height, destructiveButton.frame.size.width + 10, 0.5)];
    [otherView setBackgroundColor:[UIColor colorWithRed:193/255.00f green:193/255.00f blue:193/255.00f alpha:1]];
    [destructiveButton addSubview:otherView];
    
    return destructiveButton;
}

- (UIButton *)creatOtherButtonWith:(NSString *)otherButtonTitle withPostion:(NSInteger )postionIndex
{
    UIButton *otherButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT + (postionIndex*(BUTTON_HEIGHT+(BUTTON_INTERVAL_HEIGHT/2))), BUTTON_WIDTH, BUTTON_HEIGHT)];
    
    otherButton.backgroundColor = [UIColor clearColor];
    [otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
    otherButton.titleLabel.font = BUTTONTITLE_FONT;
    [otherButton setTitleColor:[UIColor colorWithRed:247/255.00f green:71/255.00f blue:71/255.00f alpha:1] forState:UIControlStateNormal];
    [otherButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    UIView *otherView = [[UIView alloc] initWithFrame:CGRectMake(-5, otherButton.frame.size.height, otherButton.frame.size.width + 10, 0.5)];
    [otherView setBackgroundColor:[UIColor colorWithRed:193/255.00f green:193/255.00f blue:193/255.00f alpha:1]];
    [otherButton addSubview:otherView];
    return otherButton;
}

- (UIButton *)creatCancelButtonWith:(NSString *)cancelButtonTitle
{
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_INTERVAL_WIDTH, BUTTON_INTERVAL_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
    
    cancelButton.backgroundColor = [UIColor clearColor];
    [cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.titleLabel.font = BUTTONTITLE_FONT;
    [cancelButton setTitleColor:[UIColor colorWithRed:176/255.00f green:176/255.00f blue:176/255.00f alpha:1] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    return cancelButton;
}

- (void)clickOnButtonWith:(UIButton *)button
{
    if (self.isHadDestructionButton == YES) {
        if (self.delegate) {
            if (button.tag == 0) {
                if ([self.delegate respondsToSelector:@selector(didClickOnDestructiveButton)] == YES){
                    [self.delegate didClickOnDestructiveButton];
                }
            }
        }
    }
    
    if (self.isHadCancelButton == YES) {
        if (self.delegate) {
            if (button.tag == self.postionIndexNumber-1) {
                if ([self.delegate respondsToSelector:@selector(didClickOnCancelButton)] == YES) {
                    [self.delegate didClickOnCancelButton];
                }
            }
        }
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(didClickOnButtonIndex:inActionSheet:)] == YES) {
            [self.delegate didClickOnButtonIndex:(NSInteger)button.tag inActionSheet:self];
        }
    }
    
    [self tappedCancel];
}

- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)tappedBackGroundView
{
    //
}
-(void)actionSheetAddDatePicker;
{
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode=UIDatePickerModeDate;
    [self.datePicker setFrame:CGRectMake(10, 0,280,CGRectGetHeight(self.datePicker.frame))];
    [self.backGroundView setFrame:CGRectMake(CGRectGetMinX(self.backGroundView.frame),CGRectGetMinY(self.backGroundView.frame)-CGRectGetHeight(self.datePicker.frame),CGRectGetWidth(self.backGroundView.frame), CGRectGetHeight(self.backGroundView.frame)+CGRectGetHeight(self.datePicker.frame))];
    [self.backGroundView addSubview:self.datePicker];
    
    for (UIView*subView in self.backGroundView.subviews) {
        
        if ([subView isKindOfClass:[UIButton class]]) {
            
            if ([((UIButton*)subView).titleLabel.text isEqualToString:@"确定"]) {
                
                [subView setFrame:CGRectMake(CGRectGetMinX(subView.frame), CGRectGetMinY(subView.frame)+CGRectGetHeight(self.datePicker.frame),CGRectGetWidth(subView.frame), CGRectGetHeight(subView.frame))];
                
                UILabel*lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMinY(subView.frame)-5,280,0.5)];
                [lineLabel setBackgroundColor:UIColorFromRGB(212, 212, 212)];
                [self.backGroundView addSubview:lineLabel];
                break;
            }
        }
    }
}

@end
