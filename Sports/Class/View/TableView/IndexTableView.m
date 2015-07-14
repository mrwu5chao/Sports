//
//  IndexTableView.m
//  Sports
//
//  Created by 吴超 on 15/7/6.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "IndexTableView.h"
#import "IndexDateilViewController.h"
#import "UIView+Addition.h"

@implementation IndexTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self!=nil) {
        
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"IndexTableViewCell";
    self.cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (self.cell == nil) {
        self.cell = [[[NSBundle mainBundle] loadNibNamed:identify owner:nil options:nil] firstObject];
        [self.cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self.cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  5;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击");
    IndexDateilViewController *dateil = [[IndexDateilViewController alloc] init] ;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:dateil];
    [self.viewcontroller presentViewController:nav animated:YES completion:nil];

}

@end
