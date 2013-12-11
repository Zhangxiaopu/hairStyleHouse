//
//  inviteViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-12-11.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "inviteCell.h"
#import "inviteDetailViewController.h"
#import "personInforViewController.h"

@class AllAroundPullView;
@interface inviteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{ UITableView *myTableView;
    AllAroundPullView *bottomRefreshView;
    NSMutableArray * dresserArray;
    NSString * page;
    NSString * pageCount;
    NSString * sign;
    inviteDetailViewController * inviteDetail;
    personInforViewController*personInfor;
}
@property(nonatomic,strong)NSString * _hidden;
-(void)selectCell:(NSInteger)_index;

@end
