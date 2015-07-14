//
//  PublishCollectView.h
//  Sports
//
//  Created by 吴超 on 15/7/5.
//  Copyright (c) 2015年 吴超. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SeceletCellDelegate <NSObject>

-(void)secletCellIndex:(NSInteger)index andIsSeclect:(BOOL)isSeclect;

@end

@interface PublishCollectView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak)id<SeceletCellDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *CollecetArray;

@end
