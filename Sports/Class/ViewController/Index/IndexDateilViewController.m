//
//  IndexDateilViewController.m
//  Sports
//
//  Created by 吴超 on 15/7/6.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "IndexDateilViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "ChatViewController.h"

#define FACE_NAME_LEN   5
#define FACE_NAME_HEAD  @"/s"

@interface IndexDateilViewController ()<UMSocialUIDelegate,UITextViewDelegate>
{
    
    __weak IBOutlet UIView *_mainView;
    __weak IBOutlet UIView *_bottomView;
    __weak IBOutlet UITextView *_bottomTextView;
    __weak IBOutlet UIButton *_collectionBtn;
    CGFloat _keyboardHeight;
    __weak IBOutlet UIView *_informationView;
    UILabel *_placeholder;
}

@end

@implementation IndexDateilViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationTopBar.titleLabel setText:@"详情"];
    [self.navigationTopBar.rightButton setImage:[UIImage imageNamed:@"share-50"] forState:UIControlStateNormal];
    [_mainView setFrame:CGRectMake(0, self.navigationTopBar.bottom, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT -self.navigationTopBar.bottom)];
    [self textViewDidChange:_bottomTextView];
    [_bottomTextView.layer setBorderColor:DEFAULT_BG_COLOR.CGColor];
    [_bottomTextView.layer setBorderWidth:1];
    [_bottomTextView.layer setCornerRadius:3];
    _placeholder = [[UILabel alloc]initWithFrame:CGRectMake(3, 6, 200, 20)];
    _placeholder.enabled = NO;
    _placeholder.text = @"请输入你的评论";
    _placeholder.font =  [UIFont systemFontOfSize:14];
    _placeholder.textColor = [UIColor lightGrayColor];
    [_bottomTextView addSubview:_placeholder];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPresson)];
    [_informationView addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Click
- (void)dismissKeyBoard {
    [self resignFirstResponder];
}
- (void)leftPresson {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightPresson {
    // 分享
    [UMSocialWechatHandler setWXAppId:@"wx5f30954ce29efd95" appSecret:@"ae9afb34b7bf819f27016598a21bc131" url:@"http://www.baidu.com"];
    [UMSocialQQHandler setQQWithAppId:@"1102903292" appKey:@"Gaciv5ZRyozZ6Sbn" url:@"http://www.baidu.com"];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:@"rrrrrrr"
                                     shareImage:[UIImage imageNamed:@"Icon-120"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToQzone,UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,nil]
                                       delegate:nil];
}
// 聊天
- (IBAction)chatPresson:(id)sender {
    __weak IndexDateilViewController *weakSelf = self;

    ChatViewController *chatVC = [[ChatViewController alloc] initWithChatter:@"13556801874" isGroup:NO];
    [chatVC setTitle:@"13556801874"];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatVC];
//    [self presentViewController:chatVC animated:YES completion:nil];
    [weakSelf.navigationController pushViewController:chatVC animated:YES];
}

- (void)tapPresson {
    [self resignFirstResponder];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.view == self.view || touch.view == _mainView || touch.view == _informationView) {
        [self resignFirstResponder];
    }
}
- (BOOL)resignFirstResponder {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES]; //关闭键盘
    return [super resignFirstResponder];
}

#pragma mark -键盘
- (void)keyboardWillShow:(NSNotification *)notification {
    
//    isKeyboardShowing = YES;
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = _mainView.frame;

                         frame = _bottomView.frame;
                         frame.origin.y += _keyboardHeight;
                         frame.origin.y -= keyboardRect.size.height;
                         _bottomView.frame = frame;
                         
                         _keyboardHeight = keyboardRect.size.height;
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = _mainView.frame;
                         
                         frame = _bottomView.frame;
                         frame.origin.y += _keyboardHeight;
                         _bottomView.frame = frame;
                         
                         _keyboardHeight = 0;
                     }];
}


#pragma mark -UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {//按下return键
        //这里隐藏键盘，不做任何处理
        [textView resignFirstResponder];
        return NO;
    }

    //点击了非删除键
    if( [text length] == 0 ) {
        
        if ( range.length > 1 ) {
            
            return YES;
        }
        else {
            
            [self backFace];
            
            return NO;
        }
    }
    else {
        
        return YES;
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text length] == 0) {
        [_placeholder setHidden:NO];
    }else{
        [_placeholder setHidden:YES];
    }
    CGSize size = _bottomTextView.contentSize;
    size.height -= 2;
    if ( size.height >= 68 ) {
        
        size.height = 68;
    }
    else if ( size.height <= 32 ) {
        
        size.height = 32;
    }
    
    if ( size.height != _bottomTextView.frame.size.height ) {
        
        CGFloat span = size.height - _bottomTextView.frame.size.height;
        
        CGRect frame = _bottomView.frame;
        frame.origin.y -= span;
        frame.size.height += span;
        _bottomView.frame = frame;
        
        CGFloat centerY = frame.size.height / 2;
        
        frame = _bottomTextView.frame;
        frame.size = size;
        _bottomTextView.frame = frame;
        
        CGPoint center = _bottomTextView.center;
        center.y = centerY;
        _bottomTextView.center = center;
        
        center = _collectionBtn.center;
        center.y = centerY;
        _collectionBtn.center = center;
    }
}

- (void)backFace{
    
    NSString *inputString;
    inputString = _bottomTextView.text;
    if ( _bottomTextView ) {
        
        inputString = _bottomTextView.text;
    }
    
    if ( inputString.length ) {
        
        NSString *string = nil;
        NSInteger stringLength = inputString.length;
        if ( stringLength >= FACE_NAME_LEN ) {
            
            string = [inputString substringFromIndex:stringLength - FACE_NAME_LEN];
            NSRange range = [string rangeOfString:FACE_NAME_HEAD];
            if ( range.location == 0 ) {
                
                string = [inputString substringToIndex:
                          [inputString rangeOfString:FACE_NAME_HEAD
                                             options:NSBackwardsSearch].location];
            }
            else {
                
                string = [inputString substringToIndex:stringLength - 1];
            }
        }
        else {
            
            string = [inputString substringToIndex:stringLength - 1];
        }
        
        if ( _bottomTextView ) {
            
            _bottomTextView.text = string;
        }
        
        if ( _bottomTextView ) {
            
            _bottomTextView.text = string;
            
            [self textViewDidChange:_bottomTextView];
        }
    }
}

@end
