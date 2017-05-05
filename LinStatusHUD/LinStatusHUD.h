//
//  LinStatusHUD.h
//  LinStatusHUD
//
//  Created by 西乡流水 on 17/4/3.
//  Copyright © 2017年 西乡流水. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger
{
    navigationBarType = 1 ,
    
    statusBarType = 2,
    
} LinShowFrameType;

@class LinStatusHUD;

@protocol LinStatusHUDDelegate <NSObject>

@optional
/*hud已经隐藏时调用*/
-(void)linStatusHUDDidHideWithHud:(LinStatusHUD *)hud;

/*hud已经出现时调用*/
-(void)linStatusHUDDidShowWithHud:(LinStatusHUD *)hud;

/*hud将要隐藏时调用*/
-(void)linStatusHUDWillHideWithHud:(LinStatusHUD *)hud withHudHeight:(CGFloat)height;

/*hud将要出现时调用*/
-(void)linStatusHUDWillShowWithHud:(LinStatusHUD *)hud withHudHeight:(CGFloat)height;

/*点击hud的时候调用*/
-(void)clickHudWithHud:(LinStatusHUD *)hud;

/*设置背景颜色*/
-(UIColor *)setupHudBackGroundColorWithHud:(LinStatusHUD *)hud;

/*设置高度,只有在navigationBarType的时候才能设置高度*/
 -(CGFloat)heightForHud:(LinStatusHUD *)hud;

@end

@interface LinStatusHUD : NSObject

/**
 创建一个LinStatusHuD对象,非单利
 @return LinStatusHuD对象
 */
+(instancetype)statusHud;

/*代理*/
@property(nonatomic,assign)  id<LinStatusHUDDelegate> delegate;

/*hud的背景色*/
@property(nonatomic,strong)  UIColor *hudColor;

/**
 *  显示文字信息
 */
 - (void)showText:(NSString *)text withType:(LinShowFrameType)type;
/**
 *  显示图片+文字信息
 */
- (void)showText:(NSString *)text image:(UIImage *)image withType:(LinShowFrameType)type;
/**
 *  显示图片+文字信息
 */
- (void)showText:(NSString *)text imageName:(NSString *)imageName withType:(LinShowFrameType)type;
/**
 *  显示成功信息
 */
- (void)showSuccess:(NSString *)text withType:(LinShowFrameType)type;
/**
 *  显示失败信息
 */
- (void)showError:(NSString *)text withType:(LinShowFrameType)type;
/**
 *  显示正在加载的信息
 */
- (void)showLoading:(NSString *)text withType:(LinShowFrameType)type;

/**
 显示警告
 @param text 你要展示的文字
 */
- (void)showWranning:(NSString *)text withType:(LinShowFrameType)type;
/**
 *  隐藏指示器 
 */
-(void)hide;

@end
