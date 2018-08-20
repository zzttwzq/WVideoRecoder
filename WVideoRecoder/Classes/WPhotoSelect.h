//
//  WPhotoSelect.h
//  美丽吧
//
//  Created by 吴志强 on 2018/8/11.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^imageCallBack)(UIImage *image);

@interface WPhotoSelect : NSObject

@property (nonatomic,copy) imageCallBack imageCallBack;
//@property (nonatomic,assign) WSelectPhotoSourceType type;

+ (void) selectPhotoWithTarget:(UIViewController *)target
                        result:(void(^)(UIImage *image))result;

@end
