//
//  JYClockView.m
//  JYClock
//
//  Created by joyann on 15/10/24.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "JYClockView.h"

/*
 实现时钟：在clock图片上添加三个layer，改变各自anchorPoint和position，并保证指针向上 -> 增加timer，每1秒触发一次handleTimer方法 -> 在handleTimer方法中计算当前的时间并拿到dateComponents -> 根据拿到的dateComponents来计算当前系统时间对应的角度 -> 将角度转换成弧度使三个layer旋转 -> 注意要在开始的时候调用handleTimer方法，因为这时设置表针初始的位置 -> 分针的旋转角度也会影响时针的旋转角度，所以在计算时针旋转角度的时候也要考虑分针旋转角度 -> 大致的原理就是根据系统时间计算时分秒针应该旋转的角度，每一秒都计算一次，每一秒都刷新它们旋转的角度
 */

static const CGFloat JYImageViewWH = 200.0f;
static const CGFloat JYSecondHandW = 1.0;
static const CGFloat JYSecondHandH = 80.0;
static const CGFloat JYMinuteHandW = 3.0;
static const CGFloat JYMinuteHandH = 70.0;
static const CGFloat JYHourHandW   = 5.0;
static const CGFloat JYHourHandH   = 60.0;

#define JYClockImageViewX (self.bounds.size.width * 0.5)
#define JYClockImageViewY (self.bounds.size.height * 0.5)
#define JYClockViewCenter (CGPointMake(JYClockImageViewX, JYClockImageViewY))

#define JYSecondTimerInterval 1.0

#define angleToRadian(angle)  ((angle) / 180.0 * M_PI)

#define secondHandAngle        6.0
#define minuteHandAngle        6.0
#define hourHandAngle          30.0
#define hourHandAnglePerMinute 0.5

@interface JYClockView ()
@property (nonatomic, weak) CALayer *secondHand;
@property (nonatomic, weak) CALayer *minuteHand;
@property (nonatomic, weak) CALayer *hourHand;
@end

@implementation JYClockView

#pragma mark - Init Methods

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

- (void)setUp
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, JYImageViewWH, JYImageViewWH)];
    imageView.center = CGPointMake(JYClockImageViewX, JYClockImageViewY);
    imageView.image = [UIImage imageNamed:@"钟表"];
    [self addSubview:imageView];
    
    [self addClockHands];
    [self handleTimeChanged:nil];
}

#pragma mark - Add Clock Hands

- (void)addClockHands
{
    // 增加时针
    CALayer *hourHand = [CALayer layer];
    hourHand.frame = CGRectMake(0, 0, JYHourHandW, JYHourHandH);
    hourHand.backgroundColor = [UIColor blackColor].CGColor;
    hourHand.anchorPoint = CGPointMake(0.5, 0.9);
    hourHand.position = JYClockViewCenter;
    [self.layer addSublayer:hourHand];
    self.hourHand = hourHand;
    // 增加分针
    CALayer *minuteHand = [CALayer layer];
    minuteHand.frame = CGRectMake(0, 0, JYMinuteHandW, JYMinuteHandH);
    minuteHand.backgroundColor = [UIColor blackColor].CGColor;
    minuteHand.anchorPoint = CGPointMake(0.5, 0.9);
    minuteHand.position = JYClockViewCenter;
    [self.layer addSublayer:minuteHand];
    self.minuteHand = minuteHand;
    // 增加秒针
    CALayer *secondHand = [CALayer layer];
    secondHand.frame = CGRectMake(0, 0, JYSecondHandW, JYSecondHandH);
    secondHand.backgroundColor = [UIColor redColor].CGColor;
    secondHand.anchorPoint = CGPointMake(0.5, 0.9);
    secondHand.position = JYClockViewCenter;
    [self.layer addSublayer:secondHand];
    self.secondHand = secondHand;
    
    [self addTimer];
    
}

#pragma mark - Add Timer

- (void)addTimer
{
    [NSTimer scheduledTimerWithTimeInterval:JYSecondTimerInterval target:self selector:@selector(handleTimeChanged:) userInfo:nil repeats:YES];
}

#pragma mark - Handle Time Changed

- (void)handleTimeChanged: (NSTimer *)timer
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    
    NSInteger second = components.second;
    CGFloat currentSecondAngle = secondHandAngle * second;
//    [self.secondHand setValue:@(angleToRadian(currentSecondAngle)) forKeyPath:@"transform.rotation.z"];
    self.secondHand.transform = CATransform3DMakeRotation(angleToRadian(currentSecondAngle), 0, 0, 1);
    
    NSInteger minute = components.minute;
    CGFloat currentMinuteAngle = minuteHandAngle * minute;
    [self.minuteHand setValue:@(angleToRadian(currentMinuteAngle)) forKeyPath:@"transform.rotation.z"];
    
    NSInteger hour = components.hour;
    CGFloat currentHourAngle = hourHandAngle * hour + minute * hourHandAnglePerMinute;
    [self.hourHand setValue:@(angleToRadian(currentHourAngle)) forKeyPath:@"transform.rotation.z"];
}

@end
