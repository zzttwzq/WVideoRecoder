//
//  HVideoRecodeVC.m
//  美丽吧
//
//  Created by 吴志强 on 2018/8/8.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "HVideoRecodeVC.h"
#import "WPhotoSelect.h"

#define PLS_BaseToolboxView_HEIGHT 64

@interface HVideoRecodeVC () <CAAnimationDelegate,WVideoCaptureDelegate,WVideoRecorderControlDelegate,PLShortVideoRecorderDelegate>
//@property (atomic, assign) BOOL isCapturing;//正在录制
//@property (atomic, assign) CMTime startTime;//开始录制的时间
//@property (atomic, assign) CGFloat currentRecordTime;//当前录制时间
@property (nonatomic,strong) HVideoCaptureService *service;

@end

@implementation HVideoRecodeVC

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [self.service resumeRecording];
    [self.service runSession];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [self.service pauseRecording];
    [self.service stopSession];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor blackColor];

    WRecodeControlView *control = [WRecodeControlView new];
    control.delegate = self;
    control.maxSeconds = 30;
    [self.view addSubview:control];

    self.service = [HVideoCaptureService service];
    self.service.delegate = self;
    [self.service startSession];
    [self.view.layer insertSublayer:[self.service getCaptureLayerWithFrame:self.view.frame] atIndex:0];

    //添加点按聚焦手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen:)];
    [self.view addGestureRecognizer:tapGesture];
}

#pragma mark - WVideoRecordDelegate
- (void) backBtnClick;
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) flashEnable:(BOOL)enable;
{
    if (enable) {
        [HVideoCaptureService openFlashLight];
    }
    else{
        [HVideoCaptureService closeFlashLight];
    }
}

- (void) swithCameraToFront:(BOOL)toFront;
{
    [self.service switchCameraWithFront:toFront];
}

- (void) recordBtnClickWithSate:(WRecordButtonState)state withMode:(WRecordMode)mode;
{
    WEAK_SELF(HVideoRecodeVC);
    if (mode == WRecordMode_PhotoFromeCamera) {

        if (state == WRecordButtonState_TakePhoto) {

            weakSelf.service.takePhoto = YES;
//            //1.处理数据流
//            [self.service startRecording];
//
//            //2.延时录制
//            [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
//
//                [weakSelf.service pauseRecording];
//
//                NSLog(@"%@",weakSelf.service.recordFilePath);
//
//                NSLog(@"%f",[weakSelf.service getFileSize:weakSelf.service.recordFilePath]);
//
//                UIImage *image = [weakSelf.service getFirstImageWithSize:CGSizeMake(ScreenWidth, ScreenHeight)];
//
//                WPhotoPreviewVCViewController *view = [WPhotoPreviewVCViewController new];
//                view.image = image;
//                view.filePath = weakSelf.service.recordFilePath;
//                [weakSelf presentViewController:view animated:YES completion:nil];
//            }];
        }
    }
    else if (mode == WRecordMode_VideoFromeCamera) {

        if (state == WRecordButtonState_Recording) {

            [self.service startRecording];
        }
        else if (state == WRecordButtonState_Complelete) {

            //1.暂停录制
            [self.service pauseRecording];

            //2.停止视频流
            [self.service stopSession];

            //3.跳转界面
            WViedoPreviewAndEditVC *viewc = [WViedoPreviewAndEditVC new];
            viewc.videoPath = self.service.recordFilePath;
            [self presentViewController:viewc animated:YES completion:nil];
        }
    }
}

- (void) modeChanged:(WRecordMode)mode;
{
    if (mode == WRecordMode_PhotoLibrary) {

        WSelectPhotoViewController *chose = [WSelectPhotoViewController new];
        chose.type = WSelectPhotoSourceType_Photo;
        chose.img = ^(UIImage *image) {

            [self.navigationController popViewControllerAnimated:YES];

            [HVideoCaptureService upLoadImage:image result:^(NSString *string) {

                NSDictionary *dict = @{@"type":@"image",
                                       @"width":[NSString stringWithFormat:@"%0.2f",image.size.width],
                                       @"height":[NSString stringWithFormat:@"%0.2f",image.size.height],
                                       @"url":string
                                       };

                if (self.infoCallBack) {
                    self.infoCallBack(dict);
                }
            }];
        };
        [self.navigationController pushViewController:chose animated:YES];
    }
}

#pragma mark - WVideoCaptureDelegate
- (void) didCaptureImage:(UIImage *)image;
{

}

#pragma mark - 手动聚焦
//点按手势
- (void)tapScreen:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.view];

    //将界面point对应到摄像头point
    CGPoint cameraPoint = [self.service.previewLayer captureDevicePointOfInterestForPoint:point];

        //设置聚光动画
        //    self.focusCursor.center = point;
        //    self.focusCursor.transform = CGAffineTransformMakeScale(1.5, 1.5);
        //    self.focusCursor.alpha = 1.0f;
        //    [UIView animateWithDuration:1 animations:^{
        //        self.focusCursor.transform = CGAffineTransformIdentity;
        //    } completion:^(BOOL finished) {
        //        self.focusCursor.alpha = 0.0f;
        //
        //    }];


    //设置聚光点坐标
    [self.service focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

- (void)dealloc {
    [self.service stopSession];
    _service = nil;
}
@end
