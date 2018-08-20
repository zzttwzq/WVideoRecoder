//
//  WRecorderStorageService.h
//  Pods
//
//  Created by 吴志强 on 2018/8/14.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface WRecorderStorageService : NSObject

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
@end
