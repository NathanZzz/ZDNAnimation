//
//  ZDNProgressDisplayLink.m
//  _idx_AFNetworking_library_7E9C7F0A_ios_min8.0
//
//  Created by Duona Zhou on 9/25/18.
//

#import "ZDNProgressDisplayLink.h"


@interface ZDNProgressDisplayLink()

@property (nonatomic, assign) double endProgress;

@property (nonatomic, assign) double startProgress;

@property (nonatomic, assign) BOOL didStart;

@property (nonatomic, assign) CFAbsoluteTime startTime;

@property (nonatomic, assign) CFAbsoluteTime endTime;

@end

@implementation ZDNProgressDisplayLink


-(instancetype)initWithDuration:(CGFloat) duration{
    self = [super init];
    if (self){
        self.duration = duration;
        self.didStart = NO;
        self.endProgress = 1;
        self.isStartWithFixDuration = NO;
    }
    return self;
}

- (void)beginFrom: (CGFloat)start to:(CGFloat)end{
    self.startProgress = start;
    self.endProgress = end;
    self.progress = self.startProgress;
    [self begin];
}

- (void)begin{
    if (self.displayLink == nil){
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handler:)];
        self.startTime = CFAbsoluteTimeGetCurrent();
        if (self.isStartWithFixDuration){
            self.endTime = self.startTime + self.duration;
        }else{
            if(self.endProgress > self.startProgress){
                self.endTime = self.startTime + (self.endProgress - self.startProgress) * self.duration;
            }else if (self.endProgress < self.startProgress){
                self.endTime = self.startTime + (self.startProgress - self.endProgress) * self.duration;
            }else{
                self.endTime = self.startTime;
            }
        }
    }
    if (!self.didStart){
        self.didStart = YES;
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    }
    self.absProgress = 0;
}

- (void)stop{
    [self.displayLink invalidate];
    self.displayLink = nil;
    self.didStart = NO;
    
    if(self.completeBlock != nil){
        self.completeBlock(YES);
    }
}


-(void)setProgress:(CGFloat)progress{
    if (_progress != progress){
        _progress = progress;
        if (self.progressBlock != nil){
            self.progressBlock(self.progress);
        }
    }
}

-(void)setAbsProgress:(CGFloat)absProgress{
    if (_absProgress != absProgress){
        _absProgress = absProgress;
        if (self.absProgressBlock != nil){
            self.absProgressBlock(self.absProgress);
        }
    }
}
- (void)handler: (CADisplayLink *)displayLink {
    CFAbsoluteTime currentMoment = CFAbsoluteTimeGetCurrent();
    if (currentMoment <= self.endTime){
        double elapsed = currentMoment - self.startTime;
        
        
        if (self.progress != self.endProgress){
            if(self.endProgress > self.startProgress){
                self.progress = self.startProgress + elapsed / self.duration;
                if (self.progress > self.endProgress){
                    self.progress = self.endProgress;
                }
            }else if (self.endProgress < self.startProgress){
                self.progress = self.startProgress - elapsed / self.duration;
                if (self.progress < self.endProgress){
                    self.progress = self.endProgress;
                }
            }
        }
        
        if (self.absProgress < 1){
            self.absProgress = elapsed / (self.endTime - self.startTime);
            if (self.absProgress > 1){
                self.absProgress = 1;
            }
        }
    }else{
        self.progress = self.endProgress;
        [self stop];
    }
}

@end
