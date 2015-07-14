//
//  PublishCollectView.m
//  Sports
//
//  Created by 吴超 on 15/7/5.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import "PublishCollectView.h"
#import "PublishCollectionViewCell.h"

@implementation PublishCollectView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
}

#pragma mark -UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"collecr   %d",self.CollecetArray.count);
    return self.CollecetArray.count;
}


- (PublishCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerClass:[PublishCollectionViewCell class] forCellWithReuseIdentifier:@"PublishCollectionViewCell"];
    PublishCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PublishCollectionViewCell" forIndexPath:indexPath];
    
    NSDictionary *dict = [self.CollecetArray objectAtIndex:indexPath.row];
    [cell.bigImagebton setImage:[UIImage imageNamed:[dict objectForKey:@"image"]] forState:UIControlStateNormal];
    [cell.bigImagebton setTag:indexPath.row+300];
    [cell.bigImagebton addTarget:self action:@selector(clickSeclect:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)clickSeclect:(UIButton*)bton{
    
//    
    [self.delegate secletCellIndex:bton.tag-300 andIsSeclect:YES];
    
    
}

@end
