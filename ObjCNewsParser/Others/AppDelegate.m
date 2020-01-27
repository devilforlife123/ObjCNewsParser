//
//  AppDelegate.m
//  ObjCNewsParser
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTableViewController.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MainTableViewController * mtvc = [[MainTableViewController alloc]init];
    UINavigationController * masterNav = [[UINavigationController alloc]initWithRootViewController:mtvc];
   
        
        
    self.window.rootViewController = masterNav;
    
    
    // Override point for customization after application launch.
    [self setAppApperances];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
}


- (void)setAppApperances{
    
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8]];
    [shadow setShadowOffset:CGSizeMake(0, 1)];

    NSDictionary *attributes = @{
                                    NSForegroundColorAttributeName: [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0],
                                    NSShadowAttributeName: shadow,
                                    NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0]
                                 };
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    [[UINavigationBar appearance] setBarTintColor:kCustomRedColor];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UIRefreshControl appearance] setTintColor:kCustomRedColor];
    
    
}


@end
