//
//  ProgressPie.m
//  CustomProgress
//
//  Created by 燕文强 on 17/3/14.
//  Copyright © 2017年 燕文强. All rights reserved.
//

#import "ProgressPie.h"

#define PI 3.14159265358979323846

@implementation ProgressPie
{
    float _centerX;
    float _centerY;
    float _radius;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        self.startAngle = 0;
        self.bgColor = [UIColor whiteColor];
        self.borderColor = [UIColor cyanColor];
        self.circleColor = [UIColor grayColor];
        self.progressColor = [UIColor redColor];
        
        self.padding = 5;
        [self setValue:@"100" forKeyPath:@"fullProgress"];
    }
    return self;
}

+ (id)initWithStartAngle:(float)startAngle
              andBgColor:(UIColor *)bgColor
          andBorderColor:(UIColor *)borderColor
          andCircleColor:(UIColor *)circleColor
        andProgressColor:(UIColor *)progressColor
{
    ProgressPie *progressPie = [[ProgressPie alloc]init];
    
    progressPie.startAngle = startAngle;
    progressPie.bgColor = bgColor;
    progressPie.borderColor = borderColor;
    progressPie.circleColor = circleColor;
    progressPie.progressColor = progressColor;
    
    return progressPie;
}

-(void)changeProgress:(int)progress
{
    self.progress = progress;
    [self setNeedsDisplay];
}

- (void)measure
{
    _centerX = self.frame.size.width / 2;
    _centerY = self.frame.size.height / 2;
    
    _radius = _centerY;
    if(_centerY > _centerX){
        _radius = _centerX;
    }
    
    _radius = _radius - self.padding;
}

- (void)drawRect:(CGRect)rect
{
    [self measure];
    
    // 获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    
    // 矩形背景色
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, self.bgColor.CGColor);
    CGContextSetStrokeColorWithColor(context, self.bgColor.CGColor);
    CGContextFillRect(context,CGRectMake(0, 0, self.frame.size.width, self.frame.size.height));
    
    // 边框圆
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextSetFillColorWithColor(context, self.borderColor.CGColor);
    CGContextSetLineWidth(context, 3.0);//线的宽度
    CGContextAddArc(context, _centerX, _centerY, _radius, 0, 2*PI, 0);
    CGContextDrawPath(context, kCGPathStroke);
    // 背景圆
    CGContextSetFillColorWithColor(context, self.circleColor.CGColor);
    CGContextSetLineWidth(context, 0);//线的宽度
    CGContextAddArc(context, _centerX, _centerY, _radius, 0, 2*PI, 0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // 计算结束角度
    float curAngle = 0;
    if(self.fullProgress == self.progress){
        curAngle = 360;
        if(self.delegate){
            [self.delegate finished];
        }
    }else{
        float persent = self.progress / self.fullProgress;
        curAngle = 360 * persent;
    }
    float endAngle = self.startAngle + curAngle;
    
    // 画扇形进度
    CGContextSetFillColorWithColor(context, self.progressColor.CGColor);
    // 以10为半径围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, _centerX, _centerY);
    CGContextAddArc(context, _centerX, _centerY, _radius,  self.startAngle * PI / 180, endAngle * PI / 180, 0);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    CGContextStrokePath(context);
}

@end
