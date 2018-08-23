#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HVideoRecodeVC.h"
#import "WPhotoPreviewVCViewController.h"
#import "WPhotoSelect.h"
#import "WRecodeControlView.h"
#import "WRecoderHeader.h"
#import "WRecoderVC.h"
#import "WRecorderDefiniations.h"
#import "WRecorderProcessService.h"
#import "WRecorderService.h"
#import "WRecorderStorageService.h"
#import "WVideoBottomSelectView.h"
#import "WVideoClickBtn.h"
#import "WVideoFilterItem.h"
#import "WVideoFilterListView.h"
#import "WVideoHeaderView.h"
#import "WVideoPreviewLayerListView.h"
#import "WViedoPreviewAndEditVC.h"

FOUNDATION_EXPORT double WVideoRecoderVersionNumber;
FOUNDATION_EXPORT const unsigned char WVideoRecoderVersionString[];

