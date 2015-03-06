//
//  YZShopCell.m
//  UICollectionViewWaterFlowLayout
//
//  Created by yang on 15/3/6.
//  Copyright (c) 2015年 yangzhiqiang. All rights reserved.
//

#import "YZShopCell.h"
#import "UIImageView+WebCache.h"
#import "YZShop.h"

@interface YZShopCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLebel;

@end

@implementation YZShopCell

- (void)setShop:(YZShop *)shop {
    _shop = shop;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    self.priceLebel.text = shop.price;
}

@end
