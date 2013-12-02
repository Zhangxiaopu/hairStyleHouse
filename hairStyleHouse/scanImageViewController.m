//
//  scanImageViewController.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "scanImageViewController.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "UIImageView+WebCache.h"
@interface scanImageViewController ()

@end

@implementation scanImageViewController
@synthesize worksOrsave;
@synthesize uid;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreashNavLab];
    [self refreashNav];
    myTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    dresserArray =[[NSMutableArray alloc] init];
    page =[[NSString alloc] init];
    
    //    myTableView.allowsSelection=NO;
    [myTableView setSeparatorInset:UIEdgeInsetsZero];
    myTableView.dataSource=self;
    myTableView.delegate=self;
    myTableView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:myTableView];
    
    [self getData];
}
    -(void)refreashNav
    {
        UIButton * leftButton=[[UIButton alloc] init];
        leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton.layer setMasksToBounds:YES];
        [leftButton.layer setCornerRadius:3.0];
        [leftButton.layer setBorderWidth:1.0];
        [leftButton.layer setBorderColor: CGColorCreate(CGColorSpaceCreateDeviceRGB(),(CGFloat[]){ 0, 0, 0, 0 })];//边框颜色
        [leftButton setTitle:@"返回" forState:UIControlStateNormal];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [leftButton setBackgroundColor:[UIColor colorWithRed:214.0/256.0 green:78.0/256.0 blue:78.0/256.0 alpha:1.0]];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [leftButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        leftButton.frame = CGRectMake(12,20, 60, 25);
        UIBarButtonItem *leftButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem=leftButtonItem;
    }

-(void)leftButtonClick
{
    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)refreashNavLab
    {
        UILabel * Lab= [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 100, 30)];
        Lab.text = @"浏览图片";
        Lab.textAlignment = NSTextAlignmentCenter;
        Lab.font = [UIFont systemFontOfSize:16];
        Lab.textColor = [UIColor blackColor];
        self.navigationItem.titleView =Lab;
    }
    
    
-(void)getData
    {
       
        ASIFormDataRequest* request;
        if ([worksOrsave isEqualToString:@"works"])
        {
             request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=workslist&page=%@",page]]];
        }
        else
        {
        request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=User&a=collectlist&page=%@",page]]];
        }
        
            request.delegate=self;
            request.tag=1;
       
            [request setPostValue:self.uid forKey:@"uid"];
            [request startAsynchronous];

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
            NSLog(@"粉丝列表dic:%@",dic);
            if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSString class]])
            {
                
            }
            else if ([[dic objectForKey:@"works_info"] isKindOfClass:[NSArray class]])
            {
                dresserArray = [dic objectForKey:@"works_info"];
                
            }
            [self freashView];
        
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
        
        if (dresserArray.count%3==0)
        {
            return dresserArray.count/3;
        }
        else
        {
            return dresserArray.count/3+1;
        }
    }
    
    - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        return   160;
    }
    
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        static NSString *cellID=@"cell";
        scanCell *cell=(scanCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell==nil) {
            cell=[[scanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            cell.fatherView =self;
        }
        NSUInteger row1 = [indexPath row]*3;
        NSLog(@"row1:%d",row1);
        NSUInteger row2 = [indexPath row]*3+1;
        NSLog(@"row2:%d",row2);
        NSUInteger row3 = [indexPath row]*3+2;
        NSLog(@"row3:%d",row3);
        [cell setCell:[dresserArray objectAtIndex:row1] andIndex:row1];
        if (row2<dresserArray.count)//防止可能越界
        {
          [cell setCell:[dresserArray objectAtIndex:row2] andIndex:row2];
        }
        if (row3<dresserArray.count)//防止可能越界
        {
            [cell setCell:[dresserArray objectAtIndex:row3] andIndex:row3];
        }
    return cell;
    }


-(void)selectImage:(NSInteger)_index
{
    demoView =nil;
    demoView  = [[DemoViewController alloc] init];
    demoView.imageArr =dresserArray;
    demoView.getindex =[NSString stringWithFormat:@"%d",_index];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    [appDele pushToViewController:demoView];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
