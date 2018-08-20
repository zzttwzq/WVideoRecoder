//
//  WPhotoPreviewVCViewController.m
//  美丽吧
//
//  Created by 吴志强 on 2018/8/10.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "WPhotoPreviewVCViewController.h"
#import "WRecorderService.h"
//#import "HMOSSUploadHandler.h"

@interface WPhotoPreviewVCViewController ()

@property (nonatomic,strong) UIImageView *imageview;
@property (nonatomic,strong) UIView *leftView;

@end


@implementation WPhotoPreviewVCViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [WDevice setStatueBarColorWihte:YES];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [WDevice setStatueBarColorWihte:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _imageview = IMAGE_WITH_RECT(0, -5, ScreenWidth, ScreenHeight+10);
    _imageview.contentMode = UIViewContentModeScaleAspectFill;
    _imageview.backgroundColor = [UIColor redColor];
    _imageview.image = self.image;
    [self.view addSubview:_imageview];


    _leftView = [[UIView alloc] initWithFrame:CGRectMake(15, 20, 50, 50)];
    _leftView.userInteractionEnabled = YES;
    _leftView.alpha = 1;
    [_leftView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.view addSubview:_leftView];


    UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 15, 20, 20)];
    leftImage.image = [UIImage imageNamed:@"shoot_close_icon"];
    [_leftView addSubview:leftImage];


    UIImageView *complete = IMAGE_WITH_RECT(ScreenWidth-40, 35, 25, 25);
    complete.image = [UIImage imageNamed:@"Checked_icon_60x60"];
    complete.contentMode = UIViewContentModeScaleAspectFit;
    complete.userInteractionEnabled = YES;
    [complete addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(compeleteAndUploading)]];
    [self.view addSubview:complete];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) compeleteAndUploading
{
//    [HMOSSUploadHandler uploadImg:_image result:^(NSString *string) {
//
//        [self dismissViewControllerAnimated:NO completion:nil];
//
//        if (self.callBack) {
//            self.callBack(string);
//        }
//    }];
}
@end
