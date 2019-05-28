//
//  WVideoRecoderTheme.h
//  Pods-WVideoRecoder_Example
//
//  Created by 吴志强 on 2019/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WVideoRecoderTheme : NSObject
#pragma mark - 字体

+(UIFont *)getTinFont;

+(UIFont *)getSmallFont;

+(UIFont *)getNormalFont;

+(UIFont *)getLargeFont;

+(UIFont *)getSuperLargeFont;

+(UIFont *)getFontWithSize:(float)size;

+(UIFont *)getFontWithOutScreenAdjustSize:(CGFloat)size;

    // 商城专用方法,其他地方请勿使用
+ (UIFont *)getAutoAdjustFontForShopMallWithSize:(CGFloat)size;
+ (UIFont *)getFontWithOutAdjustForShopMallWithSize:(CGFloat)size;
+ (BOOL)isBigScreen;
    // 商城专用方法,其他地方请勿使用

#pragma mark - 颜色

+(UIColor *)getStarColor;

+(UIColor *)getNavgationBGColor;

+(UIColor *)getTabarTintColor;

+(UIColor *)getNormalColor;

+(UIColor *)getDetialColor;

+(UIColor *)getAlertColor;

+(UIColor *)getDarkAlertColor;

+(UIColor *)getPopBGColor;

+(UIColor *)getSearchBGColor;

+(UIColor *)getMessageUnReadColor;

+(UIColor *)getSepLineColor;

+(UIColor *)getSepLineLightColor;

+(UIColor *)getGoldenColor;

+(UIColor *)getButtonDisableColor;

+(UIColor *)getSepLineColor2;

@end

NS_ASSUME_NONNULL_END
