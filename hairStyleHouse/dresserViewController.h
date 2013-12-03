//
//  dresserViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dresserInforViewController.h"
#import "dresserCell.h"
#import "LoginView.h"
#import "loginViewController.h"
@interface dresserViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    UIImageView * topImage;
    UITableView *myTableView;
    NSMutableArray * dresserArray;
    NSString * page;
    NSString * sign;
    dresserInforViewController * dreserView;

    loginViewController* loginView;

}
-(void)selectCell:(NSInteger)_index;
-(void)didFouce:(NSInteger)_index;

@end
