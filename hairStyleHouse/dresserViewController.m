//
//  dresserViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-26.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "dresserViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
@interface dresserViewController ()

@end

@implementation dresserViewController
@synthesize fromFouceLoginCancel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
        Lab.text = @"发型师";
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
    self.view.backgroundColor = [UIColor whiteColor];
    topImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 320, 50)];
    [topImage setImage:[UIImage imageNamed:@"全部.png"]];
    
    UIButton * oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height+20, 80, 50);
    oneButton.backgroundColor = [UIColor clearColor];
    [oneButton addTarget:self action:@selector(oneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(80,self.navigationController.navigationBar.frame.size.height+20, 80, 50);
    twoButton.backgroundColor = [UIColor clearColor];
    [twoButton addTarget:self action:@selector(twoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdButton.frame = CGRectMake(160,self.navigationController.navigationBar.frame.size.height+20, 80, 50);
    thirdButton.backgroundColor = [UIColor clearColor];
    [thirdButton addTarget:self action:@selector(thirdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * forthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forthButton.frame = CGRectMake(240,self.navigationController.navigationBar.frame.size.height+20, 80, 50);
    forthButton.backgroundColor = [UIColor clearColor];
    [forthButton addTarget:self action:@selector(forthButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topImage];
    [self.view addSubview:oneButton];
    [self.view addSubview:twoButton];
    [self.view addSubview:thirdButton];
    [self.view addSubview:forthButton];
    
    dresserArray =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    sign =[[NSString alloc] init];
    fromFouceLoginCancel=[[NSString alloc] init];
    sign = @"all";
    fromFouceLoginCancel=@"all";
    
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-50) style:UITableViewStylePlain];
    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:myTableView];
    
    
    
    [self getData];
}
-(void)oneButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"全部.png"]];
    sign =@"all";
    fromFouceLoginCancel=@"all";
    [self getData];
    
}
-(void)twoButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"同城1.png"]];
    sign =@"sameCity";
    fromFouceLoginCancel=@"sameCity";

    [self getData];
}
-(void)thirdButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"推荐.png"]];
    sign =@"introduce";
    fromFouceLoginCancel=@"introduce";
    [self getData];
    
}
-(void)forthButtonClick
{
    [topImage setImage:[UIImage imageNamed:@"4关注.png"]];
    sign =@"fouce";
    [self getData];
    
}
-(void)fromFouceCancelBack:(NSString *)_str
{
    NSLog(@"fromFouceLoginCancel:%@",fromFouceLoginCancel);
    
    
    if ([fromFouceLoginCancel isEqualToString:@"all"]) {
        
        [topImage setImage:[UIImage imageNamed:@"全部.png"]];
        [self getData1];

    }
    else if ([fromFouceLoginCancel isEqualToString:@"sameCity"])
    {
        [topImage setImage:[UIImage imageNamed:@"同城1.png"]];
        [self getData1];
    }
    else if ([fromFouceLoginCancel isEqualToString:@"introduce"])
    {
        [topImage setImage:[UIImage imageNamed:@"推荐.png"]];

        [self getData1];
    }
}

-(void)getData1
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    //    if (appDele.uid) {
    ASIFormDataRequest* request;
    if ([fromFouceLoginCancel isEqualToString:@"all"])
    {
        //            page=@"2";
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=allstylists&page=%@",page]]];
    }
    else if([fromFouceLoginCancel isEqualToString:@"sameCity"])
    {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=citystylists&page=%@",page]]];
        [request setPostValue:appDele.city forKey:@"city"];
        [request setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude ]forKey:@"lng"];
        [request setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude ] forKey:@"lat"];
    }
    else if([fromFouceLoginCancel isEqualToString:@"introduce"])
    {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=recomstylists&page=%@",page]]];
    }
    request.delegate=self;
    request.tag=1;
    
    if (appDele.uid) {
        [request setPostValue:appDele.uid forKey:@"uid"];
    }
    else
    {
        
    }
    [request startAsynchronous];
    //    }
    
}


