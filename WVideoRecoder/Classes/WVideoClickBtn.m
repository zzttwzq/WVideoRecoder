//
//  WVideoClickBtn.m
//  美丽吧
//
//  Created by 吴志强 on 2018/8/9.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "WVideoClickBtn.h"

#define viewWidth 70
#define ringWidth 15

@interface WVideoClickBtn ()

@property (nonatomic,strong) UIImageView *btnView;

@end

@implementation WVideoClickBtn

- (instancetype) initWithYoffset:(float)yoffset;
{
    self = [super init];
    if (self) {

        self.frame = CGRectMake((ScreenWidth-viewWidth)/2, yoffset, viewWidth, viewWidth);
        self.layer.cornerRadius = viewWidth/2;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];

        self.btnView = [[UIImageView alloc] init];
        self.btnView.contentMode = UIViewContentModeScaleAspectFit;
        self.btnView.center = CGPointMake(ringWidth/2.0, ringWidth/2.0);
        self.btnView.width = viewWidth-ringWidth;
        self.btnView.height = viewWidth-ringWidth;
        self.btnView.layer.cornerRadius = (viewWidth-ringWidth)/2.0;
        self.btnView.layer.masksToBounds = YES;
        self.btnView.backgroundColor = [UIColor whiteColor];
        self.btnView.userInteractionEnabled = YES;
        [self.btnView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBtn:)]];
        [self addSubview:self.btnView];
    }
    return self;
}


/**
 设置媒体选择类型

 @param mode 媒体类型
 */
- (void) setMode:(WRecordMode)mode
{
    _mode = mode;
    self.state = WRecordButtonState_Ready;
}


/**
 设置状态

 @param state 状态
 */
- (void) setState:(WRecordButtonState)state
{
    _state = state;
    [UIView animateWithDuration:0.3 animations:^{

        if (state == WRecordButtonState_Ready||
            state == WRecordButtonState_Complelete) {

            self.btnView.image = nil;
            self.btnView.backgroundColor = [UIColor whiteColor];
        }
        else if (state == WRecordButtonState_TakePhoto) {

            self.btnView.image = nil;
            self.btnView.backgroundColor = [UIColor whiteColor];
        }
        else if (state == WRecordButtonState_Recording) {

//            self.btnView.image = [UIImage imageNamed:@"transcribe_icon"];
            self.btnView.backgroundColor = [UIColor redColor];
        }
    }];
}


/**
 点击按钮

 @param tap 点击
 */
- (void) clickBtn:(UITapGestureRecognizer *)tap
{
    //如果是照片模式
    if (self.mode == WRecordMode_PhotoFromeCamera) {

        [self takePhotoAction];
    }
    else if (self.mode == WRecordMode_VideoFromeCamera) {

        [self takeVideoAction];
    }
}

- (void) takePhotoAction
{
    self.state = WRecordButtonState_TakePhoto;

    //回调
    if (self.recordingState) {
        self.recordingState(self.state);
    }

    //动画
    self.btnView.backgroundColor = [UIColor grayColor];

    [UIView animateWithDuration:0.3 animations:^{

        self.btnView.backgroundColor = [UIColor whiteColor];
    } completion:^(BOOL finished) {

        self.state = WRecordButtonState_Ready;
    }];
}

- (void) takeVideoAction
{
    if (self.state == WRecordButtonState_Ready||
        self.state == WRecordButtonState_Complelete) {

        self.state = WRecordButtonState_Recording;
    }
    else if (self.state == WRecordButtonState_Recording) {
        
        self.state = WRecordButtonState_Complelete;
    }

    //回调
    if (self.recordingState) {
        self.recordingState(self.state);
    }
}

@end
