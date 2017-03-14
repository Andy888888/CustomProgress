//
//  ViewController.m
//  CustomProgress
//
//  Created by 燕文强 on 17/3/14.
//  Copyright © 2017年 燕文强. All rights reserved.
//

#import "ViewController.h"
#import "ProgressPie.h"

@interface ViewController ()<ProgressDelegate>
{
    ProgressPie *_progress;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progress = [[ProgressPie alloc]init];
//    _progress =[ProgressPie initWithStartAngle:0
//                                    andBgColor:[UIColor brownColor]
//                                andBorderColor:[UIColor cyanColor]
//                                andCircleColor:[UIColor grayColor]
//                              andProgressColor:[UIColor redColor]];
    _progress.delegate = self;
    _progress.frame = CGRectMake(50, 50, 200, 200);
    [self.view addSubview:_progress];
    
    
    //添加按钮
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"开始" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(50, 450, 60, 40);
    [btn addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)butClick
{
    [_progress changeProgress:0];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i <= 100; i++) {
            [NSThread sleepForTimeInterval:0.1];
            [_progress changeProgressRunOnMainThread:i];
        }
    });
}

- (void)finished
{
    NSLog(@"完成");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
