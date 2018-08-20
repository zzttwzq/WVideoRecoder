//
//  WVideoPreviewLayerListView.m
//  美丽吧
//
//  Created by 吴志强 on 2018/8/11.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "WVideoPreviewLayerListView.h"

@interface WVideoPreviewLayerListView ()

@property (nonatomic,strong) UIScrollView *scroll;

@end

@implementation WVideoPreviewLayerListView

- (instancetype) init;
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, 60);
        self.backgroundColor = [UIColor redColor];

        self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
        self.scroll.showsVerticalScrollIndicator = NO;
        self.scroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scroll];

    }
    return self;
}

- (void) setPreviewImageArray:(NSArray<UIImage *> *)previewImageArray
{
    _previewImageArray = previewImageArray;

    float totalWidth = 60*previewImageArray.count;

    for (int i = 0; i<previewImageArray.count; i++) {

        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(60*i, 0, 60, 60)];
        image.image = previewImageArray[i];
    }
}

@end
