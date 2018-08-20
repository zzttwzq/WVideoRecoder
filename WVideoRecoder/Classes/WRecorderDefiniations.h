//
//  WRecorderDefiniations.h
//  Pods
//
//  Created by 吴志强 on 2018/8/13.
//

#ifndef WRecorderDefiniations_h
#define WRecorderDefiniations_h

#import "UIView+WZQView.h"
#import "WRecorderService.h"

typedef NS_ENUM(NSInteger,WSelectPhotoSourceType) {
    WSelectPhotoSourceType_Photo,  //照片
    WSelectPhotoSourceType_Library,//图库
    WSelectPhotoSourceType_Camera, //拍照
};

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BottomHeight [WRecorderService getBottomHeight]

#define VIEW_WITH_RECT(x,y,width,height) [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)]
#define LABEL_WITH_RECT(x,y,width,height) [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)]
#define IMAGE_WITH_RECT(x,y,width,height) [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)]
#define BUTTON_WITH_RECT(x,y,width,height) [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)]

typedef void(^StringBlock)(NSString *string);
typedef void(^dictBlock)(NSDictionary *dict);

#ifdef DEBUG
#define WLOG(...) NSLog(__VA_ARGS__);
#define WLOG_METHOD NSLog(@"%s", __func__);
#else
#define WLOG(...);
#define WLOG_METHOD;
#endif

//弱引用
#define WEAK_SELF(Class) typeof(Class *)weakSelf = self;

typedef void(^stringBlock)(NSString *string);

#endif /* WRecorderDefiniations_h */
