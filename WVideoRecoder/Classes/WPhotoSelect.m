//
//  WPhotoSelect.m
//  美丽吧
//
//  Created by 吴志强 on 2018/8/11.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "WPhotoSelect.h"

@interface WPhotoSelect ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property (strong,nonatomic) UIImagePickerController *imagepic;//控制器

@end

@implementation WPhotoSelect

+ (void) selectPhotoWithTarget:(UIViewController *)target
                        result:(void(^)(UIImage *image))result;
{
    WPhotoSelect *photo = [WPhotoSelect new];
    photo.imagepic = [[UIImagePickerController alloc] init];
    photo.imagepic.delegate = photo;
    photo.imagepic.view.backgroundColor = [UIColor whiteColor];

//    //设置图片获取方式
//    if (photo.type == WSelectPhotoSourceType_Photo) {
//
//        //设置打开照片相册类型(显示所有相簿)
//        photo.imagepic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    }else if (photo.type == WSelectPhotoSourceType_Library) {
//
//        //设置打开照片相册类型(显示所有相册)
//        photo.imagepic.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    }else if (photo.type == WSelectPhotoSourceType_Camera) {
//
//        //设置打开照片相册类型(显示相机)
//        photo.imagepic.sourceType = UIImagePickerControllerSourceTypeCamera;
//    }
//
//    [WCheckAuthor requestPhotoWithviewController:target handler:^(BOOL state) {
//
//        if (state) {
//
//            [target presentViewController:photo.imagepic animated:YES completion:nil];
//        }else{
//
//            [MessageTool showToast:@"请授权相册权限！"];
//        }
//    }];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:NO completion:nil];
    self.imageCallBack(info[UIImagePickerControllerEditedImage]);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [picker dismissViewControllerAnimated:NO completion:nil];
}

@end
