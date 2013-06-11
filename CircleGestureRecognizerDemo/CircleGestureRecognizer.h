//
//  CircleGestureRecognizer.h
//  CircleGestureRecognizerDemo
//
//  Created by Bogdan Weidmann on 10.06.13.
//  Copyright (c) 2013 nexiles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

typedef enum {
    CircleGestureRecognizerDirectionClockwise,
    CircleGestureRecognizerDirectionCounterClockwise
} CircleGestureRecognizerDirection;

@interface CircleGestureRecognizer : UIGestureRecognizer

@property (nonatomic, assign) CircleGestureRecognizerDirection direction;
@property (nonatomic, assign) CGFloat toleranceAngle; // Tolerance angle for matching start and end angle
@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, assign) CGPoint circleGestureCenter;

-(id)initWithTarget:(id)target action:(SEL)action andCircleCenter:(CGPoint)circleCenter;

@end
