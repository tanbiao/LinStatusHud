//
//  TestViewController.m
//  LinStatusHUD
//
//  Created by 西乡流水 on 17/4/3.
//  Copyright © 2017年 西乡流水. All rights reserved.
//

#import "TestViewController.h"
#import "LinStatusHUD.h"
#import "UIView+Extension.h"

@interface TestViewController ()<LinStatusHUDDelegate>

@property(nonatomic,strong)  LinStatusHUD *hud;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
//    [task resume];
//    [LinStatusHUD shareInstance].hudColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
}


- (IBAction)success {
    
////    [LinStatusHUD shareInstance].delegate = self;
//    self.hud = [LinStatusHUD statusHud];
//    self.hud.delegate = self;
//    self.hud.hudColor = [UIColor greenColor];
////    [self.hud showText:@"登录成功" withType:navigationBarType];
//    [self.hud showSuccess:@"登录成功" withType:statusBarType];
//    //    [XMGStatusBarHUD showText:@"哈哈哈哈"];
    //    [XMGStatusBarHUD showText:@"哈哈哈" imageName:@"test"];
    //    [XMGStatusBarHUD showText:@"4234" image:[UIImage imageNamed:@"test"]];
    
   
}

- (IBAction)eror {
    
//     [LinStatusHUD shareInstance].hudColor = [UIColor yellowColor];
//    [[LinStatusHUD statusHud]showError:@"登录失败!" withType:statusBarType];
    [[LinStatusHUD statusHud] showError:@"登录失败" withType:statusBarType];
//    [[LinStatusHUD statusHud] showWranning:@"出现警告了" withType:navigationBarType];
  
}

- (IBAction)loading {
    
//    [LinStatusHUD shareInstance].hudColor = [UIColor grayColor];
    [[LinStatusHUD statusHud] showLoading:@"正在登录中..." withType:navigationBarType];
    
}

- (IBAction)hide {
    
    [[LinStatusHUD statusHud] hide];
}

-(void)linStatusHUDWillHideWithHud:(LinStatusHUD *)hud
{
    
    NSLog(@"hud将要隐藏了");
}

-(void)linStatusHUDDidHideWithHud:(LinStatusHUD *)hud
{
   NSLog(@"hud已经隐藏了");
}

-(void)linStatusHUDDidShowWithHud:(LinStatusHUD *)hud
{
  NSLog(@"hud已经出现了");
}

-(void)linStatusHUDWillShowWithHud:(LinStatusHUD *)hud
{
//    CGFloat contentOffsetY = hud.height;
    NSLog(@"hud将要出现了");
}

-(void)clickHudWithHud:(LinStatusHUD *)hud
{
    [hud hide];
    NSLog(@"hud点击了.....");
}

-(UIColor *)setupHudBackGroundColorWithHud:(LinStatusHUD *)hud
{
    return [UIColor grayColor];
}

//-(CGFloat)heightForHud:(LinStatusHUD *)hud
//{
//    return 100;
//}




@end
