//
//  WVideoClickBtn.h
//  美丽吧
//
//  Created by 吴志强 on 2018/8/9.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRecorderDefiniations.h"

typedef NS_ENUM(NSInteger,WRecordMode) {
    WRecordMode_PhotoLibrary,
    WRecordMode_PhotoFromeCamera,
    WRecordMode_VideoFromeCamera,
};

typedef NS_ENUM(NSInteger,WRecordButtonState) {
    WRecordButtonState_Ready,
    WRecordButtonState_TakePhoto,
    WRecordButtonState_Recording,
    WRecordButtonState_Complelete,
    WRecordButtonState_Pause,
};

typedef void(^state)(WRecordButtonState state);
@interface WVideoClickBtn : UIView
/**
 按钮点击状态
 */
@property (nonatomic,assign) WRecordButtonState state;


/**
 项目选择的状态
 */
@property (nonatomic,assign) WRecordMode mode;


/**
 录制状态改变回调
 */
@property (nonatomic,copy) state recordingState;


/**
 初始化实例化的对象

 @param yoffset y位置
 @return 返回实例化的对象
 */
- (instancetype) initWithYoffset:(float)yoffset;


@end
