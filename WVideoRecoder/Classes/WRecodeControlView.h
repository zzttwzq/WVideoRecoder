//
//  WRecodeControlView.h
//  美丽吧
//
//  Created by 吴志强 on 2018/8/10.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRecorderDefiniations.h"
#import "WVideoHeaderView.h"
#import "WVideoClickBtn.h"
#import "WVideoBottomSelectView.h"

@protocol WVideoRecorderControlDelegate <NSObject>

- (void) headerBtnClick:(WVideoHeaderViewItem)item state:(int)state;

- (void) recordBtnClickWithSate:(WRecordButtonState)state withMode:(WRecordMode)mode;

- (void) modeChanged:(WRecordMode)mode;

- (void) timeRunout;

@end

@interface WRecodeControlView : UIView

@property (nonatomic,weak) id<WVideoRecorderControlDelegate> delegate;

@property (nonatomic,assign) float maxSeconds;

@end
