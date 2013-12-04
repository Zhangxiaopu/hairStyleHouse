//
//  findStyleViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "findStyleViewController.h"
#import "AppDelegate.h"
#import "LoginView.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
@interface findStyleViewController ()

@end

@implementation findStyleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
        Lab.text = @"找发型";
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"您关闭了的定位功能，将无法收到位置信息，建议您到系统设置打开定位功能!");
    }
    else
    {
    locationManager = [[CLLocationManager alloc] init];//创建位置管理器
    locationManager.delegate=self;//设置代理
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;//指定需要的精度级别
    locationManager.distanceFilter=100.0f;//设置距离筛选器
    [locationManager startUpdatingLocation];//启动位置管理器
    }
    [self cView];
	// Do any additional setup after loading the view.
}

-(void)cView
{
    for (int i=0; i<3; i++) {
        for (int j=0; j<2; j++) {
            UIImageView* imageView=[[UIImageView alloc] init];
            imageView.frame=CGRectMake(20+150*j, 10+145*i+(self.view.frame.size.height-self.tabBarController.tabBar.frame.size.height-self.navigationController.navigationBar.frame.size.height-140)/4, 130, 121);
            imageView.tag=i*2+j;
            imageView.userInteractionEnabled=YES;
            [self.view addSubview:imageView];
        }
    }
    UITapGestureRecognizer* tap;
    
    for (UIImageView* imageView in self.view.subviews) {
        switch (imageView.tag) {
            case 0:
                [imageView setImage:[UIImage imageNamed:@"短发.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
                [imageView addGestureRecognizer:tap];
                break;
            case 1:
                [imageView setImage:[UIImage imageNamed:@"中发.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
                [imageView addGestureRecognizer:tap];
                break;
            case 2:
                [imageView setImage:[UIImage imageNamed:@"长发.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
                [imageView addGestureRecognizer:tap];
                break;
            case 3:
                [imageView setImage:[UIImage imageNamed:@"盘发.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
                [imageView addGestureRecognizer:tap];
                break;
            case 4:
                [imageView setImage:[UIImage imageNamed:@"男士发型.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
                [imageView addGestureRecognizer:tap];
                break;
            case 5:
                [imageView setImage:[UIImage imageNamed:@"其他.png"]];
                tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
                [imageView addGestureRecognizer:tap];
                break;
            default:
                break;
        }
    }
}

-(void)tapView:(UITapGestureRecognizer* )tap
{
    
    
}

#pragma mark CLLocationManager delegate
//定位成功调用
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"定位成功！");
    CLLocationCoordinate2D loc = [newLocation coordinate];
    
    NSLog(@"%f",loc.latitude);
    NSLog(@"%f",loc.longitude);
    
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    appDele.latitude=loc.latitude;
    appDele.longitude=loc.longitude;
    
    [locationManager stopUpdatingLocation];

    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder  reverseGeocodeLocation: newLocation completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         for (CLPlacemark *placemark in placemarks) {
             
             NSString * citystring =[NSString stringWithFormat: @"你当前的位置是：%@%@%@",placemark.administrativeArea,placemark.locality,placemark.subLocality];
             AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
             appDele.city=citystring;
             UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:citystring delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
             [alert show];
             
             NSLog(@"name:%@\n country:%@\n postalCode:%@\n ISOcountryCode:%@\n ocean:%@\n inlandWater:%@\n locality:%@\n subLocality:%@\n administrativeArea:%@\n subAdministrativeArea:%@\n thoroughfare:%@\n subThoroughfare:%@\n",placemark.name,placemark.country,placemark.postalCode,placemark.ISOcountryCode,placemark.ocean,placemark.inlandWater,placemark.administrativeArea,placemark.subAdministrativeArea,placemark.locality,placemark.subLocality,placemark.thoroughfare,placemark.subThoroughfare);
             
             [geocoder cancelGeocode];
             if (appDele.uid) {
                 [self getData];
             }
             
             
         }
     }];

}

-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=coordinates"]]];
    request.delegate=self;
    request.tag=1;
    
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude ] forKey:@"lng"];
    [request setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude ] forKey:@"lat"];
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSLog(@"%@",request.responseString);
    NSData*jsondata = [request responseData];
    NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
    SBJsonParser* jsonP=[[SBJsonParser alloc] init];
    NSDictionary* dic=[jsonP objectWithString:jsonString];
    NSLog(@"个人信息dic:%@",dic);
}
//定位出错时被调
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"定位出错" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    NSLog(@"获取经纬度失败，失败原因：%@", [error description]);
}

- (void) startLocation

{
    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"您关闭了的定位功能，将无法收到位置信息，建议您到系统设置打开定位功能!");
    }
    else
    {
        CLLocationManager *myLocationManager = [[CLLocationManager alloc]init];
        myLocationManager.delegate = self;
        //        NSLog(@"PURPOSE = %@",self.myLocationManager.purpose);
        //选择定位的方式为最优的状态，他又四种方式在文档中能查到
        myLocationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //发生事件的最小距离间隔
        myLocationManager.distanceFilter = 1000.0f;
        [myLocationManager startUpdatingLocation];
        
    }
}
#pragma mark MKReverseGeocoderDelegate//ios5之前适用，需要MKReverseGeocoderDelegate
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
