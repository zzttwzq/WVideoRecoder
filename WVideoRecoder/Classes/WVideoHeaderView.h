//
//  WVideoHeaderView.h
//  美丽吧
//
//  Created by 吴志强 on 2018/8/10.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRecoderHeader.h"

typedef NS_ENUM(NSInteger,WVideoHeaderViewItem) {
    WVideoHeaderViewItem_Back,
    WVideoHeaderViewItem_Flash,
    WVideoHeaderViewItem_camera,
    WVideoHeaderViewItem_compelete,
    WVideoHeaderViewItem_beautiface,
    WVideoHeaderViewItem_filter,
};

typedef void(^clickBlock)(WVideoHeaderViewItem type,int state);
@interface WVideoHeaderView : UIView

/**
 按钮点击回调
 */
@property (nonatomic,copy) clickBlock callBack;


/**
 设置按钮是否可用

 @param enable 是否可用
 */
- (void) setEnable:(BOOL)enable;

@end
