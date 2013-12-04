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
    NSString * sign;//标记登陆成功后调用哪个借口
    dresserInforViewController * dreserView;

    loginViewController* loginView;

    NSString* fromFouceLoginCancel;//标记取消登陆后调用哪个借口
}
@property(nonatomic,strong)        NSString* fromFouceLoginCancel;
-(void)fromFouceCancelBack:(NSString *)_str;
-(void)selectCell:(NSInteger)_index;
-(void)didFouce:(NSInteger)_index;

@end
