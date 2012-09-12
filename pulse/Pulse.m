//
//  Pulse.m
//
//  Copyright (c) 2012 Mobile Event Guide GmbH. All rights reserved.

#import "Pulse.h"

@implementation PulseInfo
@synthesize timer=_timer;
@synthesize selector=_selector;
@synthesize target=_target;
- (void)dealloc
{
    [_timer release];
    [super dealloc];
}
@end

@interface Pulse ()
@property (nonatomic, retain) NSMutableArray * pulseInfos;
@end

@implementation Pulse
@synthesize pulseInfos=_pulseInfos;

#pragma mark - Singleton instantiation
+ (Pulse *)sharedInstance
{
    static Pulse *_sharedInstance;

    @synchronized(self)
    {
        if (!_sharedInstance)
            _sharedInstance = [[Pulse alloc] init];

        return _sharedInstance;
    }
}

+ (void)pulse:(id)target every:(NSTimeInterval)seconds withSelector:(SEL)selector
{
    PulseInfo * pulseInfo = [[[PulseInfo alloc] init] autorelease];
    pulseInfo.target=target;
    pulseInfo.selector=selector;
    pulseInfo.timer = [NSTimer scheduledTimerWithTimeInterval:seconds target:[self sharedInstance] selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[self sharedInstance].pulseInfos addObject:pulseInfo];
}

+ (void)stopPulsing:(id)target
{
    NSMutableArray * infosToRemove = [NSMutableArray array];
    for (PulseInfo * pulseInfo in [self sharedInstance].pulseInfos)
    {
        if (pulseInfo.target == target)
        {
            [pulseInfo.timer invalidate];
            [infosToRemove addObject:pulseInfo];
        }
    }

    [[self sharedInstance].pulseInfos removeObjectsInArray:infosToRemove];
}

#pragma mark - timer fired
- (void) timerFired:(NSTimer *)timer
{
    for (PulseInfo * pulseInfo in self.pulseInfos)
    {
        if (pulseInfo.timer == timer)
        {
            [pulseInfo.target performSelector:pulseInfo.selector];
        }
    }
}

#pragma mark - init
- (id)init
{
    self =[super init];
    if (self)
    {
        self.pulseInfos = [NSMutableArray array];
    }
    return self;
}
@end
