//
//  LinStatusHUD.m
//  LinStatusHUD
//
//  Created by 西乡流水 on 17/4/3.
//  Copyright © 2017年 西乡流水. All rights reserved.
//

#import "LinStatusHUD.h"

@interface LinStatusHUD ()

@end

@implementation LinStatusHUD

static NSTimer *timer_;
static UIWindow *window_;

/** window出现时间 + 逗留时间 */
static CGFloat const StayDuration = 1.75;

/** window出现和隐藏的动画时长 */
static CGFloat const AnimationDuration = 0.25;

/** 图片和文字之间的间距 */
static CGFloat const TitleImageMargin = 10.0;

/** navigationBarType情况下wendow显示的Y值*/
static CGFloat const NavigationBarY = 64;

/** navigationBarType情况下wendow显示的高度*/
static CGFloat const HUDDefautHeight = 44;

/** 记录当前显示的类型*/
static  LinShowFrameType showType = statusBarType;

+ (instancetype)statusHud
{
    return [[super alloc] init];
}

#pragma mark - 私有方法
- (void)setupText:(NSString *)text image:(UIImage *)image withType:(LinShowFrameType)type
{
    showType = type;
    CGRect windowF = (type == navigationBarType ? [self navigationBarFame] : [self statusBarFrame]);
    // 创建
    window_ = [[UIWindow alloc] init];
    window_.frame = windowF;
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = (type == statusBarType ? NO : YES);
    window_.backgroundColor = self.hudColor;
    
    // 添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = window_.bounds;
    [window_ addSubview:button];
    
    // 设置按钮数据
    [button setTitle:text forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    
    // 其他设置
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    if (image) {
        button.titleEdgeInsets = UIEdgeInsetsMake(0, TitleImageMargin, 0, 0);
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, TitleImageMargin);
    }
    
    [self showWithWindowFrame:windowF];
}

-(UIColor *)hudColor
{
    if ([self.delegate respondsToSelector:@selector(setupHudBackGroundColorWithHud:)])
    {
        return  [self.delegate setupHudBackGroundColorWithHud:self];
    }
    
    return (_hudColor == nil) ? (showType == navigationBarType ? [UIColor redColor] : [UIColor blackColor]) : _hudColor;
}

/**
 获取navigationBarType的frame

 @return 返回navigationBarType的frame
 */
 -(CGRect)navigationBarFame
{
    CGFloat height = ([self.delegate respondsToSelector:@selector(heightForHud:)]) ?  [self.delegate heightForHud:self] : HUDDefautHeight;
    
    return CGRectMake(0, NavigationBarY,[UIScreen mainScreen].bounds.size.width , height);
}

/**
 获取statusBarType的frame
 
 @return 返回statusBarType的frame
 */
 -(CGRect)statusBarFrame
{
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    
    return statusBarFrame;
}

 -(void)navigationShowStyleWithWindowFrame:(CGRect)windowF
{
    window_.hidden = NO;
    CGRect beginWindowF = windowF;
    beginWindowF.size.height = 0.001f;
    window_.frame = beginWindowF;
    
    [UIView animateWithDuration:AnimationDuration animations:^{
        window_.frame = windowF;
    }];
}

// window出现的动画
 -(void)statusBarShowStyleWithWindowFrame:(CGRect)windowF
{
    CGRect beginWindowF = windowF;
    beginWindowF.origin.y = - beginWindowF.size.height;
    window_.frame = beginWindowF;
    [UIView animateWithDuration:AnimationDuration animations:^{
        window_.frame = windowF;
    }];
}

 -(void)navigationBarDismissStyle
{
    // 停止定时器
    [timer_ invalidate];
    timer_ = nil;
    // 隐藏
    [UIView animateWithDuration:AnimationDuration animations:^{
        CGRect beginWindowF = window_.frame;
        beginWindowF.size.height = 0.001f;
        window_.frame = beginWindowF;
    } completion:^(BOOL finished) {
        // 如果定时器是nil, 说明这个hide动画期间, 没有创建任何新的窗口
        if (timer_ == nil) window_ = nil;
    }];

}
 -(void)statusBarDismissStyle
{
    // 停止定时器
    [timer_ invalidate];
    timer_ = nil;
    // 隐藏
    [UIView animateWithDuration:AnimationDuration animations:^{
        CGRect beginWindowF = window_.frame;
        beginWindowF.origin.y = - beginWindowF.size.height;
        window_.frame = beginWindowF;
    } completion:^(BOOL finished) {
        // 如果定时器是nil, 说明这个hide动画期间, 没有创建任何新的窗口
        if (timer_ == nil) window_ = nil;
    }];

}


