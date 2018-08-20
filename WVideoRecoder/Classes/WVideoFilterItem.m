//
//  WVideoFilterItem.m
//  美丽吧
//
//  Created by 吴志强 on 2018/8/11.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "WVideoFilterItem.h"

#define WVideoFilterItem_WIDTH 80

@interface WVideoFilterItem ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *showImage;

@end

@implementation WVideoFilterItem

- (instancetype) initWithIndex:(int)index
                         title:(NSString *)title;
{
    self = [super init];
    if (self) {

        self.title = title;
        self.frame = CGRectMake(index*WVideoFilterItem_WIDTH, 0, WVideoFilterItem_WIDTH, WVideoFilterItem_WIDTH+15);

        _showImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        _showImage.backgroundColor = [UIColor redColor];
        _showImage.contentMode = UIViewContentModeScaleAspectFit;
        _showImage.layer.cornerRadius = 30;
        _showImage.layer.masksToBounds = YES;
        [self addSubview:_showImage];

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _showImage.bottom+5, ScreenWidth, 20)];
        _titleLabel.textColor = [UIColor blackColor];//[HMTheme getNormalColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];//[HMTheme getNormalFont];
        _titleLabel.text = title;
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void) setImage:(UIImage *)image
{
    _image = image;
    _showImage.image = image;
}

@end
