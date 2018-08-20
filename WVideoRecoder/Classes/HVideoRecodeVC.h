//
//  HVideoRecodeVC.h
//  美丽吧
//
//  Created by 吴志强 on 2018/8/8.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "WRecodeControlView.h"
#import "WRecorderService.h"
#import "WViedoPreviewAndEditVC.h"
#import "WPhotoPreviewVCViewController.h"

typedef void(^infoCallBack)(NSDictionary *dict);
@interface HVideoRecodeVC : UIViewController
/**
 回调
 */
@property (nonatomic,copy) infoCallBack infoCallBack;


@end
