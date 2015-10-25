//
//  JYTestViewController.m
//  JYClock
//
//  Created by joyann on 15/10/24.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "JYTestViewController.h"

@interface JYTestViewController ()
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) CALayer *myLayer;
@end

@implementation JYTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    imageView.image = [UIImage imageNamed:@"钟表"];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(200, 200, 200, 200);
    layer.backgroundColor = [UIColor redColor].CGColor;
    self.myLayer = layer;
    [self.view.layer addSublayer:layer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [UIView animateWithDuration:1.0 animations:^{
////        self.imageView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1); // 相同角度默认顺时针 -> 之后按最短角度
////        [self.imageView.layer setValue:@(M_PI * 1.1) forKeyPath:@"transform.rotation.z"]; // 相同默认顺时针 -> 之后按最短角度 与上面相同
//    }];
    
//    [UIView animateWithDuration:1.0 animations:^{
//        self.myLayer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1); // 角度相同默认逆时针 -> 之后按最短角度
//        [self.myLayer setValue:@(M_PI) forKeyPath:@"transform.rotation.z"]; //角度相同默认顺时针 -> 之后按最短角度
//    }];
    
//    self.myLayer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1); // 角度相同逆时针 -> 之后按最短角度
//    [self.myLayer setValue:@(M_PI) forKeyPath:@"transform.rotation.z"]; // 角度相同顺时针 -> 之后按最短角度
}

@end
