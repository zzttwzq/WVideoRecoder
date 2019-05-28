//
//  WVideoHeader.h
//  Pods
//
//  Created by 吴志强 on 2019/2/21.
//

#ifndef WVideoHeader_h
#define WVideoHeader_h

typedef NS_ENUM(NSInteger,WSelectPhotoSourceType) {
    WSelectPhotoSourceType_Photo,  //照片
    WSelectPhotoSourceType_Library,//图库
    WSelectPhotoSourceType_Camera, //拍照
};

#import <WBasicLibrary/WBasicLibrary-umbrella.h>
//#import <WVideoPlayer/WVideoPlayer.h>
#import "WVideoRecoderTheme.h"
#import "WVideoPreviewLayerListView.h"
#import "WRecorderService.h"
#import "WRecoderVC.h"

#endif /* WVideoHeader_h */
