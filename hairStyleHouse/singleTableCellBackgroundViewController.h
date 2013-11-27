//
//  singleTableCellBackgroundViewController.h
//  hairStyleHouse
//
//  Created by jeason on 13-11-27.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface singleTableCellBackgroundViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UIButton *headButton;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *addressLable;
@property (strong, nonatomic) IBOutlet UIButton *fansButton;
@property (strong, nonatomic) IBOutlet UIButton *fouceButton;
@property (strong, nonatomic) IBOutlet UIView *secondBackView;
@property (strong, nonatomic) IBOutlet UILabel *worksLable;
@property (strong, nonatomic) IBOutlet UILabel *messageLable;
@property (strong, nonatomic) IBOutlet UIButton *messageButton;

@property (strong, nonatomic) IBOutlet UILabel *beaspeakLable;
@property (strong, nonatomic) IBOutlet UIButton *beaspeakButton;

@property (strong, nonatomic) IBOutlet UILabel *saveLable;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;


@property (strong, nonatomic) IBOutlet UITextView *personInforText;

@end
