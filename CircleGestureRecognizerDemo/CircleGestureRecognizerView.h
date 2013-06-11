//
//  CircleGestureRecognizerView.h
//  CircleGestureRecognizerDemo
//
//  Created by Bogdan Weidmann on 10.06.13.
//  Copyright (c) 2013 nexiles. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleGestureRecognizer.h"

@interface CircleGestureRecognizerView : UIView

-(id)initWithFrame:(CGRect)frame andCircleGestureRecognizer:(CircleGestureRecognizer *)recognizer;

@end
