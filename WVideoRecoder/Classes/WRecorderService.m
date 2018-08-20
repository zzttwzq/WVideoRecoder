//
//  WRecorderService.m
//  Pods
//
//  Created by 吴志强 on 2018/8/14.
//

#import "WRecorderService.h"

@interface WRecorderService () <UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCaptureFileOutputRecordingDelegate,AVCaptureAudioDataOutputSampleBufferDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>

@property (assign  , nonatomic) dispatch_queue_t captureQueue;//录制的队列

@end

@implementation WRecorderService
/**
 获取实例对象

 @return 返回实例化的对象
 */
+ (instancetype) service;
{
    return [self new];
}


/**
 获取预览图层

 @param frame 图层的宽高
 @return 返回预览图层
 */
- (AVCaptureVideoPreviewLayer *) getCaptureLayerWithFrame:(CGRect)frame;
{
    self.previewLayer.frame = frame;
    return self.previewLayer;
}

#pragma mark - 开启捕捉
/**
 开始准备工作
 */
- (void) startSession;
{
        //1.配置会话
    self.session = [[AVCaptureSession alloc] init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        self.session.sessionPreset = AVCaptureSessionPreset1280x720;
    }

        //2.创建队列
    self.captureQueue = [self captureQueue];


        //3.配置视频输入对象
    self.videoInput = [WRecorderService backCameraInput];


        //4.配置音频输入对象
    self.audioInput = [WRecorderService audioMicInput];


        //5.配置设备输出对象
    self.fileOutput = [[AVCaptureMovieFileOutput alloc] init];
    self.videoOutput = [self videoOutput];
    self.audioOutput = [self audioOutput];


        //6.将设备输入添加到会话中
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];

            //防抖功能
        AVCaptureConnection *captureConnection = [self.fileOutput connectionWithMediaType:AVMediaTypeAudio];
        if ([captureConnection isVideoStabilizationSupported]) {
            captureConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
        }
    }
    if ([self.session canAddInput:self.audioInput]) {
        [self.session addInput:self.audioInput];
    }


        //7.将设备输出添加到会话中
    if ([self.session canAddOutput:self.fileOutput]) {
        [self.session addOutput:self.fileOutput];
    }

    if ([self.session canAddOutput:self.videoOutput]) {
        [self.session addOutput:self.videoOutput];
    }
    if ([self.session canAddOutput:self.audioOutput]) {
        [self.session addOutput:self.audioOutput];
    }


        //8.配置输出连接对象
    self.videoOutputConnetion = [self videoOutputConnetion];
    self.audioOutputConnetion = [self audioOutputConnetion];


        //9.创建视频预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//设置比例为铺满全屏


        //10.开始获取视频流
    [self runSession];
}


#pragma mark - 流程处理
/**
 开始捕获视频流
 */
- (void) runSession;
{
    [self.session startRunning];
}


/**
 停止捕获视频流
 */
- (void) stopSession;
{
    [self.session stopRunning];
}


/**
 开始录制
 */
- (void) startRecording;
{
    AVCaptureConnection *captureConnection = [self.fileOutput connectionWithMediaType:AVMediaTypeVideo];
    captureConnection.videoOrientation = [self.previewLayer connection].videoOrientation;

    NSDate *date = [NSDate date];
    NSDateFormatter *fommatter = [NSDateFormatter new];
    fommatter.dateFormat = @"HH:mm:ss";

    self.recordFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mov",[fommatter stringFromDate:date]]];

    [self.fileOutput startRecordingToOutputFileURL:[NSURL fileURLWithPath:self.recordFilePath] recordingDelegate:self];

    NSLog(@"录制视频存储路径-->>%@",self.recordFilePath);
}


/**
 暂停录制
 */
- (void) pauseRecording;
{
    [self.fileOutput stopRecording];
}


/**
 恢复录制
 */
- (void) resumeRecording;
{
    if (self.recordFilePath.length > 0) {

        AVCaptureConnection *captureConnection = [self.fileOutput connectionWithMediaType:AVMediaTypeVideo];
        captureConnection.videoOrientation = [self.previewLayer connection].videoOrientation;
        [self.fileOutput startRecordingToOutputFileURL:[NSURL fileURLWithPath:self.recordFilePath] recordingDelegate:self];
    }
}

/**
 切换到前置摄像头

 @param isFront 是否是前置
 */
