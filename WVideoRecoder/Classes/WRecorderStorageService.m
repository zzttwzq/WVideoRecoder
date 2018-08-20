//
//  WRecorderStorageService.m
//  Pods
//
//  Created by 吴志强 on 2018/8/14.
//

#import "WRecorderStorageService.h"

@implementation WRecorderStorageService
#pragma mark - 视频保存
/**
 保存到系统相册

 @param filePath 文件路径
 */
+ (void) saveToPhotoLibrary:(NSString *)filePath;
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{

        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:[NSURL fileURLWithPath:filePath]];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {

        NSLog(@"保存成功");
    }];
}


- (void) saveToPath:(NSString *)path
{

}


/**
 上传图片

 @param image 要上传的图片
 @param result 回调
 */
+ (void) upLoadImage:(UIImage *)image
              result:(void(^)(NSString *string))result;
{
//    [HMOSSUploadHandler uploadImg:image result:result];
}


/**
 上传视频

 @param path 路径
 @param result 回调
 */
+ (void) upLoadVideoWithPath:(NSString *)path
                      result:(void(^)(NSString *string))result;
{

}


#pragma mark - 其他
/**
 此方法可以获取文件的大小，返回的是单位是KB。

 @param filePath 文件地址字符串
 @return 返回多少kb
 */
+ (CGFloat) getVideoLength:(NSString *)filePath;
{
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:[NSURL URLWithString:filePath]];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}


/**
 获取文件大小

 @param path 文件地址
 @return 返回大小
 */
+ (CGFloat) getFileSize:(NSString *)path;
{
    NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size;
    }else{
        NSLog(@"找不到文件");
    }
    return filesize;
}
@end
