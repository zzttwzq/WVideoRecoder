//
//  WVideoBottomSelectView.m
//  美丽吧
//
//  Created by 吴志强 on 2018/8/10.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "WVideoBottomSelectView.h"

@interface WVideoBottomSelectView ()

@property (nonatomic,copy) NSArray *selectArray;
@property (nonatomic,strong) UIView *selectBackView;
@property (nonatomic,strong) UIView *indicatorView;

@end

@implementation WVideoBottomSelectView

- (instancetype) initWithArray:(NSArray *)array
                       yoffset:(float)yoffset
                  defaultIndex:(int)defaultIndex
{
    self = [super init];
    if (self) {

        float width = ScreenWidth/array.count;
        _selectArray = array;
        self.frame = CGRectMake(0, yoffset, ScreenWidth, 60);

        //设置标记条
        NSString *string = self.selectArray[defaultIndex];
        CGSize labsize = [string getStringSizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(ScreenWidth, ScreenHeight)];

        _indicatorView = VIEW_WITH_RECT((width-labsize.width+5)/2+width*defaultIndex, 43, labsize.width-5, 2);
        _indicatorView.backgroundColor = [HMTheme getAlertColor];
        [self addSubview:_indicatorView];

        self.selectBackView = VIEW_WITH_RECT(0, 0, ScreenWidth, 60);
        [self addSubview:self.selectBackView];
        //设置类型视图
        for (int i = 0; i<array.count; i++) {

            UILabel *label = LABEL_WITH_RECT(width*i, 20, width, 20);
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor whiteColor];
            label.text = array[i];
            label.tag = 2000+i;
            label.textAlignment = NSTextAlignmentCenter;
            [self.selectBackView addSubview:label];

            UIView *touchView = VIEW_WITH_RECT(width*i, 0, width, 60);
            touchView.userInteractionEnabled = YES;
            [touchView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseType:)]];
            touchView.tag = 1000+i;
            [self.selectBackView addSubview:touchView];
        }
    }

    return self;
}

- (void) choseType:(UITapGestureRecognizer *)tap
{
    float width = ScreenWidth/3.0;
    NSInteger index = tap.view.tag - 1000;

    if (self.selectCallBack) {
        self.selectCallBack(_selectArray[index],index);
    }

    //下标条位置
    if (index != 0) {

        NSString *string = self.selectArray[index];
        CGSize labsize = [string getStringSizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(ScreenWidth, ScreenHeight)];

        [UIView animateWithDuration:0.5 animations:^{

            self.indicatorView.left = (width-labsize.width+5)/2+width*index;
            self.indicatorView.width = labsize.width-5;
        }];
    }
}


- (void) setEnable:(BOOL)enable;
{
    for (int i = 0; i<self.selectArray.count; i++) {

        UILabel *label = [self viewWithTag:2000+i];
        UIView *touchview = [self viewWithTag:1000+i];

        if (enable) {

            touchview.userInteractionEnabled = YES;
            label.textColor = [UIColor whiteColor];
        }
        else{

            touchview.userInteractionEnabled = NO;
            label.textColor = [HMTheme getDetialColor];
        }
    }
}
@end
