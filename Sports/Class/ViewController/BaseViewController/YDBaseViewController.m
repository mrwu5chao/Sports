//
//  YDBaseViewController.m
//  Sports
//
//  Created by 吴超 on 15/7/9.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "YDBaseViewController.h"

@interface YDBaseViewController ()

@end

@implementation YDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    self.navigationTopBar = [[NavigationTopBar alloc] init];
    [self.view addSubview:self.navigationTopBar];
    [self.navigationTopBar.leftButton addTarget:self action:@selector(leftPresson) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationTopBar.rightButton addTarget:self action:@selector(rightPresson) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Click

- (void)leftPresson {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightPresson {
    
}


@end
