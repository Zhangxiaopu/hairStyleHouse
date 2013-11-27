//
//  DemoViewController.m
//  SlideImageView
//
//  Created by rd on 12-12-17.
//  Copyright (c) 2012年 LXJ_成都. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (id)init
{
    self = [super init];
    if (self) {
        CGRect rect = {{20,40},{250,340}};
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
    indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 400, 300, 40)];
    indexLabel.font = [UIFont systemFontOfSize:20.f];
    indexLabel.text = @"当前为第0张";
    [self.view addSubview:indexLabel];
    clickLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 430, 300, 40)];
    clickLabel.font = [UIFont systemFontOfSize:18.f];
    clickLabel.text = @"点击了第  张";
    [self.view addSubview:clickLabel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    for(int i=0; i<6; i++)
    {
        NSString* imageName = [NSString stringWithFormat:@"%d",i%4];
         UIImage* image = [UIImage imageNamed:imageName];
        [slideImageView addImage:image];
    }
    [slideImageView setImageShadowsWtihDirectionX:2 Y:2 Alpha:0.7];
    [slideImageView reLoadUIview];
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

- (void)SlideImageViewDidClickWithIndex:(int)index
{
    NSString* indexStr = [[NSString alloc]initWithFormat:@"点击了第%d张",index];
    clickLabel.text = indexStr;
}

- (void)SlideImageViewDidEndScorllWithIndex:(int)index
{
    NSString* indexStr = [[NSString alloc]initWithFormat:@"当前为第%d张",index];
    indexLabel.text = indexStr;
}
@end
