//
//  WVideoFilterListView.h
//  美丽吧
//
//  Created by 吴志强 on 2018/8/11.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WVideoFilterItem.h"
#import "WRecorderDefiniations.h"

typedef void(^clickBlock)(NSString *title);

@interface WVideoFilterListView : UIView

@property (nonatomic,copy) clickBlock click;
@property (nonatomic,strong) UIImage *previewImage;

/**
 初始化

 @param array 文字数组
 @return 返回实例
 */
- (instancetype) initWithArray:(NSArray *)array;

@end
