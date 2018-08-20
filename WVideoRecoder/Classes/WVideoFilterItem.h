//
//  WVideoFilterItem.h
//  美丽吧
//
//  Created by 吴志强 on 2018/8/11.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRecorderDefiniations.h"

@interface WVideoFilterItem : UIView
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSString *title;


- (instancetype) initWithIndex:(int)index
                         title:(NSString *)title;

@end