#pragma mark - 公共方法
/**
 *  显示图片 -文字信息
 */
 - (void)showText:(NSString *)text image:(UIImage *)image withType:(LinShowFrameType)type
{
    // 根据文字和图片做一些初始化操作
    [self setupText:text image:image withType:type];
    
    // 停止上次的定时器
    [timer_ invalidate];
    // 开启新的定时器
    
    timer_ = [NSTimer scheduledTimerWithTimeInterval:StayDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 *  显示图片 -文字信息
 */
 - (void)showText:(NSString *)text imageName:(NSString *)imageName withType:(LinShowFrameType)type
{
    [self showText:text image:[UIImage imageNamed:imageName] withType:type];
}

/**
 *  显示文字信息
 */
 - (void)showText:(NSString *)text withType:(LinShowFrameType)type
{
    [self showText:text image:nil withType:type];
}

/**
 *  显示成功信息
 */
 - (void)showSuccess:(NSString *)text withType:(LinShowFrameType)type
{
    [self showText:text imageName:@"成功" withType:type];
}

/**
 *  显示警告颜色
 */

-(void)showWranning:(NSString *)text withType:(LinShowFrameType)type
{
    [self showText:text imageName:@"警告" withType:type];
}

/**
 *  显示失败信息
 */
 - (void)showError:(NSString *)text withType:(LinShowFrameType)type
{
    [self showText:text imageName:@"失败" withType:type];
}

/**
 *  显示正在加载的信息
 */
 - (void)showLoading:(NSString *)text withType:(LinShowFrameType)type
{
    // 根据文字和图片做一些初始化操作
    [self setupText:text image:nil withType:type];
    
    CGRect windowF = window_.frame;
    UIButton *button = window_.subviews.lastObject;
    
    // 添加圈圈
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    
    [button.titleLabel sizeToFit];
    CGFloat loadingCenterX = (windowF.size.width - button.titleLabel.frame.size.width) * 0.5 - 20;
    loadingView.center = CGPointMake(loadingCenterX, windowF.size.height * 0.5);
    [window_ addSubview:loadingView];
}

-(void)btnClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(clickHudWithHud:)])
    {
        [self.delegate clickHudWithHud:self];
    }
}

/**
 *  隐藏指示器
 */
 - (void)hide
{
   
    if (window_ == nil) {return;};
    if (window_.hidden == YES) {return;};
    if ([self.delegate respondsToSelector:@selector(linStatusHUDWillHideWithHud: withHudHeight:)])
    {
        [self.delegate linStatusHUDWillHideWithHud:self withHudHeight:window_.frame.size.height];
    }
    
    showType == navigationBarType ? [self navigationBarDismissStyle] : [self statusBarDismissStyle];
    
    if ([self.delegate respondsToSelector:@selector(linStatusHUDDidHideWithHud:)])
    {
        [self.delegate linStatusHUDDidHideWithHud:self];
    }
   
}

-(void)showWithWindowFrame:(CGRect)windowF
{
    if ([self.delegate respondsToSelector:@selector(linStatusHUDWillShowWithHud: withHudHeight:)])
    {
        [self.delegate linStatusHUDWillShowWithHud:self withHudHeight:window_.frame.size.height];
    }
    
   showType == navigationBarType ? [self navigationShowStyleWithWindowFrame:windowF] : [self statusBarShowStyleWithWindowFrame:windowF];
    
    if ([self.delegate respondsToSelector:@selector(linStatusHUDDidShowWithHud:)])
    {
        [self.delegate linStatusHUDDidShowWithHud:self];
    }
    
}

@end
