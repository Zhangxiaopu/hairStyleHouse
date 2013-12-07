//
//  findStyleDetailViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-12-4.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "findStyleDetailViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
@interface findStyleDetailViewController ()

@end

@implementation findStyleDetailViewController
@synthesize style;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreashNavLab];
    [self refreashNav];
    self.view.backgroundColor = [UIColor whiteColor];
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
    [topImage setImage:[UIImage imageNamed:@"最新发型.png"]];
    
    UIButton * oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(320/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    twoButton.backgroundColor = [UIColor clearColor];
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(320*2/3,self.navigationController.navigationBar.frame.size.height+20, 320/3, 50);
    thirdButton.backgroundColor = [UIColor clearColor];
    [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    [self.view addSubview:thirdButton];
    
    dresserArray =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    sign =[[NSString alloc] init];
    sign = @"new";
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-50) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myTableView];
    
    
    
    [self getData];
}
-(void)oneButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"最新发型.png"]];
    sign =@"new";
    [self getData];
    
}
-(void)twoButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"同城发型.png"]];
//    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    sign =@"city";
    NSLog(@"sign:%@",sign);
    [self getData];
}
-(void)thirdButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"推荐发型.png"]];
    sign =@"recommend";
    [self getData];
    
}
-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    //    if (appDele.uid) {
    ASIFormDataRequest* request;
    request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Forhair&a=cate&page=%@",page]]];
    if (!appDele.uid)
    {
        
    }
    else
    {
    [request setPostValue:appDele.uid forKey:@"uid"];
    }
    
    [request setPostValue:style forKey:@"cid"];
   
    [request setPostValue:sign forKey:@"condition"];
    
    if ([sign isEqualToString:@"city"]) {
        [request setPostValue:appDele.city forKey:@"city_name"];

    }

    
    request.delegate=self;
    request.tag=1;
    [request startAsynchronous];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (dresserArray!=nil) {
        [dresserArray removeAllObjects];
    }
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"%@分类%@发型dic:%@",style,sign,dic);
        
        
        if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"image_list"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [dic objectForKey:@"image_list"];
            
        }
        [self freashView];
    }
}

-(void)freashView
{
    [myTableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dresserArray.count%3==0)
    {
        return dresserArray.count/3;
    }
    else
    {
        return dresserArray.count/3+1;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   160;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    hairStyleCategoryScanImageCell *cell=(hairStyleCategoryScanImageCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[hairStyleCategoryScanImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherView =self;
    }
    NSUInteger row1 = [indexPath row]*3;
    NSLog(@"row1:%d",row1);
    NSUInteger row2 = [indexPath row]*3+1;
    NSLog(@"row2:%d",row2);
    NSUInteger row3 = [indexPath row]*3+2;
    NSLog(@"row3:%d",row3);
    
    [cell setCell:[dresserArray objectAtIndex:row1] andIndex:row1];
    
    if (row2<dresserArray.count)//防止可能越界
    {
        [cell setCell:[dresserArray objectAtIndex:row2] andIndex:row2];
    }
    if (row3<dresserArray.count)//防止可能越界
    {
        [cell setCell:[dresserArray objectAtIndex:row3] andIndex:row3];
    }

    return cell;

}

-(void)leftButtonClick
{
    self.navigationController.navigationBar.hidden=YES;
    [self.navigationController popViewControllerAnimated:NO];
    
}
-(void)refreashNav
{
    UIButton * leftButton=[[UIButton alloc] init];
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton.layer setMasksToBounds:YES];
    [leftButton.layer setCornerRadius:3.0];
    [leftButton.layer setBorderWidth:1.0];
    [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [leftButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    leftButton.frame = CGRectMake(12,20, 60, 25);
    UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem=leftButtonItem;
}

-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    
        if ([style isEqualToString:@"1"])
        {
            Lab.text = @"短发";
        }
        else if ([style isEqualToString:@"2"])
        {
            Lab.text = @"中发";
        }
        else if ([style isEqualToString:@"3"])
        {
            Lab.text = @"长发";
        }
        else if ([style isEqualToString:@"4"])
        {
            Lab.text = @"盘发";
        }
        else if ([style isEqualToString:@"5"])
        {
            Lab.text = @"男发";
        }
        else if ([style isEqualToString:@"6"])
        {
            Lab.text = @"全部";
        }
        
    
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

-(void)selectImage:(NSInteger)_index
{
    int count = dresserArray.count;
    // 1.封装图片数据
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++) {
        // 替换为中等尺寸图片
        NSString *url = [[dresserArray[i] objectForKey:@"work_image"] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.work_id =[dresserArray[i] objectForKey:@"work_id"];
        photo.url = [NSURL URLWithString:url]; // 图片路径
//        photo.srcImageView = self.view.subviews[i]; // 来源于哪个UIImageView
        [photos addObject:photo];
    }
    
    // 2.显示相册
    browser=nil;
    browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = _index; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [self.navigationController pushViewController:browser animated:YES];
//    [browser show];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
