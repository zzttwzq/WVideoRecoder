//
//  WRecoderVC.h
//  Pods
//
//  Created by 吴志强 on 2018/8/14.
//

#import <Foundation/Foundation.h>
#import "WRecodeControlView.h"
#import "WRecorderService.h"
#import "WViedoPreviewAndEditVC.h"
#import "WPhotoPreviewVCViewController.h"

@interface WRecoderVC : UIViewController
/**
 回调
 */
@property (nonatomic,copy) dictBlock infoCallBack;

@end
