//
//  ViewController.m
//  JYClock
//
//  Created by joyann on 15/10/24.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "ViewController.h"
#import "JYClockView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addClockView];
}

#pragma mark - Add Clock View

- (void)addClockView
{
    JYClockView *clockView = [[JYClockView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:clockView];
}


@end