- (void) switchCameraWithFront:(BOOL)isFront;
{
    [self.session stopRunning];
    [self.session removeInput:self.videoInput];

    if (isFront) {
        self.videoInput = [WRecorderService frontCameraInput];
    }
    else{
        self.videoInput = [WRecorderService backCameraInput];
    }

    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }

    [self.session startRunning];
}

#pragma mark - 回调代理
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections {
    NSLog(@"-->>开始录制");
}

- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error {
    NSLog(@"-->>录制结束");
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection;
{
    if (self.takePhoto) {
        self.takePhoto = NO;

        @autoreleasepool {

                //让镜头旋转
            [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];

            CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
            /*Lock the image buffer*/
            CVPixelBufferLockBaseAddress(imageBuffer,0);
            /*Get information about the image*/
            uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
            size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
            size_t width = CVPixelBufferGetWidth(imageBuffer);
            size_t height = CVPixelBufferGetHeight(imageBuffer);

            /*Create a CGImageRef from the CVImageBufferRef*/
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
            CGImageRef newImage = CGBitmapContextCreateImage(newContext);

            /*We unlock the image buffer*/
            CVPixelBufferUnlockBaseAddress(imageBuffer,0);
            CGRect zoom = CGRectMake(0, 0,750,667);
            CGImageRef newImage2 = CGImageCreateWithImageInRect(newImage, zoom);

            /*We release some components*/
            CGContextRelease(newContext);
            CGColorSpaceRelease(colorSpace);

            UIImage* zoomedImage = [[UIImage alloc] initWithCGImage:newImage2];

            if ([self.delegate respondsToSelector:@selector(didCaptureImage:)]) {
                [self.delegate didCaptureImage:zoomedImage];
            }

            CGImageRelease(newImage);
            CGImageRelease(newImage2);
        }
    }
}


    //-(void)alertUploadVideo:(NSURL*)URL{
    //
    //    CGFloat size = [self getFileSize:[URL path]];
    //    NSString *message;
    //    NSString *sizeString;
    //    CGFloat sizemb= size/1024;
    //    if(size<=1024){
    //        sizeString = [NSString stringWithFormat:@"%.2fKB",size];
    //    }else{
    //        sizeString = [NSString stringWithFormat:@"%.2fMB",sizemb];
    //    }
    //
    //    if(sizemb<2){
    //        [self uploadVideo:URL];
    //    }
    //
    //    else if(sizemb<=5){
    //        message = [NSString stringWithFormat:@"视频%@，大于2MB会有点慢，确定上传吗？", sizeString];
    //        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
    //                                                                                  message: message
    //                                                                           preferredStyle:UIAlertControllerStyleAlert];
    //
    //
    //        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    //            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
    //            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间（沙盒）
    //
    //        }]];
    //        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    //
    //
    //            [self uploadVideo:URL];
    //
    //
    //
    //
    //        }]];
    //        [self presentViewController:alertController animated:YES completion:nil];
    //
    //
    //    }
    //    else if(sizemb>5){
    //        message = [NSString stringWithFormat:@"视频%@，超过5MB，不能上传，抱歉。", sizeString];
    //        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
    //                                                                                  message: message
    //                                                                           preferredStyle:UIAlertControllerStyleAlert];
    //
    //        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    //            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
    //            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间
    //
    //        }]];
    //        [self presentViewController:alertController animated:YES completion:nil];
    //
    //    }
    //}


-(void)uploadVideo:(NSURL*)URL
{
        //        //[MyTools showTipsWithNoDisappear:nil message:@"正在上传..."];
        //    NSData *data = [NSData dataWithContentsOfURL:URL];
        //    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"www.ylhuakai.com" customHeaderFields:nil];
        //    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        //    NSString *updateURL;
        //    updateURL = @"/alflower/Data/sendupdate";
        //
        //
        //    [dic setValue:[NSString stringWithFormat:@"%@",User_id] forKey:@"openid"];
        //    [dic setValue:[NSString stringWithFormat:@"%@",[self.web objectForKey:@"web_id"]] forKey:@"web_id"];
        //    [dic setValue:[NSString stringWithFormat:@"%i",insertnumber] forKey:@"number"];
        //    [dic setValue:[NSString stringWithFormat:@"%i",insertType] forKey:@"type"];
        //
        //    MKNetworkOperation *op = [engine operationWithPath:updateURL params:dic httpMethod:@"POST"];
        //    [op addData:data forKey:@"video" mimeType:@"video/mpeg" fileName:@"aa.mp4"];
        //    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        //        NSLog(@"[operation responseData]-->>%@", [operation responseString]);
        //        NSData *data = [operation responseData];
        //        NSDictionary *resweiboDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //        NSString *status = [[resweiboDict objectForKey:@"status"]stringValue];
        //        NSLog(@"addfriendlist status is %@", status);
        //        NSString *info = [resweiboDict objectForKey:@"info"];
        //        NSLog(@"addfriendlist info is %@", info);
        //            // [MyTools showTipsWithView:nil message:info];
        //            // [SVProgressHUD showErrorWithStatus:info];
        //        if ([status isEqualToString:@"1"])
        //            {
        //                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
        //                [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//上传之后就删除，以免占用手机硬盘空间;
        //
        //            }else
        //                {
        //                        //[SVProgressHUD showErrorWithStatus:dic[@"info"]];
        //                }
        //            // [[NSNotificationCenter defaultCenter] postNotificationName:@"StoryData" object:nil userInfo:nil];
        //
        //
        //    }errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
        //        NSLog(@"MKNetwork request error : %@", [err localizedDescription]);
        //    }];
        //    [engine enqueueOperation:op];
}


#pragma mark - 设备相关
/**
 录制的队列

 @return 返回队列
 */
- (dispatch_queue_t)captureQueue {

    dispatch_queue_t captureQueue = dispatch_queue_create("cn.im.wclrecordengine.capture", DISPATCH_QUEUE_SERIAL);
    return captureQueue;
}


/**
 开启闪光灯
 */
+ (void)openFlashLight;
{
    AVCaptureDevice *backCamera = [self backCamera];
    if (backCamera.torchMode == AVCaptureTorchModeOff) {
        [backCamera lockForConfiguration:nil];
        backCamera.torchMode = AVCaptureTorchModeOn;
        backCamera.flashMode = AVCaptureFlashModeOn;
        [backCamera unlockForConfiguration];
    }
}

/**
 关闭闪光灯
 */
+ (void)closeFlashLight;
{
    AVCaptureDevice *backCamera = [self backCamera];
    if (backCamera.torchMode == AVCaptureTorchModeOn) {
        [backCamera lockForConfiguration:nil];
        backCamera.torchMode = AVCaptureTorchModeOff;
        backCamera.flashMode = AVCaptureTorchModeOff;
        [backCamera unlockForConfiguration];
    }
}


/**
 用来返回是前置摄像头还是后置摄像头

 @param position 位置
 @return 返回摄像头
 */
+ (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
        //返回和视频录制相关的所有默认设备
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        //遍历这些设备返回跟position相关的设备
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}


/**
 返回后置摄像头

 @return 返回后置摄像头
 */
+ (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}


/**
 获取后置摄像头输入

 @return 返回输入
 */
+ (AVCaptureDeviceInput *)backCameraInput
{
    NSError *error;
    AVCaptureDeviceInput *backCameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
    if (error) {
        NSLog(@"获取后置摄像头失败~");
    }
    return backCameraInput;
}


    //返回前置摄像头
+ (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}


    //前置摄像头输入
+ (AVCaptureDeviceInput *)frontCameraInput
{
    NSError *error;
    AVCaptureDeviceInput *frontCameraInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
    if (error) {
        NSLog(@"获取前置摄像头失败~");
    }
    return frontCameraInput;
}


    //麦克风输入
+ (AVCaptureDeviceInput *)audioMicInput
{
    AVCaptureDevice *mic = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    NSError *error;
    AVCaptureDeviceInput *audioMicInput = [AVCaptureDeviceInput deviceInputWithDevice:mic error:&error];
    if (error) {
        NSLog(@"获取麦克风失败~");
    }
    return audioMicInput;
}


    //视频输出
- (AVCaptureVideoDataOutput *)videoOutput {

    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    [videoOutput setSampleBufferDelegate:self queue:self.captureQueue];
    NSDictionary* setcapSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange], kCVPixelBufferPixelFormatTypeKey,
                                    nil];
    videoOutput.videoSettings = setcapSettings;
    return videoOutput;
}


    //音频输出
