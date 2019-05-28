//
//  WVideoHeaderView.m
//  美丽吧
//
//  Created by 吴志强 on 2018/8/10.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "WVideoHeaderView.h"
#import "WVideoHeader.h"

@interface WVideoHeaderView ()

@property (nonatomic,strong) UIImageView *back;
@property (nonatomic,strong) UIImageView *flash;
@property (nonatomic,strong) UIImageView *changeCamera;
@property (nonatomic,strong) UIImageView *complete;
@property (nonatomic,strong) UILabel *meiyan;

@property (nonatomic,assign) BOOL flashOn;
@property (nonatomic,assign) BOOL cameraFront;
@property (nonatomic,assign) BOOL beautifulFaceClick;
@property (nonatomic,assign) BOOL filterClick;

@end

@implementation WVideoHeaderView

- (instancetype) init
{
    self = [super init];
    if (self) {

        self.beautifulFaceClick = YES;
//        self.filterClick = YES;

        float height = 0;
        if (IS_IPHONE_X) {
            height = 20;
            UIView *view = VIEW_WITH_RECT(0, -20, ScreenWidth, 20);
            view.backgroundColor = WINDOW_COLOR;
            [self addSubview:view];
        }
        self.frame = CGRectMake(0, height, ScreenWidth, 60);
        self.backgroundColor = WINDOW_COLOR;

        _back = IMAGE_WITH_RECT(15, 30, 20, 20);
        _back.image = [UIImage imageNamed:@"shoot_close_icon"];
        _back.contentMode = UIViewContentModeScaleAspectFit;
        _back.userInteractionEnabled = YES;
        [_back addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backBtnClick)]];
        [self addSubview:_back];

//        _flash = IMAGE_WITH_RECT(ScreenWidth/4+(ScreenWidth/4-20)/2, 35, 20, 20);
//        _flash.image = [UIImage imageNamed:@"shoot_close_icon"];
//        _flash.contentMode = UIViewContentModeScaleAspectFit;
//        _flash.userInteractionEnabled = YES;
//        [_flash addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(turnOnFlash)]];
//        [self addSubview:_flash];

//        _complete = IMAGE_WITH_RECT(ScreenWidth-40, 35, 25, 25);
//        _complete.image = [UIImage imageNamed:@"Checked_icon_60x60"];
//        _complete.contentMode = UIViewContentModeScaleAspectFit;
//        _complete.userInteractionEnabled = YES;
//        _complete.alpha = 0;
//        [_complete addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(completeRecording)]];
//        [self addSubview:_complete];

        _meiyan = LABEL_WITH_RECT(ScreenWidth/4, 30, ScreenWidth/4, 20);
        _meiyan.textColor = [UIColor whiteColor];
        _meiyan.font = [HMTheme getNormalFont];
        _meiyan.text = @"美颜：开";
        _meiyan.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_meiyan];

        UIView *touch1 = VIEW_WITH_RECT(ScreenWidth/4, 0, ScreenWidth/4, 60);
        touch1.userInteractionEnabled = YES;
        [touch1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(meiyanclick)]];
        [self addSubview:touch1];

        UILabel *lujing = LABEL_WITH_RECT(ScreenWidth/2, 30, ScreenWidth/4, 20);
        lujing.textColor = [UIColor whiteColor];
        lujing.font = [HMTheme getNormalFont];
        lujing.text = @"滤镜";
        lujing.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lujing];

        UIView *touch2 = VIEW_WITH_RECT(ScreenWidth/2, 0, ScreenWidth/4, 60);
        touch2.userInteractionEnabled = YES;
        [touch2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lujingClick)]];
        [self addSubview:touch2];

        _changeCamera = IMAGE_WITH_RECT(ScreenWidth-40, 25, 25, 25);
        _changeCamera.image = [UIImage imageNamed:@"shoot_overturn_icon"];
        _changeCamera.contentMode = UIViewContentModeScaleAspectFit;
        _changeCamera.userInteractionEnabled = YES;
        [_changeCamera addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeCameras)]];
        [self addSubview:_changeCamera];
    }
    return self;
}

- (void) meiyanclick
{
    self.beautifulFaceClick = !self.beautifulFaceClick;

    if (self.beautifulFaceClick) {
        _meiyan.text = @"美颜：开";
    }
    else{
        _meiyan.text = @"美颜：关";
    }

    if (self.callBack) {
        self.callBack(WVideoHeaderViewItem_beautiface, self.beautifulFaceClick);
    }
}

- (void) lujingClick
{
    self.filterClick = !self.filterClick;
    if (self.callBack) {
        self.callBack(WVideoHeaderViewItem_filter, self.filterClick);
    }
}


- (void) backBtnClick
{
    if (self.callBack) {
        self.callBack(WVideoHeaderViewItem_Back, 1);
    }
}

- (void) turnOnFlash
{
    _flashOn = !_flashOn;
    if (self.callBack) {
        self.callBack(WVideoHeaderViewItem_Flash, (int)_flashOn);
    }
}

- (void) changeCameras
{
    _cameraFront = !_cameraFront;
    if (self.callBack) {
        self.callBack(WVideoHeaderViewItem_camera, (int)_cameraFront);
    }
}

- (void) completeRecording
{

}


/**
 设置按钮是否可用

 @param enable 是否可用
 */
- (void) setEnable:(BOOL)enable;
{
    if (enable) {

//        self.
    }
    else{

    }
}
@end
