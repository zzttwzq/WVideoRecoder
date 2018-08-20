//
//  WViedoPreviewAndEditVC.m
//  美丽吧
//
//  Created by 吴志强 on 2018/8/10.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "WViedoPreviewAndEditVC.h"
#import "WVideoPlayer.h"
#import "WVideoPreviewLayerListView.h"
#import "WVideoFilterListView.h"
//#import "HMOSSUploadHandler.h"
#import "WRecorderService.h"

@interface WViedoPreviewAndEditVC ()

@property (nonatomic,strong) UIView *need4G;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) WVideoPlayer *player;
@property (nonatomic,copy) NSString *previewImageUrl;

@end

@implementation WViedoPreviewAndEditVC

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [WDevice setStatueBarColorWihte:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    [WDevice setStatueBarColorWihte:NO];
    [self.player stop];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    _player = [[WVideoPlayer alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _player.showBackBtn = NO;
    _player.showFullScreenBtn = NO;
    [_player playWithUrl:_videoPath];
    _player.showInView = self.view;

    [self addNavigation];

    [self addPreview];

    [self addFilter];
}

- (void) addNavigation
{
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(15, 20, 50, 50)];
    _leftView.userInteractionEnabled = YES;
    _leftView.alpha = 1;
    [_leftView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.view addSubview:_leftView];


    UIImageView *complete = IMAGE_WITH_RECT(ScreenWidth-40, 35, 25, 25);
    complete.image = [UIImage imageNamed:@"Checked_icon_60x60"];
    complete.contentMode = UIViewContentModeScaleAspectFit;
    complete.userInteractionEnabled = YES;
    [complete addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(compeleteAndUploading)]];
    [self.view addSubview:complete];


    UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 20, 20)];
    leftImage.image = [UIImage imageNamed:@"shoot_close_icon"];
    [_leftView addSubview:leftImage];
}

- (void) compeleteAndUploading
{

    [_player stop];
//    [HMOSSUploadHandler uploadImg:_previewImage result:^(NSString *imageUrl) {
//
//        NSString *filePath = self.videoPath.absoluteString;
//        filePath = [filePath stringByReplacingOccurrencesOfString:@"file://" withString:@""];
//        float size = [HVideoCaptureService getFileSize:filePath];

//        [HMOSSUploadHandler uploadVideoWithPath:filePath result:^(NSString * _Nullable videoUrl) {
//
//            [MessageTool dismissLoading];
//
//            [self dismissViewControllerAnimated:NO completion:nil];
//            NSDictionary *data = @{
//                                   @"type":@"video",
//                                   @"imageUrl":imageUrl,
////                                   @"bili":[NSString stringWithFormat:@"%0.2f:%0.2f",self.previewImage.size.width,self.previewImage.size.height],
//                                   @"width":[NSString stringWithFormat:@"%0.2f",ScreenWidth],
//                                   @"height":[NSString stringWithFormat:@"%0.2f",ScreenHeight],
//                                   @"fileSize":[NSString stringWithFormat:@"%0.2f",size],
//                                   @"videoUrl":videoUrl
//                                   };
//
//            [WFileManager deleteFileAtPath:filePath];
//
//            if (self.callBack) {
//                self.callBack(data);
//            }
//        }];
//    }];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void) addPreview
{
}


- (void) addFilter
{
//    NSArray *array = @[];
//
//    WVideoFilterListView *view = [[WVideoFilterListView alloc] initWithArray:array];
//    view.backgroundColor = [UIColor whiteColor];
//    view.previewImage = nil;
//    view.click = ^(NSString *title) {
//
////        if (<#condition#>) {
////            <#statements#>
////        }
//    };
//
//    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
