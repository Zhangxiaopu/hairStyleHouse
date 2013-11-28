//
//  DemoViewController.m
//  SlideImageView
//
//  Created by rd on 12-12-17.
//  Copyright (c) 2012年 LXJ_成都. All rights reserved.
//

#import "DemoViewController.h"
#import "UIImageView+WebCache.h"
@interface DemoViewController ()

@end

@implementation DemoViewController
@synthesize imageArr;
@synthesize index;
- (id)init
{
    self = [super init];
    if (self) {
        CGRect rect = {{20,100},{250,340}};
        slideImageView = [[SlideImageView alloc]initWithFrame:rect ZMarginValue:5 XMarginValue:10 AngleValue:0.3 Alpha:1000];
        slideImageView.borderColor = [UIColor whiteColor];
        slideImageView.delegate = self;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.view addSubview:slideImageView];
//    indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 400, 300, 40)];
//    indexLabel.font = [UIFont systemFontOfSize:20.f];
//    indexLabel.text = @"当前为第0张";
//    [self.view addSubview:indexLabel];
//    clickLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 430, 300, 40)];
//    clickLabel.font = [UIFont systemFontOfSize:18.f];
//    clickLabel.text = @"点击了第  张";
//    [self.view addSubview:clickLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [slideImageView setIndex:index];

    [self refreashNavLab];
    [self refreashNav];
	// Do any additional setup after loading the view.
    for(int i=0; i<imageArr.count; i++)
    {
        NSString * imageStr = [[imageArr objectAtIndex:i] objectForKey:@"work_image"];
        UIImageView * imageView = [[UIImageView alloc] init];
        [imageView setImageWithURL:[NSURL URLWithString:imageStr]];
         UIImage* image = imageView.image;
        [slideImageView addImage:image];
    }
    [slideImageView setImageShadowsWtihDirectionX:2 Y:2 Alpha:0.7];
    [slideImageView reLoadUIview];
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
-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:NO];
    self.navigationController.navigationBar.hidden =YES;
}
-(void)refreashNavLab
{
    UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
    Lab.text = @"浏览图片";
    Lab.textAlignment = NSTextAlignmentCenter;
    Lab.font = [UIFont systemFontOfSize:16];
    Lab.textColor = [UIColor blackColor];
    self.navigationItem.titleView =Lab;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)SlideImageViewDidClickWithIndex:(int)index//点击图片
{

}

- (void)SlideImageViewDidEndScorllWithIndex:(int)index//滑动视图
{

}
@end
