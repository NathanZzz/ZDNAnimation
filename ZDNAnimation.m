//
//  ZDNAnimation.m
//  _idx_AFNetworking_library_7E9C7F0A_ios_min8.0
//
//  Created by Duona Zhou on 10/12/18.
//

#import "ZDNAnimation.h"
#import "ZDNProgressDisplayLink.h"

@implementation ZDNAnimation


+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(double progress))animations completion:(void (^ __nullable)(BOOL finished))completion{
    
    ZDNProgressDisplayLink *link = [[ZDNProgressDisplayLink alloc] initWithDuration:duration];
    link.absProgressBlock = ^(CGFloat progress) {
        animations(progress);
    };
    [link beginFrom:0 to:1];
    link.completeBlock = ^(BOOL finished) {
        if (completion){
            completion(finished);
        }
    };
    
}

+ (double) animationWithType: (ZDNAnimationOptions)type time:(double)t begin:(double)b change:(double)c duration:(double)d{
    switch (type) {
        case ZDNAnimationOptionLinear:
            return [ZDNAnimation linear:t begin:b change:c duration:d];
        case ZDNAnimationOptionCubic:
            return [ZDNAnimation easeInOutCubic:t begin:b change:c duration:d];
        case ZDNAnimationOptionEaseInOutQuart:
            return [ZDNAnimation easeInOutQuart:t begin:b change:c duration:d];
        default:
            break;
    }
}

+ (double) easeInOutQuart: (double)t begin:(double)b change:(double)c duration:(double)d {
    double delta = t / (d / 2);
    if (delta < 1) return c/2*delta*delta*delta*delta + b;
    delta -= 2;
    return -c/2 * (delta*delta*delta*delta - 2) + b;
};

+ (double) easeInOutCubic: (double)t begin:(double)b change:(double)c duration:(double)d {
    double delta = t /( d/2);
    if (delta < 1) return c/2*delta*delta*delta + b;
    delta -= 2;
    return c/2*(delta*delta*delta + 2) + b;
};

+ (double) linear: (double)t begin:(double)b change:(double)c duration:(double)d {
    return c*t/d + b;
};



+(CGFloat) calculateCurrentValueWithProgress:(CGFloat)progress start:(CGFloat)start final:(CGFloat)final{
    return start + (final - start) * progress;
}

+(CGRect) calculateCurrentRectWithProgress:(CGFloat)progress start:(CGRect)start final:(CGRect)final{
    return CGRectMake(
                      [self calculateCurrentValueWithProgress:progress start:start.origin.x final:final.origin.x],
                      [self calculateCurrentValueWithProgress:progress start:start.origin.y final:final.origin.y],
                      [self calculateCurrentValueWithProgress:progress start:start.size.width final:final.size.width],
                      [self calculateCurrentValueWithProgress:progress start:start.size.height final:final.size.height]
                      );
}

@end
