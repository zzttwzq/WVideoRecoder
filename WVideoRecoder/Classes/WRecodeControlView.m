//
//  WRecodeControlView.m
//  美丽吧
//
//  Created by 吴志强 on 2018/8/10.
//  Copyright © 2018年 吴志强. All rights reserved.
//

#import "WRecodeControlView.h"


@interface WRecodeControlView ()

@property (nonatomic,strong) WVideoHeaderView *header;
@property (nonatomic,strong) WVideoClickBtn *shootBtn;
@property (nonatomic,strong) WVideoBottomSelectView *selectView;

@property (nonatomic,assign) WRecordMode selectMode;

@property (nonatomic,strong) UILabel *currentTime;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int progressTime;

@property (nonatomic,assign) BOOL clickBtnEnable;

@end

@implementation WRecodeControlView

- (instancetype) init
{
    self = [super init];
    if (self) {

        self.selectMode = WRecordMode_PhotoFromeCamera;
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);

        WEAK_SELF(WRecodeControlView);

        //最上层的view
        _header = [WVideoHeaderView new];
        _header.callBack = ^(WVideoHeaderViewItem type, int state) {

            if ([weakSelf.delegate respondsToSelector:@selector(headerBtnClick:state:)]) {
                [weakSelf.delegate headerBtnClick:type state:state];
            }
        };
        [self addSubview:_header];

        //设置时间label
        _currentTime = LABEL_WITH_RECT(0, ScreenHeight-BottomHeight-60-120, ScreenWidth, 20);
        _currentTime.textColor = [UIColor whiteColor];
        _currentTime.font = [UIFont systemFontOfSize:15];
        _currentTime.textAlignment = NSTextAlignmentCenter;
        _currentTime.alpha = 0;
        [self addSubview:_currentTime];

        //拍摄按钮
        _shootBtn = [[WVideoClickBtn alloc] initWithYoffset:ScreenHeight-BottomHeight-60-90];
        _shootBtn.mode = WRecordMode_PhotoFromeCamera;
        _shootBtn.recordingState = ^(WRecordButtonState state) {

            if ([weakSelf.delegate respondsToSelector:@selector(recordBtnClickWithSate:withMode:)]) {
                [weakSelf.delegate recordBtnClickWithSate:state withMode:weakSelf.selectMode];
            }

            if (weakSelf.selectMode == WRecordMode_VideoFromeCamera){

                if (state == WRecordButtonState_Ready||
                    state == WRecordButtonState_Complelete) {

                    weakSelf.progressTime = weakSelf.maxSeconds;
                    [weakSelf.selectView setEnable:YES];
                    weakSelf.currentTime.text = [weakSelf convertTime:weakSelf.progressTime];
                    [weakSelf stopTimer];
                    weakSelf.progressTime = weakSelf.maxSeconds;
                }
                else if (state == WRecordButtonState_Recording) {

                    [weakSelf.selectView setEnable:NO];
                    [weakSelf startTimer];
                }
            }
        };
        [self addSubview:_shootBtn];


        //底层按钮
        NSArray *array = @[@"相册",@"拍照",@"拍视频"];
        _selectView = [[WVideoBottomSelectView alloc] initWithArray:array yoffset:ScreenHeight-BottomHeight-60 defaultIndex:1];
        _selectView.selectCallBack = ^(NSString *selectItem, NSInteger index) {

            if ([weakSelf.delegate respondsToSelector:@selector(modeChanged:)]) {
                [weakSelf.delegate modeChanged:index];
            }

            if (index != 0) {
                weakSelf.shootBtn.mode = index;
                weakSelf.selectMode = index;
            }

            if ([selectItem isEqualToString:@"拍视频"]) {
                weakSelf.currentTime.alpha = 1;
            }
            else{
                weakSelf.currentTime.alpha = 0;
            }
        };
        [self addSubview:_selectView];
    }
    return self;
}

- (void) setMaxSeconds:(float)maxSeconds
{
    _maxSeconds = maxSeconds;
    _progressTime = maxSeconds;
    _currentTime.text = [self convertTime:self.maxSeconds];
}


#pragma mark - 定时器
- (void) startTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scheduledTimer) userInfo:nil repeats:YES];
}

- (void) stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void) scheduledTimer
{
    if (self.progressTime == 0) {

        if ([self.delegate respondsToSelector:@selector(timeRunout)]) {
            [self.delegate timeRunout];
        }

        [self.selectView setEnable:YES];

        [self stopTimer];
        self.shootBtn.state = WRecordButtonState_Complelete;

        self.progressTime = self.maxSeconds;
        self.currentTime.text = [self convertTime:self.progressTime];
    }
    else{

        self.progressTime --;
        _currentTime.text = [self convertTime:self.progressTime];
    }
}


#pragma mark - 其他
/**
 转换成显示的时间

 @param second 秒数
 @return 返回转换后的字符串
 */
- (NSString *)convertTime:(CGFloat)second;
{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    }
    else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}
@end
