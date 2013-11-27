//
//  DemoViewController.h
//  SlideImageView
//
//  Created by rd on 12-12-17.
//  Copyright (c) 2012年 LXJ_成都. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideImageView.h"

@interface DemoViewController : UIViewController<SlideImageViewDelegate>
{
    SlideImageView* slideImageView;
    UILabel* indexLabel;
    UILabel* clickLabel;
}
@end
