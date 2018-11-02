//
//  ZDNProgressDisplayLink.h
//  _idx_AFNetworking_library_7E9C7F0A_ios_min8.0
//
//  Created by Duona Zhou on 9/25/18.
//

#import <QuartzCore/QuartzCore.h>
#import "ZDNAnimation.h"


@interface ZDNProgressDisplayLink : NSObject

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat absProgress;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) BOOL isStartWithFixDuration;

@property (nonatomic, assign) ZDNAnimationOptions animationOptions;

@property (nonatomic, copy) void (^progressBlock) (CGFloat);

@property (nonatomic, copy) void (^absProgressBlock) (CGFloat);

@property (nonatomic, copy) void (^completeBlock) (BOOL);

@property (nonatomic, strong) CADisplayLink *displayLink;

-(instancetype)initWithDuration:(CGFloat) duration;

- (void)beginFrom: (CGFloat)start to:(CGFloat)end;
    
@end
