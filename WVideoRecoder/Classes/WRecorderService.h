//
//  WRecorderService.h
//  Pods
//
//  Created by 吴志强 on 2018/8/14.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import "WRecoderHeader.h"

@protocol WRecorderDelegate <NSObject>

- (void) didCaptureImage:(UIImage *)image;

@end

@interface WRecorderService : NSObject
@property (nonatomic,strong) AVCaptureSession *session;
@property (nonatomic,strong) AVCaptureDeviceInput *videoInput;
@property (nonatomic,strong) AVCaptureDeviceInput *audioInput;
@property (nonatomic,strong) AVCaptureMovieFileOutput *fileOutput;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic,strong) AVCaptureAudioDataOutput *audioOutput;
@property (nonatomic,strong) AVCaptureVideoDataOutput *videoOutput;
@property (nonatomic,strong) AVCaptureConnection *videoOutputConnetion;
@property (nonatomic,strong) AVCaptureConnection *audioOutputConnetion;

@property (nonatomic,copy) NSString *recordFilePath;
@property (nonatomic,assign) BOOL takePhoto;

@property (nonatomic,weak) id<WRecorderDelegate> delegate;

#pragma mark - 开启捕捉
/**
 获取实例对象

 @return 返回实例化的对象
 */
+ (instancetype) service;


/**
 开始准备工作
 */
- (void) startSession;


/**
 获取预览图层

 @param frame 图层的宽高
 @return 返回预览图层
 */
- (AVCaptureVideoPreviewLayer *) getCaptureLayerWithFrame:(CGRect)frame;

#pragma mark - 流程处理

/**
 开始捕获视频流
 */
- (void) runSession;


    //停止补货视频流
- (void) stopSession;


/**
 开始录制
 */
- (void) startRecording;


/**
 暂停录制
 */
- (void) pauseRecording;


/**
 恢复录制
 */
- (void) resumeRecording;


/**
 切换到前置摄像头

 @param ifFront 是否是前置
 */
- (void) switchCameraWithFront:(BOOL)ifFront;


#pragma mark - 手动聚焦
/**
 聚焦曝光

 @param focusMode 聚焦模式
 @param exposureMode 曝光模式
 @param point 位置
 */
- (void)focusWithMode:(AVCaptureFocusMode)focusMode
         exposureMode:(AVCaptureExposureMode)exposureMode
              atPoint:(CGPoint)point;

#pragma mark - 转换视频
/**
 转换视频

 @param path 要转换视频的路径
 @param result 转换完成回调
 */
- (void) convertVideoWithPathString:(NSString *)path
                             result:(void(^)(NSString *path))result;

/**
 获取图片第一帧

 @param size 图片的尺寸
 @return 返回图片
 */
- (UIImage *)getFirstImageWithSize:(CGSize)size;

#pragma mark - 视频保存
/**
 保存到系统相册

 @param filePath 文件路径
 */
+ (void) saveToPhotoLibrary:(NSString *)filePath;


/**
 上传图片

 @param image 要上传的图片
 @param result 回调
 */
+ (void) upLoadImage:(UIImage *)image
              result:(void(^)(NSString *string))result;


/**
 上传视频

 @param path 路径
 @param result 回调
 */
+ (void) upLoadVideoWithPath:(NSString *)path
                      result:(void(^)(NSString *string))result;


#pragma mark - 设备相关
/**
 开启闪光灯
 */
+ (void)openFlashLight;


/**
 关闭闪光灯
 */
+ (void)closeFlashLight;


#pragma mark - 其他
/**
 此方法可以获取文件的大小，返回的是单位是KB。

 @param filePath 文件地址字符串
 @return 返回多少kb
 */
+ (CGFloat) getVideoLength:(NSString *)filePath;


/**
 获取文件大小

 @param path 文件地址
 @return 返回大小
 */
+ (CGFloat) getFileSize:(NSString *)path;


+ (float) getBottomHeight;

@end
