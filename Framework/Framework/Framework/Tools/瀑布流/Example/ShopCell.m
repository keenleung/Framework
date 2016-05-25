//
//  ShopCell.m
//  01-瀑布流
//
//  Created by Apple on 16/5/25.
//  Copyright © 2016年 KeenLeung. All rights reserved.
//

#import "ShopCell.h"
#import "UIImageView+WebCache.h"

@interface ShopCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@end

@implementation ShopCell

- (void)setShop:(Shop *)shop{
    
    _shop = shop;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:shop.img] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    self.priceLabel.text = [NSString stringWithFormat:@"%@", shop.price];
}

@end
