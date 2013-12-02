//
//  scanImageViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "scanCell.h"
#import "DemoViewController.h"
@interface scanImageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
UITableView *myTableView;
NSMutableArray * dresserArray;
    
    NSString * page;
    DemoViewController * demoView;
    
    NSString * worksOrsave;
    NSString* uid;
}
@property(nonatomic,strong)NSString * worksOrsave;
@property(nonatomic,strong)NSString* uid;
-(void)selectImage:(NSInteger)_index;
@end
