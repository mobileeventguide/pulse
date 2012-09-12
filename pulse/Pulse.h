//
//  Pulse.h
//
//  Copyright (c) 2012 Mobile Event Guide GmbH. All rights reserved.

// utility class to invoke selector on instance at intervals and prevent NSTimer retain cycles

#import <Foundation/Foundation.h>

@interface PulseInfo : NSObject
@property (nonatomic, retain) NSTimer * timer;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;
@end

@interface Pulse : NSObject

+ (void) pulse:(id)target every:(NSTimeInterval)seconds withSelector:(SEL)selector;
+ (void) stopPulsing:(id)target;

@end
