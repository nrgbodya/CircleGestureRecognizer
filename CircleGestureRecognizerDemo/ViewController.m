//
//  ViewController.m
//  CircleGestureRecognizerDemo
//
//  Created by Bogdan Weidmann on 10.06.13.
//  Copyright (c) 2013 nexiles. All rights reserved.
//

#import "ViewController.h"
#import "CircleGestureRecognizer.h"
#import "CircleGestureRecognizerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CircleGestureRecognizer *recognizer = [[CircleGestureRecognizer alloc] initWithTarget:self action:@selector(recognized:) andCircleCenter:self.view.center];
    recognizer.timeout = 1.5;
    recognizer.direction = CircleGestureRecognizerDirectionCounterClockwise;
    recognizer.toleranceAngle = M_PI_4;
    
    CircleGestureRecognizerView *myView = [[CircleGestureRecognizerView alloc] initWithFrame:self.view.bounds andCircleGestureRecognizer:recognizer];
    [self.view addSubview:myView];
    [myView addGestureRecognizer:recognizer];
}

- (void)recognized:(CircleGestureRecognizer *)recognizer {
    NSLog(@"Circle gesture successfully recognized");
}

@end
