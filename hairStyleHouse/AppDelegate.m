//
//  AppDelegate.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

//@synthesize sinaweibo;
@synthesize tententOAuth;
@synthesize uid;
@synthesize loginType;
@synthesize xuanzheLoginType;
@synthesize type;
@synthesize longitude;
@synthesize latitude;
@synthesize touxiangImage;
@synthesize city;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    findStyleController=[[findStyleViewController alloc] init];
    dresserController=[[dresserViewController alloc] init];
    squareController=[[squareViewController alloc] init];
    mineController=[[mineViewController alloc] init];
    
    
    firstNav = [[UINavigationController alloc] initWithRootViewController:findStyleController];
    secondNav = [[UINavigationController alloc] initWithRootViewController:dresserController];
    thirdNav = [[UINavigationController alloc] initWithRootViewController:squareController];
    forthNav = [[UINavigationController alloc] initWithRootViewController:mineController];

    NSMutableArray* tabArray=[[NSMutableArray alloc] init];
    [tabArray addObject:firstNav];
    [tabArray addObject:secondNav];
    [tabArray addObject:thirdNav];
    [tabArray addObject:forthNav];
    
    
    rootTab=[[UITabBarController alloc] init];
    rootTab.delegate=self;
    rootTab.viewControllers=tabArray;
    rootTab.selectedIndex = 0;
    
    tabImageView=[[UIImageView alloc] init];
    tabImageView.frame=CGRectMake(0,0, 320, rootTab.tabBar.frame.size.height);
    tabImageView.image=[UIImage imageNamed:@"01找发型.png"];
    [rootTab.tabBar addSubview:tabImageView];
    
    rootNav = [[UINavigationController alloc] initWithRootViewController:rootTab ];
    rootNav.navigationBar.hidden=YES;
    [self.window setRootViewController:rootNav];
    // Override point for customization after application launch.
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if (viewController == firstNav) {
        tabImageView.image=[UIImage imageNamed:@"01找发型.png"];
       
    }
    else if (viewController == secondNav) {
        tabImageView.image=[UIImage imageNamed:@"02发型师.png"];
       
    }
    else if (viewController == thirdNav) {
        tabImageView.image=[UIImage imageNamed:@"03广场.png"];
        
    }
    else if (viewController==forthNav){
        tabImageView.image=[UIImage imageNamed:@"04我的.png"];
        
        
    }
    
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
