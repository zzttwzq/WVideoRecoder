//
//  WVideoBottomSelectView.h
//  美丽吧
//
//  Created by 吴志强 on 2018/8/10.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock)(NSString *selectItem,NSInteger index);
@interface WVideoBottomSelectView : UIView

@property (nonatomic,copy) selectBlock selectCallBack;

- (instancetype) initWithArray:(NSArray *)array
                       yoffset:(float)yoffset
                  defaultIndex:(int)defaultIndex;


- (void) setEnable:(BOOL)enable;
@end
