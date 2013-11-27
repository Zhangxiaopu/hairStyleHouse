//
//  mineViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "singleTableCellBackgroundViewController.h"
#import "LoginView.h"
@interface mineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    LoginView* loginView;
    
    UITableView *myTableView;
    NSMutableArray * inforArr;
    singleTableCellBackgroundViewController * backView;
}
@end
