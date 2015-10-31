//
//  AppDelegate.m
//  SGWeiBo
//
//  Created by apple on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "SGTabBarVC.h"
#import "SGNewfutureVc.h"
#import "SGUserDefaultTool.h"
#import "SGWelcomeVc.h"
#import "SGoAuthVc.h"
#import "SGUserAccount.h"
#define kVersionKey @"CFBundleShortVersionString"
@interface AppDelegate ()

@property (nonatomic,strong) SGUserAccount *userAccount;
@property (nonatomic,assign)BOOL  Login;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _Login = self.userAccount.access_token != nil;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self setRootViewController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIViewController *)setRootViewController {
     // 先解档看是否有数据，有数据证明登陆过
    if (_Login) { // 登陆
        //是否是新版本
        if ([self reviewVersion]) { // 是新版本
            SGNewfutureVc *newFuture = [[SGNewfutureVc alloc] init];
            return newFuture;
        } else { // 不是新版本
            SGWelcomeVc *welComeVc = [[SGWelcomeVc alloc] init];
            return welComeVc;
        }
    } else { // 不是登陆
        SGTabBarVC *tabbarVc = [[SGTabBarVC alloc] init];
        return tabbarVc;
    }
}

#pragma mark - 版本新特性
- (BOOL)reviewVersion {
    //当前版本
    CGFloat currcentVersion = [[NSBundle mainBundle].infoDictionary[kVersionKey] doubleValue];
    //保存版本
    CGFloat preVersion = [SGUserDefaultTool doubleForKey:kVersionKey];
    if (currcentVersion > preVersion) {
        [SGUserDefaultTool saveDouble:currcentVersion forKey:kVersionKey];
        // 根控制器显示版本新特性
        return YES;
    }
    return NO;
}


#pragma mark - set && get
-(SGUserAccount *)userAccount {
    if (!_userAccount) {
        _userAccount = [SGUserAccount loadAccount];

    }
    return _userAccount;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