- (AVCaptureAudioDataOutput *)audioOutput {
    AVCaptureAudioDataOutput *audioOutput = [[AVCaptureAudioDataOutput alloc] init];
    [audioOutput setSampleBufferDelegate:self queue:self.captureQueue];
    return audioOutput;
}


    //视频连接
- (AVCaptureConnection *)videoConnection
{
    AVCaptureConnection *videoConnection = [self.videoOutput connectionWithMediaType:AVMediaTypeVideo];
    return videoConnection;
}


    //音频连接
- (AVCaptureConnection *)audioConnection
{
    AVCaptureConnection *audioConnection = [self.audioOutput connectionWithMediaType:AVMediaTypeAudio];
    return audioConnection;
}


#pragma mark - 手动聚焦
/**
 点按手势

 @param tap 点击事件
 */
- (void)tapToFocuse:tap
             inView:(UIView *)inView
              layer:(AVCaptureVideoPreviewLayer *)layer
{
    CGPoint point = [tap locationInView:inView];

    //将界面point对应到摄像头point
    CGPoint cameraPoint = [layer captureDevicePointOfInterestForPoint:point];

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
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}


/**
 聚焦曝光

 @param focusMode 聚焦模式
 @param exposureMode 曝光模式
 @param point 位置
 */
-(void)focusWithMode:(AVCaptureFocusMode)focusMode
        exposureMode:(AVCaptureExposureMode)exposureMode
             atPoint:(CGPoint)point;
{

    AVCaptureDevice *captureDevice= [self.videoInput device];
    NSError *error = nil;
        //设置设备属性必须先解锁 然后加锁
    if ([captureDevice lockForConfiguration:&error]) {

        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:focusMode];
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
            //    //曝光
            //    if ([captureDevice isExposureModeSupported:exposureMode]) {
            //      [captureDevice setExposureMode:exposureMode];
            //    }
            //    if ([captureDevice isExposurePointOfInterestSupported]) {
            //      [captureDevice setExposurePointOfInterest:point];
            //    }
            //    //闪光灯模式
            //    if ([captureDevice isFlashModeSupported:AVCaptureFlashModeAuto]) {
            //      [captureDevice setFlashMode:AVCaptureFlashModeAuto];
            //    }

            //加锁
        [captureDevice unlockForConfiguration];

    }else{
        NSLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
    }
}

