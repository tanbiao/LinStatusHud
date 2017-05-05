//
//  AppDelegate.h
//  LinStatusHUD
//
//  Created by 西乡流水 on 17/4/3.
//  Copyright © 2017年 西乡流水. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

