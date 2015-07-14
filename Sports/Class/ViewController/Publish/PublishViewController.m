//
//  PublishViewController.m
//  Sports
//
//  Created by 吴超 on 15/7/5.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "PublishViewController.h"
#import "PublishCollectView.h"
#import "UniversityViewController.h"
#import "YDDatePicker.h"
#import "YDBmobObject.h"
#import <BmobSDK/BmobUser.h>
@interface PublishViewController ()<SeceletCellDelegate,UITextFieldDelegate,YDDatePickerDelegate>
{
    
    __weak IBOutlet UIView *_mainView;
    UIScrollView *_mainScrollView;
    __weak IBOutlet UIView *_typeView;
    __weak IBOutlet UIButton *_publishBtn;
    
    __weak IBOutlet UITextField *_schoolText;
    __weak IBOutlet UITextField *_siteText;
    
    __weak IBOutlet UITextField *_timerText;
    
    __weak IBOutlet UITextField *_peopleText;
    __weak IBOutlet UITextView *_contentTextView;
    __weak IBOutlet UILabel *_typeLabel;
    YDDatePicker *_datePicker;
    NSMutableArray *_typeArray;
    NSInteger _typeID;
}
@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationTopBar.titleLabel setText:@"发布"];
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navigationTopBar.bottom, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.navigationTopBar.bottom)];
    [_mainScrollView setContentSize:CGSizeMake(UI_SCREEN_WIDTH, _publishBtn.bottom +10)];
    [_mainScrollView setBackgroundColor:UIColorFromRGB(230, 230, 230)];
    [self.view addSubview:_mainScrollView];
    
    [_mainView setFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.navigationTopBar.bottom)];
    [_mainScrollView addSubview:_mainView];
    
    PublishCollectView *publishCollectView=[[[NSBundle mainBundle]loadNibNamed:@"PublishCollectView" owner:nil options:nil]firstObject];
    publishCollectView.frame=CGRectMake(0, 0, UI_SCREEN_WIDTH, 72);
    [_typeView addSubview:publishCollectView];
    publishCollectView.delegate=self;
    _typeArray = [[NSMutableArray alloc] init];
    [_typeArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"frisbee-75",@"image",@"羽毛球",@"typeName",nil]];
    [_typeArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"football2-75",@"image",@"足球",@"typeName",nil]];
    [_typeArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"running-75",@"image",@"跑步",@"typeName",nil]];
    [_typeArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"trekking-75",@"image",@"登山",@"typeName", nil]];
    [_typeArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"frisbee-75",@"image",@"羽毛球",@"typeName", nil]];
    [_typeArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"football2-75",@"image",@"足球",@"typeName", nil]];
    [_typeArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"running-75",@"image",@"跑步",@"typeName",nil]];
    [_typeArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"trekking-75",@"image",@"登山",@"typeName", nil]];

    [publishCollectView setCollecetArray:_typeArray];
    _datePicker=[[YDDatePicker alloc] initWithSelectViewOfDelegate:self.view delegate:self];
    BmobUser *user = [BmobUser getCurrentUser];
    [_schoolText setText:[user objectForKey:@"schoolName"]];
    [_contentTextView.layer setBorderWidth:1];
    [_contentTextView.layer setBorderColor:UIColorFromRGB(230, 230, 230).CGColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -Click

// 选择学校
- (IBAction)selectSchoolPresson:(id)sender {
    UniversityViewController *university = [[UniversityViewController alloc] init];
    university.selectSchool = ^(NSString *schoolName) {
        [_schoolText setText:schoolName];
    };
    [self.navigationController pushViewController:university animated:YES];

}

// 选择运动时间
- (IBAction)selectSportsTimer:(id)sender {
    [_datePicker pushDatePicker];

}
// 发布
- (IBAction)publishPresson:(id)sender {
    [[AppDelegate defaultAppDelegate] showLoading:@"正在提交..."];
    [YDBmobObject YDSaveWithTypeID:_typeLabel.text SchoolName:_schoolText.text Site:_siteText.text Timer:_timerText.text PeopleNum:_peopleText.text Content:_contentTextView.text Block:^(BOOL isSuccessful, NSError *error) {
        [[AppDelegate defaultAppDelegate] hiddenLoading];
    }];
}
# pragma mark -YDDatePickerDelegate
//回调，字符串可自行进行截取
-(void)YDDatePickerDidConfirm:(NSString *)confirmString{
    
    [_timerText setText:[confirmString substringToIndex:16]];
}

# pragma mark -SeceletCellDelegate
-(void)secletCellIndex:(NSInteger)index andIsSeclect:(BOOL)isSeclect {
    [_typeLabel setText:[[_typeArray objectAtIndex:index] objectForKey:@"typeName"]];
}

# pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self resignFirstResponder];
    if (textField == _siteText || textField == _timerText) {
        [UIView animateWithDuration:0.2 animations:^{
            [_mainView setTop:0];
        }];
    }

    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _schoolText || textField == _timerText) {
        [self resignFirstResponder];
    }
    if (textField != _timerText) {
        [_datePicker popDatePicker];
    }
    if (textField == _siteText || textField == _timerText) {
        [UIView animateWithDuration:0.2 animations:^{
            [_mainView setTop:-100];
        }];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _timerText || textField == _schoolText) {
        [self resignFirstResponder];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view || touch.view == _mainView || touch.view == _mainScrollView) {
        [self resignFirstResponder];
    }
}
- (BOOL)resignFirstResponder {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES]; //关闭键盘
    return [super resignFirstResponder];
}

@end
