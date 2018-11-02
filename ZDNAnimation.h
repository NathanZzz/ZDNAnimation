//
//  ZDNAnimation.h
//  _idx_AFNetworking_library_7E9C7F0A_ios_min8.0
//
//  Created by Duona Zhou on 10/12/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_OPTIONS(NSUInteger, ZDNAnimationOptions) {
    ZDNAnimationOptionLinear            = 1 <<  0,
    ZDNAnimationOptionCubic,
    ZDNAnimationOptionEaseInOutQuart
} NS_ENUM_AVAILABLE_IOS(4_0);

@interface ZDNAnimation : NSObject


+ (double) animationWithType: (ZDNAnimationOptions)type time:(double)t begin:(double)b change:(double)c duration:(double)d;

+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(double progress))animations completion:(void (^ __nullable)(BOOL finished))completion; 


+(CGFloat) calculateCurrentValueWithProgress:(CGFloat)progress start:(CGFloat)start final:(CGFloat)final;
+(CGRect) calculateCurrentRectWithProgress:(CGFloat)progress start:(CGRect)start final:(CGRect)final;

//+ (double) easeInOutQuart: (double)t begin:(double)b change:(double)c duration:(double)d;

@end