#pragma mark - 转换视频
/**
 转换视频

 @param path 要转换视频的路径
 @param result 转换完成回调
 */
- (void) convertVideoWithPathString:(NSString *)path
                             result:(void(^)(NSString *path))result;
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:path] options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];

    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]){

        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        NSString *exportPath = [NSString stringWithFormat:@"%@/%@.mp4",
                                [NSHomeDirectory() stringByAppendingString:@"/cache"],
                                @"convert"];
        exportSession.outputURL = [NSURL fileURLWithPath:exportPath];
        NSLog(@"%@", exportPath);

        exportSession.outputFileType = AVFileTypeMPEG4;
        [exportSession exportAsynchronouslyWithCompletionHandler:^{

            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed:

                    NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
                    break;
                case AVAssetExportSessionStatusCancelled:

                    NSLog(@"Export canceled");
                    break;
                case AVAssetExportSessionStatusCompleted:

                    if (result) {
                        result(exportSession.presetName);
                    }
                    break;
                default:
                    break;
            }
        }];
    }
}

- (UIImage *)getFirstImageWithSize:(CGSize)size;
{
        // result
    UIImage *image = nil;

        // AVAssetImageGenerator
    AVAsset *asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:self.recordFilePath]];
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    imageGenerator.appliesPreferredTrackTransform = YES;

        // calculate the midpoint time of video
    Float64 duration = CMTimeGetSeconds([asset duration]);
        // 取某个帧的时间，参数一表示哪个时间（秒），参数二表示每秒多少帧
        // 通常来说，600是一个常用的公共参数，苹果有说明:
        // 24 frames per second (fps) for film, 30 fps for NTSC (used for TV in North America and
        // Japan), and 25 fps for PAL (used for TV in Europe).
        // Using a timescale of 600, you can exactly represent any number of frames in these systems
    CMTime midpoint = CMTimeMakeWithSeconds(0.1, 600);

        // get the image from
    NSError *error = nil;
    CMTime actualTime;
        // Returns a CFRetained CGImageRef for an asset at or near the specified time.
        // So we should mannully release it
    CGImageRef centerFrameImage = [imageGenerator copyCGImageAtTime:midpoint
                                                         actualTime:&actualTime
                                                              error:&error];

    if (centerFrameImage != NULL) {
        image = [[UIImage alloc] initWithCGImage:centerFrameImage];
            // Release the CFRetained image
        CGImageRelease(centerFrameImage);
    }
    
    return image;
}

+ (float) getBottomHeight;
{
    if (ScreenHeight == 812) {
        return 30;
    }

    return 0;
}

@end
