//
//  ZXTimerViewController.m
//  TomatoTimer
//
//  Created by Xiang on 15/11/17.
//  Copyright © 2015年 微加科技. All rights reserved.
//

#import "ZXTimerViewController.h"
#import "MZTimerLabel.h"
#import "UIView+XMGExtension.h"

@interface ZXTimerViewController ()

@property (strong, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation ZXTimerViewController

@synthesize easyTimer = _easyTimer;
@synthesize smallTimer = _smallTimer;

//static NSString* const kBWBarTitle = @"动态";
static int const standardTime = 1500;   // 标准时间25分钟

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupStartButton];
    
    easyTimer = [[MZTimerLabel alloc] initWithLabel:_easyTimer andTimerType:MZTimerLabelTypeTimer];
    [easyTimer setCountDownTime:standardTime];
    easyTimer.resetTimerAfterFinish = NO;
    easyTimer.delegate = self;
    easyTimer.font = [UIFont fontWithName:@"DS-Digital" size:60];
    easyTimer.timeFormat = @"mm:ss";
    
    smallTimer = [[MZTimerLabel alloc] initWithLabel:_smallTimer andTimerType:MZTimerLabelTypeTimer];
    [smallTimer setCountDownTime:standardTime];
    smallTimer.resetTimerAfterFinish = NO;
    smallTimer.delegate = self;
    smallTimer.font = [UIFont fontWithName:@"DS-Digital" size:40];
    smallTimer.timeFormat = @"SS";
}

- (void)setupStartButton {

    // 图片
    _startButton.imageView.centerX = _startButton.width * 0.5;
    // _startButton.imageView.x = 0;
    _startButton.imageView.y = 0;
    
    // 文字
    _startButton.titleLabel.x = 0;
    _startButton.titleLabel.y = _startButton.imageView.height;
    _startButton.titleLabel.width = _startButton.width;
    _startButton.titleLabel.height = _startButton.height - _startButton.imageView.height;
}

/**
 *  状态栏的样式
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    // 白色状态栏
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timerStart {
    if(![easyTimer counting] && ![smallTimer counting]){
        _startButton.hidden = YES;
        _easyTimer.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
        _smallTimer.textColor = [UIColor colorWithWhite:0.298 alpha:1.000];
        [easyTimer reset];
        [smallTimer reset];
        [easyTimer start];
        [smallTimer start];
    }
}

- (void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    NSString *msg = [NSString stringWithFormat:@"番茄时间计时完成!\n计时时间: %i 分钟",(int)countTime/60];
    if([timerLabel isEqual:easyTimer]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"再接再厉" message:msg delegate:nil cancelButtonTitle:@"恭喜完成!" otherButtonTitles:nil];
        [alertView show];
        
        _startButton.hidden = NO;
    }
}

// 时间小于5分钟时计时器变红
- (void)timerLabel:(MZTimerLabel *)timerLabel countingTo:(NSTimeInterval)time timertype:(MZTimerLabelType)timerType{
    if(time < 301) {
        timerLabel.timeLabel.textColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000];
    }
}

@end
