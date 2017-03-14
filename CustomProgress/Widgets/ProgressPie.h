//
//  ProgressPie.h
//  CustomProgress
//
//  Created by 燕文强 on 17/3/14.
//  Copyright © 2017年 燕文强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbsProgressView.h"


/**
 饼状进度条
 */
@interface ProgressPie : AbsProgressView

+ (id)initWithStartAngle:(float)startAngle
              andBgColor:(UIColor *)bgColor
          andBorderColor:(UIColor *)borderColor
          andCircleColor:(UIColor *)circleColor
        andProgressColor:(UIColor *)progressColor;

// 开始的角度
@property (nonatomic,assign) float startAngle;
// 边框色
@property (nonatomic,copy) UIColor *borderColor;
// 圆的颜色
@property (nonatomic,copy) UIColor *circleColor;
// 进度色
@property (nonatomic,copy) UIColor *progressColor;


@end
