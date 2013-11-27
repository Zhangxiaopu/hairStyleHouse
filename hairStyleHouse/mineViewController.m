//
//  mineViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "mineViewController.h"
#import "AppDelegate.h"
#import "LoginView.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
@interface mineViewController ()

@end

@implementation mineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
        Lab.text = @"个人中心";
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    loginView=[[LoginView alloc] init];
    loginView.frame=self.view.bounds;
        
    
    inforArr = [[NSMutableArray alloc] init];
    
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
	// Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid) {
        [loginView getBack:self andSuc:@selector(getData) andErr:nil];
        loginView.userInteractionEnabled=YES;
        [self.view addSubview:loginView];
    }
    else
    {
        [self getData];
    }
}


-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

    ASIHTTPRequest* request=[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=info&type=%@&uid=%@",appDele.type,appDele.uid]]];
    request.delegate=self;
    request.tag=2;
    [request startAsynchronous];
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    NSLog(@"%@",request.responseString);
    SBJsonParser* jsonP=[[SBJsonParser alloc] init];
    NSDictionary* dic=[jsonP objectWithString:request.responseString];
    NSLog(@"个人信息dic:%@",dic);
    inforArr = [dic objectForKey:@"user_info"];
    
//    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;//调用appdel
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView * alert =[[UIAlertView alloc] initWithTitle:@"提示" message:@"请求失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return   self.view.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [self updateBackView];
//    backView.view.backgroundColor =[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [cell.contentView addSubview:backView.view];
    return cell;
}

- (void)updateBackView
{
    if (backView==nil) {
        backView=[[singleTableCellBackgroundViewController alloc] init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
