//
//  YZCollectionViewWaterflowLayout.m
//  UICollectionViewWaterFlowLayout
//
//  Created by yang on 15/3/6.
//  Copyright (c) 2015年 yangzhiqiang. All rights reserved.
//

#import "YZCollectionViewWaterflowLayout.h"

@interface YZCollectionViewWaterflowLayout ()
@property (nonatomic, strong) NSMutableArray *maxYArray;
@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation YZCollectionViewWaterflowLayout

- (NSMutableArray *)maxYArray {
    if (!_maxYArray) {
        _maxYArray = [NSMutableArray array];
    }
    return _maxYArray;
}

- (NSMutableArray *)attrsArray {
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

- (instancetype)init {
    
    if (self = [super init]) {
        self.lineSpacing      = 10;
        self.interitemSpacing = 10;
        self.sectionInset     = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnsCount     = 3;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {

    return YES;
}

- (CGSize)collectionViewContentSize {
    // 假设第0列最大Y值最大
    CGFloat maxY = [self.maxYArray[0] doubleValue];
    // 遍历查找最长列的最大Y值及列号
    for (int i = 1; i < self.maxYArray.count; i++) {
        if (maxY < [self.maxYArray[i] doubleValue]) {
            maxY = [self.maxYArray[i] doubleValue];
        }
    }

    return CGSizeMake(0, maxY + self.sectionInset.bottom);
}

- (void)prepareLayout {
    [super prepareLayout];

    // 初始化数组
    for (int i = 0; i < self.columnsCount; i++) {
        self.maxYArray[i] = @(self.sectionInset.top);
    }
    
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {

    // 假设第0列最大Y值最小
    NSInteger maxYIndex = 0;
    CGFloat maxY = [self.maxYArray[maxYIndex] doubleValue];
    // 遍历查找最短列的最大Y值及列号
    for (int i = 1; i < self.maxYArray.count; i++) {
        if (maxY > [self.maxYArray[i] doubleValue]) {
            maxY = [self.maxYArray[i] doubleValue];
            maxYIndex = i;
        }
    }
    
    // cell的宽高
    CGFloat w = (self.collectionView.frame.size.width - (self.sectionInset.left + self.sectionInset.right) - (self.columnsCount - 1) * self.interitemSpacing) / self.columnsCount;
    CGFloat h = [self.delegate collectionViewWaterflowLayout:self heightForItemWithWidth:w atIndexPath:indexPath];

    // cell的位置
    CGFloat x = self.sectionInset.left + maxYIndex * (w + self.interitemSpacing);
    CGFloat y = maxY + self.lineSpacing;
    
    // 更新这一列的maxY
    self.maxYArray[maxYIndex] = @(y + h);
    
    // 设置cell的frame
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(x, y, w, h);
    
    return attrs;
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSLog(@"%zd", self.attrsArray.count);
    return self.attrsArray;
}
@end
