//
//  YZCollectionViewWaterflowLayout.h
//  UICollectionViewWaterFlowLayout
//
//  Created by yang on 15/3/6.
//  Copyright (c) 2015年 yangzhiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YZCollectionViewWaterflowLayout;

@protocol YZCollectionViewWaterflowLayoutDelegate <NSObject>

@optional
- (CGFloat)collectionViewWaterflowLayout:(YZCollectionViewWaterflowLayout *)collectionViewWaterflowLayout heightForItemWithWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end

@interface YZCollectionViewWaterflowLayout : UICollectionViewLayout

@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, assign) CGFloat interitemSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;
@property (nonatomic, assign) NSInteger columnsCount;

@property (nonatomic, weak) id<YZCollectionViewWaterflowLayoutDelegate> delegate;

@end
