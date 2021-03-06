//
//  WRecoderHeader.h
//  Pods
//
//  Created by 吴志强 on 2018/8/13.
//

#ifndef WRecoderHeader_h
#define WRecoderHeader_h

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

#endif /* WRecoderHeader_h */
