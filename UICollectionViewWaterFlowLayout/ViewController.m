//
//  ViewController.m
//  UICollectionViewWaterFlowLayout
//
//  Created by yang on 15/3/6.
//  Copyright (c) 2015年 yangzhiqiang. All rights reserved.
//

#import "ViewController.h"
#import "YZCollectionViewWaterflowLayout.h"
#import "MJExtension.h"
#import "YZShop.h"
#import "YZShopCell.h"

static NSString *const ID = @"cell";

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, YZCollectionViewWaterflowLayoutDelegate>
@property (nonatomic, strong) NSArray *showList;
@end

@implementation ViewController

- (NSArray *)showList {
    if (!_showList) {
        _showList = [YZShop objectArrayWithFilename:@"test.plist"];
    }
    return _showList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YZCollectionViewWaterflowLayout *waterflow = [[YZCollectionViewWaterflowLayout alloc] init];
    waterflow.delegate                         = self;
    waterflow.columnsCount                     = 3;
    waterflow.interitemSpacing                 = 10;
    waterflow.lineSpacing                      = 10;
    waterflow.sectionInset                     = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterflow];
    collectionView.backgroundColor   = [UIColor whiteColor];
    collectionView.dataSource        = self;
    collectionView.delegate          = self;
    [self.view addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:@"YZShopCell" bundle:nil] forCellWithReuseIdentifier:ID];
}

#pragma mark - YZCollectionViewWaterflowLayoutDelegate
- (CGFloat)collectionViewWaterflowLayout:(YZCollectionViewWaterflowLayout *)collectionViewWaterflowLayout heightForItemWithWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    YZShop *shop = self.showList[indexPath.item];
    return shop.h / shop.w * width;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.showList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YZShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.shop = self.showList[indexPath.item];

    return cell;
}

@end
