//
//  CircleGestureRecognizerView.m
//  CircleGestureRecognizerDemo
//
//  Created by Bogdan Weidmann on 10.06.13.
//  Copyright (c) 2013 nexiles. All rights reserved.
//

#import "CircleGestureRecognizerView.h"

@interface CircleGestureRecognizerView()

@property (nonatomic, strong) CircleGestureRecognizer* myCircleGestureRecognizer;

@end

@implementation CircleGestureRecognizerView

-(id)initWithFrame:(CGRect)frame andCircleGestureRecognizer:(CircleGestureRecognizer *)recognizer {
    if (self = [super initWithFrame:frame]) {
        self.myCircleGestureRecognizer = recognizer;
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Draw tolerance region
    CGFloat toleranceRegionRadius = sqrtf(powf(self.myCircleGestureRecognizer.view.bounds.size.width, 2) + powf(self.myCircleGestureRecognizer.view.bounds.size.height, 2)) / 2.0;
    CGFloat angleOffset = -1.3;
    CGContextAddArc(context, self.myCircleGestureRecognizer.circleGestureCenter.x, self.myCircleGestureRecognizer.circleGestureCenter.y, toleranceRegionRadius, angleOffset, angleOffset + self.myCircleGestureRecognizer.toleranceAngle, NO);
    CGContextAddLineToPoint(context, self.myCircleGestureRecognizer.circleGestureCenter.x, self.myCircleGestureRecognizer.circleGestureCenter.y);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextFillPath(context);
    
    // Draw center point
    CGFloat radius = 10;
    CGContextAddArc(context, self.myCircleGestureRecognizer.circleGestureCenter.x, self.myCircleGestureRecognizer.circleGestureCenter.y, radius, 0, 2 * M_PI, YES);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillPath(context);
    
    // Draw circle with arrow
    CGFloat circleRadius = self.myCircleGestureRecognizer.view.bounds.size.width / 4.0;
    CGContextAddArc(context, self.myCircleGestureRecognizer.circleGestureCenter.x, self.myCircleGestureRecognizer.circleGestureCenter.y, circleRadius, 0, 2 * M_PI, YES);
    CGContextSetStrokeColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextSetLineWidth(context, 5);
    CGContextStrokePath(context);
    
    if (self.myCircleGestureRecognizer.direction == CircleGestureRecognizerDirectionClockwise) { // Draw arrow on the bottom to the left
        CGContextMoveToPoint(context, self.myCircleGestureRecognizer.circleGestureCenter.x + 5, self.myCircleGestureRecognizer.circleGestureCenter.y + circleRadius - 5);
        CGContextAddLineToPoint(context, self.myCircleGestureRecognizer.circleGestureCenter.x - 5, self.myCircleGestureRecognizer.circleGestureCenter.y + circleRadius);
        CGContextAddLineToPoint(context, self.myCircleGestureRecognizer.circleGestureCenter.x + 5, self.myCircleGestureRecognizer.circleGestureCenter.y + circleRadius + 5);
    } else { // Draw arrow on the bottom to the rigth
        CGContextMoveToPoint(context, self.myCircleGestureRecognizer.circleGestureCenter.x - 5, self.myCircleGestureRecognizer.circleGestureCenter.y + circleRadius - 5);
        CGContextAddLineToPoint(context, self.myCircleGestureRecognizer.circleGestureCenter.x + 5, self.myCircleGestureRecognizer.circleGestureCenter.y + circleRadius);
        CGContextAddLineToPoint(context, self.myCircleGestureRecognizer.circleGestureCenter.x - 5, self.myCircleGestureRecognizer.circleGestureCenter.y + circleRadius + 5);
    }
    
    CGContextStrokePath(context);
    
    // Draw instructions
    NSString *instructions = [NSString stringWithFormat:@"Make a circle gesture within %.1f seconds starting and ending touches in yellow sector", self.myCircleGestureRecognizer.timeout];
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite:0.7 alpha:1.0].CGColor);
    [instructions drawInRect:CGRectMake(0, 0, 200, 400) withFont:[UIFont boldSystemFontOfSize:16] lineBreakMode:NSLineBreakByTruncatingTail];
}

@end
