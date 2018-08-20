//
//  WVideoFilterListView.m
//  美丽吧
//
//  Created by 吴志强 on 2018/8/11.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "WVideoFilterListView.h"

@interface WVideoFilterListView ()

@property (nonatomic,strong) NSMutableArray<WVideoFilterItem *> *filterItemArray;
@property (nonatomic,strong) NSArray<NSString *> *titleArray;
@property (nonatomic,strong) UIScrollView *scroll;

@end

@implementation WVideoFilterListView
/**
 初始化

 @param array 文字数组
 @return 返回实例
 */
- (instancetype) initWithArray:(NSArray *)array;
{
    self = [super init];
    if (self) {

        self.titleArray = array;


        self.frame = CGRectMake(0, ScreenWidth-BottomHeight-80, ScreenWidth, 80);
        self.filterItemArray = [NSMutableArray array];

        float totalWith = array.count*80;

        self.scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
        self.scroll.backgroundColor = [UIColor redColor];
        self.scroll.showsHorizontalScrollIndicator = NO;
        self.scroll.showsVerticalScrollIndicator = NO;
        self.scroll.contentSize = CGSizeMake(totalWith, self.height);
        [self addSubview:self.scroll];

        for (int i = 0; i<array.count; i++) {

            WVideoFilterItem *item = [[WVideoFilterItem alloc] initWithIndex:i title:array[i]];
            [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
            item.userInteractionEnabled = YES;
            item.tag = 1000+i;
            [self.scroll addSubview:item];

            [self.filterItemArray addObject:item];
        }
    }
    return self;
}

- (void) click:(UITapGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag - 1000;
    if (self.click) {
        self.click(self.titleArray[index]);
    }
}

@end