-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    //    if (appDele.uid) {
    ASIFormDataRequest* request;
    if ([sign isEqualToString:@"all"])
    {
        //            page=@"2";
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=allstylists&page=%@",page]]];
    }
    else if([sign isEqualToString:@"sameCity"])
    {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=citystylists&page=%@",page]]];
        [request setPostValue:appDele.city forKey:@"city"];
        [request setPostValue:[NSString stringWithFormat:@"%f",appDele.longitude ]forKey:@"lng"];
        [request setPostValue:[NSString stringWithFormat:@"%f",appDele.latitude ] forKey:@"lat"];

    }
    else if([sign isEqualToString:@"introduce"])
    {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=recomstylists&page=%@",page]]];
    }
    else if([sign isEqualToString:@"fouce"])
    {
        NSLog(@"appDele.uid:%@",appDele.uid);
        
        if (appDele.uid) {
            request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Hairstylist&a=followstylists&page=%@",page]]];
        }
        else
        {
            loginView=nil;
            loginView=[[loginViewController alloc] init];
            loginView.dresserFatherController =self;
            loginView._backsign = fromFouceLoginCancel;
            loginView.view.frame=self.view.bounds;
            [loginView getBack:self andSuc:@selector(getData) andErr:nil];
            //        loginView.userInteractionEnabled=YES;
            //        [self.view addSubview:loginView];
            AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
            
            [appDele pushToViewController:loginView ];

        }
        
    }
    request.delegate=self;
    request.tag=1;
    
    if (appDele.uid) {
        [request setPostValue:appDele.uid forKey:@"uid"];
    }
    else
    {
        
    }
    [request startAsynchronous];
    //    }
    
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
    if (dresserArray!=nil) {
        [dresserArray removeAllObjects];
    }
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"发型师dic:%@",dic);
        
        
        if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSString class]])
        {
            
        }
        else if ([[dic objectForKey:@"user_info"] isKindOfClass:[NSArray class]])
        {
            dresserArray = [dic objectForKey:@"user_info"];
            
        }
        [self freashView];
    }
    if (request.tag==2) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        NSDictionary* dic=[jsonP objectWithString:jsonString];
        NSLog(@"是否关注成功dic:%@",dic);
        //            if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSString class]])
        //            {
        //
        //            }
        //            else if ([[dic objectForKey:@"message_list"] isKindOfClass:[NSArray class]])
        //            {
        //                dresserArray = [dic objectForKey:@"message_list"];
        //
        //            }
        [self getData];
    }
    
}
-(void)freashView
{
    [myTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dresserArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *_content =[[dresserArray objectAtIndex:[indexPath row]] objectForKey:@"store_address"];
    UIFont *font = [UIFont systemFontOfSize:12.0];
    //设置一个行高上限
    CGSize size = CGSizeMake(260,200);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [_content sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    if ([_content isEqualToString:@""]) {
        return   80;
    }
    else
    {
        return 80+labelsize.height;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    dresserCell *cell=(dresserCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[dresserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.fatherController=self;
    }
    
    NSInteger row =[indexPath row];
    [cell setCell:[dresserArray objectAtIndex:row] andIndex:row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //查看发型师
    
    
}

-(void)selectCell:(NSInteger)_index
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView.dresserFatherController =self;
        loginView._backsign = fromFouceLoginCancel;
        loginView.view.frame=self.view.bounds;
        [loginView getBack:self andSuc:@selector(getData) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;

        [appDele pushToViewController:loginView ];
    }
    else
    {
        dreserView =nil;
        dreserView =[[dresserInforViewController alloc] init];
        
        dreserView.uid = [[dresserArray objectAtIndex:_index ] objectForKey:@"uid"];
        NSLog(@"%@", dreserView.uid);
        [self.navigationController pushViewController:dreserView animated:NO];
    }
}

-(void)didFouce:(NSInteger)_index
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid)
    {
        loginView=nil;
        loginView=[[loginViewController alloc] init];
        loginView.dresserFatherController =self;
        loginView._backsign = fromFouceLoginCancel;
        loginView.view.frame=self.view.bounds;
        [loginView getBack:self andSuc:@selector(getData) andErr:nil];
        //        loginView.userInteractionEnabled=YES;
        //        [self.view addSubview:loginView];
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        
        [appDele pushToViewController:loginView ];
        
    }
    else
    {
        AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=follow"]]];
        request.delegate=self;
        request.tag=2;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:[[dresserArray objectAtIndex:_index ] objectForKey:@"uid"] forKey:@"touid"];
        [request setPostValue:appDele.type forKey:@"type"];
        [request setPostValue:[[dresserArray objectAtIndex:_index ] objectForKey:@"type"] forKey:@"totype"];
        if ([[[dresserArray objectAtIndex:_index ] objectForKey:@"isconcerns"] isEqualToString:@"1"]) {
            [request setPostValue:@"0" forKey:@"status"];
        }
        else
        {
            [request setPostValue:@"1" forKey:@"status"];
        }
        
        [request startAsynchronous];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
