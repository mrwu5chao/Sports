//
//  RegisterIconViewController.m
//  Sports
//
//  Created by 吴超 on 15/6/28.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "RegisterIconViewController.h"
#import "DateProol.h"
#import "UniversityViewController.h"
#import "YDBmobUser.h"
#import "IndexViewController.h"

#import <BmobSDK/BmobProFile.h>
#import <BmobSDK/BmobUser.h>
@interface RegisterIconViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate,PengActionSheetDelegate>
{
    
    __weak IBOutlet UIView *_mainView;
    __weak IBOutlet UIScrollView *_mainScrollView;
    __weak IBOutlet UIButton *_iconBtn;
    
    __weak IBOutlet UITextField *_nameText;
    
    __weak IBOutlet UIButton *_boyBtn;
    __weak IBOutlet UIButton *_girlBtn;
    __weak IBOutlet UITextField *_ageText;
    __weak IBOutlet UITextField *_schoolText;
    NSString *_sexStr;
    NSString *_ageStr;
    NSString *_fileName;
    NSString *_iconUrl;
    UIImage *_iconImage;
}
@end

@implementation RegisterIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationTopBar.titleLabel setText:@"填写用户信息"];
    [_mainView setFrame:CGRectMake(0, self.navigationTopBar.bottom, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT - self.navigationTopBar.bottom)];
    [_boyBtn.layer setCornerRadius:18];
    [_girlBtn.layer setCornerRadius:18];
    _sexStr = @"";
    _ageStr = @"";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Click
// 上传头像
- (IBAction)pushImageAction:(id)sender {
    PengActionSheet *actionSheet = [[PengActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍一张",@"相册选择相片", nil];
    actionSheet.tag=1003;
    [actionSheet showInView:self.view];
}
// 选择性别
- (IBAction)selectSexPresson:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1001) {
        [_boyBtn setUserInteractionEnabled:NO];
        [_girlBtn setUserInteractionEnabled:YES];
        [_boyBtn setBackgroundColor:UIColorFromRGB(32, 90, 132)];
        [_girlBtn setBackgroundColor:UIColorFromRGB(230, 230, 230)];
        [_boyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_girlBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sexStr = @"男";
    } else {
        [_boyBtn setUserInteractionEnabled:YES];
        [_girlBtn setUserInteractionEnabled:NO];
        [_girlBtn setBackgroundColor:UIColorFromRGB(32, 90, 132)];
        [_boyBtn setBackgroundColor:UIColorFromRGB(230, 230, 230)];
        [_girlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_boyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _sexStr = @"女";

    }
}

// 选择年龄
- (IBAction)selectAgePresson:(id)sender {
    PengActionSheet*actionsheet =[[PengActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
    actionsheet.tag=1004;
    [actionsheet actionSheetAddDatePicker];
    [actionsheet showInView:self.view];

}

// 选择学校
- (IBAction)selectSchoolPresson:(id)sender {
    UniversityViewController *university = [[UniversityViewController alloc] init];
    university.selectSchool = ^(NSString *schoolName) {
        [_schoolText setText:schoolName];
    };
    [self.navigationController pushViewController:university animated:YES];
}

// 完成注册
- (IBAction)completePresson:(id)sender {
    if ([_iconUrl length] == 0 && _iconImage == nil) {
        [[AppDelegate defaultAppDelegate] showHint:@"请上传头像" Timer:1.5];
        return;
    }
    if ([_iconUrl length] == 0 && _iconImage != nil) {
        [[AppDelegate defaultAppDelegate] showHint:@"头像正在上传中..." Timer:1.5];
        return;
    }
    
    if ([_nameText.text length] == 0) {
        [[AppDelegate defaultAppDelegate] showHint:@"请输入姓名" Timer:1.5];
        return;
    }
    if ([_sexStr length] == 0) {
        [[AppDelegate defaultAppDelegate] showHint:@"请选择性别" Timer:1.5];
        return;
    }
    if ([_ageStr length] == 0) {
        [[AppDelegate defaultAppDelegate] showHint:@"请选择年龄" Timer:1.5];
        return;
    }
    if ([_schoolText.text length] == 0) {
        [[AppDelegate defaultAppDelegate] showHint:@"请选择学校" Timer:1.5];
        return;
    }


    [[AppDelegate defaultAppDelegate] showLoading:@"正在注册..."];
    [YDBmobUser YDRegisterWithAccount:self.mobileStr Password:self.passwordStr NickName:_nameText.text SchoolName:_schoolText.text Sex:_sexStr Age:_ageStr Mobile:self.mobileStr UserIcon:_iconUrl Filename:_fileName Blcok:^(BOOL isSuccessful, NSError *error) {
        [[AppDelegate defaultAppDelegate] hiddenLoading];
        if (isSuccessful) {
            [MBProgressHUD showSuccess:@"注册成功" toView:self.view];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
        }
    }];
}

- (void)didClickOnButtonIndex:(NSInteger)buttonIndex inActionSheet:(PengActionSheet *)actionSheet {
    if(actionSheet.tag==1003)
    {
        switch (buttonIndex) {
            case 0:
            {
                [self openCamera];
            }
                break;
            case 1:
            {
                [self openPhtotoLibrary];
            }
                break;
            default:
            {
                
            }
                break;
        }
    }else{
        NSString *oldStr = [[[actionSheet.datePicker.date description]componentsSeparatedByString:@" "]objectAtIndex:0];
        NSDateFormatter *oldFormat=[[NSDateFormatter alloc] init];
        [oldFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *oldDate=[oldFormat dateFromString:oldStr];
        
        NSDate *newDate = [NSDate date];
        
        _ageStr = oldStr;
        [_ageText setText:[NSString stringWithFormat:@"%.f岁",[DateProol calculateAgeFromDate:oldDate toDate:newDate]]];
    }

}


#pragma mark 调用相机和打开本地相册
-(void)openCamera{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //模态视图控制器
        UIImagePickerController*picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        [picker setAllowsEditing:YES];
        picker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{
        }];
    }else{
        [[AppDelegate defaultAppDelegate] showHint:@"相机调用失败" Timer:1.5];
    }
}
-(void)openPhtotoLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing=YES;
        picker.delegate=self;
        [self presentViewController:picker animated:YES completion:nil];
    } else {
        [[AppDelegate defaultAppDelegate] showHint:@"相册调用失败" Timer:1.5];

    }
}
#pragma mark 选中图片之后执行的方法和取消调用相机或相册之后执行的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    _iconImage = aImage;
    [_iconBtn setImage:aImage forState:UIControlStateNormal];
    [_iconBtn.layer setCornerRadius:_iconBtn.width / 2];
    _iconBtn.clipsToBounds = YES;
    NSData *data = UIImageJPEGRepresentation(aImage, 0.5);
    [BmobProFile uploadFileWithFilename:[self creatImageName] fileData:data block:^(BOOL isSuccessful, NSError *error, NSString *filename, NSString *url) {
        if (isSuccessful) {
            NSLog(@"name  %@   url   %@",filename,url);
            _fileName = filename;
            _iconUrl = url;
            [MBProgressHUD showSuccess:@"头像上传成功" toView:self.view];
        } else {
            [MBProgressHUD showError:@"头像上传失败" toView:self.view];
        }
        
    } progress:^(CGFloat progress) {
        NSLog(@"progress   %.2f",progress);
    }];

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)creatImageName {
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    
    NSLog(@"%@", localeDate);
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
    
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    return [NSString stringWithFormat:@"%@.jpg",timeSp];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    //推送回主页面
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _ageText || textField == _schoolText) {
        [self resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == _ageText || textField == _schoolText) {
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
