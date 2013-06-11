//
//  CircleGestureRecognizer.m
//  CircleGestureRecognizerDemo
//
//  Created by Bogdan Weidmann on 10.06.13.
//  Copyright (c) 2013 nexiles. All rights reserved.
//

#import "CircleGestureRecognizer.h"

@interface CircleGestureRecognizer()

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign, getter = isReadyToSucceed) BOOL readyToSucceed;

@end

@implementation CircleGestureRecognizer

-(id)initWithTarget:(id)target action:(SEL)action andCircleCenter:(CGPoint)circleCenter {
    if (self = [super initWithTarget:target action:action]) {
        // Set default property values
        self.direction = CircleGestureRecognizerDirectionClockwise;
        self.toleranceAngle = M_PI / 3.0; // 60 degrees tolerance of matching startAngle and endAngle
        self.timeout = 2;
        self.circleGestureCenter = circleCenter;
    }
    
    return self;
}

-(id)initWithTarget:(id)target action:(SEL)action {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    return [self initWithTarget:target action:action andCircleCenter:CGPointMake(screenBounds.origin.x + screenBounds.size.width / 2.0, screenBounds.origin.y + screenBounds.size.height / 2.0)];
}

-(void)reset {
    [self setReadyToSucceed:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self performSelector:@selector(setState:) withObject:[NSNumber numberWithInteger:UIGestureRecognizerStateFailed] afterDelay:self.timeout];
    
    CGPoint touchPoint = [touches.anyObject locationInView:self.view.superview];
    
    self.startAngle = atan2f(touchPoint.y - self.circleGestureCenter.y, touchPoint.x - self.circleGestureCenter.x);
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    CGPoint currentTouchLocation = [touches.anyObject locationInView:self.view.superview];
    CGPoint previousTouchLocation = [touches.anyObject previousLocationInView:self.view.superview];
    CGPoint center = self.circleGestureCenter;
    
    CGFloat currentAngle = atan2f(currentTouchLocation.y - center.y, currentTouchLocation.x - center.x);
    CGFloat previousAngle = atan2f(previousTouchLocation.y - center.y, previousTouchLocation.x - center.x);
    
    CGFloat comparingAnglesTolerance = M_PI / 20.0;
    
    if (self.direction == CircleGestureRecognizerDirectionClockwise) {
        if (currentAngle < 0 && previousAngle > 0) { // Two points lay beside the x-axis
            // To compare them correctly, we need to change the sign of previous angle.
            previousAngle -= 2 * M_PI;
        }
        
        if (currentAngle + comparingAnglesTolerance < previousAngle) { // We are moving against possible direction
            [self setState:UIGestureRecognizerStateFailed];
        }
    } else {
        if (currentAngle > 0 && previousAngle < 0) {
            currentAngle -= 2 * M_PI;
        }
        
        if (currentAngle - comparingAnglesTolerance > previousAngle) {
            [self setState:UIGestureRecognizerStateFailed];
        }
    }
    
    if (!self.isReadyToSucceed) {
        CGFloat myStartAngle = self.startAngle;
        // To be able to compare angle values, we need to make sure they have the same sign
        if (currentAngle > 0 && myStartAngle < 0) {
            currentAngle -= 2 * M_PI;
        } else if (currentAngle < 0 && myStartAngle > 0) {
            myStartAngle -= 2 * M_PI;
        }
        
        // To avoid interpreting a tap gesture as a circle gesture, we need to require a 180 degrees arc to recognize before letting
        // gesture recognizer to succeed
        if (fabsf(currentAngle - myStartAngle) > M_PI) {
            [self setReadyToSucceed:YES];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint currentTouchLocation = [touches.anyObject locationInView:self.view.superview];
    CGPoint center = self.circleGestureCenter;
    CGFloat currentAngle = atan2f(currentTouchLocation.y - center.y, currentTouchLocation.x - center.x);
    
    if (currentAngle > M_PI_2 && self.startAngle < -M_PI_2) {
        currentAngle -= 2 * M_PI;
    } else if (currentAngle < -M_PI_2 && self.startAngle > M_PI_2) {
        self.startAngle -= 2 * M_PI;
    }
    
    if (fabsf(currentAngle - self.startAngle) < self.toleranceAngle && self.isReadyToSucceed) {
        [self setState:UIGestureRecognizerStateRecognized];
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [super touchesEnded:touches withEvent:event];
    } else {
        [self setState:UIGestureRecognizerStateFailed];
    }
}

@end
