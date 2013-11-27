//
//  AppDelegate.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "findStyleViewController.h"
#import "dresserViewController.h"
#import "squareViewController.h"
#import "mineViewController.h"
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentOAuth.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate,UINavigationControllerDelegate,UITabBarControllerDelegate>

{
    UINavigationController * rootNav;
    UITabBarController * rootTab;
    UIImageView * tabImageView;
    
    findStyleViewController * findStyleController;
    UINavigationController * firstNav;
    
    dresserViewController * dresserController;
    UINavigationController * secondNav;
    
    squareViewController * squareController;
    UINavigationController * thirdNav;
    
    mineViewController * mineController;
    UINavigationController * forthNav;
}
@property (strong, nonatomic) UIWindow *window;
//@property (strong,nonatomic) SinaWeibo* sinaweibo;
@property (strong,nonatomic) NSString* uid;//用到
@property (strong,nonatomic) TencentOAuth* tententOAuth;//用到
@property (nonatomic,assign) NSString* loginType;//用到
@property (nonatomic,assign) NSString* xuanzheLoginType;
@property (strong,nonatomic) NSString* type;// 用到
@property (nonatomic,assign) double  longitude;
@property (nonatomic,assign) double latitude;
@property (nonatomic,strong) NSString* touxiangImage;
@property (nonatomic,strong) NSString* city;
@property (nonatomic,strong) NSString* userName;//用到

@end
