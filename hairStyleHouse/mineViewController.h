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
#import "pubImageViewController.h"
@interface mineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    LoginView* loginView;
    
    UITableView *myTableView;
    NSDictionary * inforDic;
    singleTableCellBackgroundViewController * backView;
    pubImageViewController * pubImage;

}
-(void)pushToViewController:(id)_sen;
-(void)needAppdelegatePushToViewController:(id)_sen;

@end
