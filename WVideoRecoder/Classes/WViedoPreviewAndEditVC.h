//
//  WViedoPreviewAndEditVC.h
//  美丽吧
//
//  Created by 吴志强 on 2018/8/10.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^dataCallBack)(NSDictionary *dict);

@interface WViedoPreviewAndEditVC : UIViewController
@property (nonatomic,strong) NSURL *videoPath;
@property (nonatomic,strong) UIImage *previewImage;
@property (nonatomic,copy) dataCallBack callBack;

@end
