//
//  WVideoRecoderTheme.m
//  Pods-WVideoRecoder_Example
//
//  Created by 吴志强 on 2019/2/21.
//

#import "WVideoRecoderTheme.h"

@implementation WVideoRecoderTheme
#pragma mark - 字体

+(UIFont *)getTinFont;
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:10/Fit_WIDTH];
}

+(UIFont *)getSmallFont;
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:13/Fit_WIDTH];
}

+(UIFont *)getNormalFont;
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:15/Fit_WIDTH];
}

+(UIFont *)getLargeFont;
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:17/Fit_WIDTH];
}

+(UIFont *)getFontWithSize:(float)size;
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size/Fit_WIDTH];
}

+(UIFont *)getFontWithOutScreenAdjustSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:size];
}


+(UIFont *)getSuperLargeFont;
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:20/Fit_WIDTH];
}

+ (UIFont *)getAutoAdjustFontForShopMallWithSize:(CGFloat)size
{
        // 小于380的 就是 6 5 4 不带plus
    if ([UIScreen mainScreen].bounds.size.width <= 380) {
        return [UIFont fontWithName:@"HelveticaNeue-Light" size: size];
    }else{
        return [UIFont fontWithName:@"HelveticaNeue-Light" size: size + 1.0];
    }
        // 小于380的 就是 6 5 4 不带plus
        //    if ([UIScreen mainScreen].bounds.size.width <= 380) {
        //        return [UIFont systemFontOfSize:size];
        //    }else{
        //        return [UIFont systemFontOfSize:size + 1];
        //    }

}
+ (UIFont *)getFontWithOutAdjustForShopMallWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size: size];
        //    return [UIFont systemFontOfSize:size];
}

+ (BOOL)isBigScreen{
    if ([UIScreen mainScreen].bounds.size.width <= 380) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 颜色

+(UIColor *)getNavgationBGColor;
{
    return [UIColor colorWithHexString:@"303030"];
}

+(UIColor *)getTabarTintColor;
{
    return [UIColor colorWithHexString:@"bc9346"];
}

+(UIColor *)getNormalColor;
{
    return [UIColor colorWithHexString:@"323232"];
}

+(UIColor *)getDetialColor;
{
    return [UIColor colorWithHexString:@"a8a8a8"];
}

+(UIColor *)getStarColor;
{
    return [UIColor colorWithHexString:@"e1bd87"];
}

+(UIColor *)getAlertColor;
{
    return [UIColor colorWithHexString:@"c7322b"];
}

+(UIColor *)getDarkAlertColor;
{
    return [UIColor colorWithHexString:@"b4282d"];
}

+(UIColor *)getSearchBGColor;
{
    return [UIColor colorWithHexString:@"f0f0f0"];
}

+(UIColor *)getPopBGColor;
{
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
}

+(UIColor *)getMessageUnReadColor;
{
    return [UIColor colorWithHexString:@"666666"];
}

+(UIColor *)getSepLineColor;
{
    return [UIColor colorWithHexString:@"d6d7dc"];
}

+(UIColor *)getSepLineColor2;
{
    return [UIColor colorWithHexString:@"fefefe"];
}

+(UIColor *)getSepLineLightColor;
{
    return [UIColor colorWithHexString:@"e6e6e6"];
}

+(UIColor *)getGoldenColor;
{
    return [UIColor colorWithHexString:@"bc9346"];
}

+(UIColor *)getButtonDisableColor;
{
    return [UIColor colorWithHexString:@"cccccc"];
}
@end
