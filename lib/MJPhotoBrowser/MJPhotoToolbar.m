//
//  MJPhotoToolbar.m
//  FingerNews
//
//  Created by mj on 13-9-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJPhotoToolbar.h"
#import "MJPhoto.h"
#import "MBProgressHUD+Add.h"
#import "MJPhotoBrowser.h"

#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "commentViewController.h"
#import "AppDelegate.h"
@interface MJPhotoToolbar()
{
    // 显示页码
    UILabel *_indexLabel;
    UIButton *_saveImageBtn;
    
    
    UILabel* indexLabel;
    UILabel* clickLabel;
    
    NSMutableArray * imageArr;
    NSString * getindex;
    
    NSDictionary * dic;
    NSDictionary* diction;
    
    
    UIView * headBack;
    UIImageView * headImage;
    UIButton * headButton;
    UILabel  * nameLable;
    UILabel * cityLable;
    UIImageView * messageImage;
    UIButton * messageButton;
    UIImageView * commentImage;
    UIButton * commentButton;
    UIImageView * likeImage;
    UIButton * likeButton;
    UIImageView * shareImage;
    UIButton * shareButton;
    
    commentViewController * commentController;
}
@property (strong,nonatomic)NSMutableArray * imageArr;
@property (strong,nonatomic)    NSString * getindex;
@end

@implementation MJPhotoToolbar
@synthesize fatherView;
@synthesize imageArr;
@synthesize getindex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        diction = [[NSDictionary alloc] init];
        dic = [[NSDictionary alloc] init];
        sign= [[NSString alloc] init];
        
        self.backgroundColor = [UIColor redColor];
        headBack = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        headBack.backgroundColor = [UIColor whiteColor];
        headImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        [headBack addSubview: headImage];
        [self addSubview:headBack];
        
        nameLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 200, 20)];
        nameLable.textColor =[UIColor blackColor];
        nameLable.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:nameLable];
        cityLable = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 200, 20)];
        cityLable.textColor =[UIColor blackColor];
        cityLable.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:cityLable];
        
        
        messageImage = [[UIImageView alloc] initWithFrame:CGRectMake(160, 80, 30, 25)];
        messageImage.image = [UIImage imageNamed:@"sixin.png"];
        messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [messageButton addTarget:self action:@selector(messageButtonClick) forControlEvents:UIControlEventTouchUpInside];
        messageButton.frame = messageImage.frame;
        
        commentImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 80, 30, 25)];
        commentImage.image = [UIImage imageNamed:@"comment.png"];
        commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [commentButton addTarget:self action:@selector(commentButtonClick) forControlEvents:UIControlEventTouchUpInside];
        commentButton.frame = commentImage.frame;
        
        likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(240, 80, 30, 25)];
        likeImage.image = [UIImage imageNamed:@"like.png"];
        likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [likeButton addTarget:self action:@selector(likeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        likeButton.frame = likeImage.frame;
        
        shareImage = [[UIImageView alloc] initWithFrame:CGRectMake(280, 80, 30, 25)];
        shareImage.image = [UIImage imageNamed:@"fenxiang.png"];
        shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
        shareButton.frame = shareImage.frame;
        
        
        [self addSubview:messageImage];
        [self addSubview:commentImage];
        [self addSubview:likeImage];
        [self addSubview:shareImage];
        [self addSubview:messageButton];
        [self addSubview:commentButton];
        [self addSubview:likeButton];
        [self addSubview:shareButton];
        
        // Initialization code
    }
    return self;
}
-(void)getData
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Dynamic&a=workinfo"]]];
    request.delegate=self;
    request.tag=1;
    NSLog(@"appDele.uid111111:%@",appDele.uid);
    MJPhoto *photo =[_photos objectAtIndex:_currentPhotoIndex];
    NSLog(@"[_photos objectAtIndex:_currentPhotoIndex]:%@",photo.work_id);
    [request setPostValue:appDele.uid forKey:@"uid"];
    [request setPostValue:photo.work_id forKey:@"work_id"];
    [request startAsynchronous];
    
}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    //    if (dresserArray!=nil) {
    //        [dresserArray removeAllObjects];
    //    }
    if (request.tag==1) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        dic=[jsonP objectWithString:jsonString];
        NSLog(@"图片详情：dic:%@",dic);
        
        diction =[dic objectForKey:@"works_info"];
        
    }
    else if (request.tag==2) {
        NSLog(@"%@",request.responseString);
        NSData*jsondata = [request responseData];
        NSString*jsonString = [[NSString alloc]initWithBytes:[jsondata bytes]length:[jsondata length]encoding:NSUTF8StringEncoding];
        SBJsonParser* jsonP=[[SBJsonParser alloc] init];
        dic=[jsonP objectWithString:jsonString];
        NSLog(@"收藏dic:%@",dic);
        [self getData];
    }
    [self freashView];
    
}
-(void)freashView
{
    [headImage setImageWithURL:[NSURL URLWithString:[diction objectForKey:@"head_photo"]]];
    nameLable.text = [diction objectForKey:@"username"];
    cityLable.text = [diction objectForKey:@"content"];
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    
    if ([[diction objectForKey:@"uid"] isEqualToString:appDele.uid])
    {
        messageImage.hidden=YES;
    }
    else
    {
        messageImage.hidden=NO;
    }
    
    if ([[diction objectForKey:@"islike"] isEqualToString:@"0"])
    {
        likeButton.tag=0;
        likeImage.image = [UIImage imageNamed:@"like.png"];
        
    }
    else
    {
        likeButton.tag=1;
        likeImage.image = [UIImage imageNamed:@"like1.png"];
    }
}

-(void)messageButtonClick
{
    
}
-(void)commentButtonClick
{
    commentController= nil;
    commentController = [[commentViewController alloc] init];
    commentController.inforDic = dic;
    [fatherView pushViewController:commentController];
//    [self.navigationController pushViewController:commentController animated:NO];
}
-(void)likeButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid) {
        [fatherView pushViewController:nil];
    }
    else
    {
        ASIFormDataRequest* request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/index.php?m=Works&a=collection"]]];
        request.delegate=self;
        request.tag=2;
        [request setPostValue:appDele.uid forKey:@"uid"];
        [request setPostValue:[diction objectForKey:@"uid"] forKey:@"to_uid"];
        [request setPostValue:[diction objectForKey:@"work_id"] forKey:@"work_id"];
        if (likeButton.tag==0)
        {
            likeButton.tag=1;
            likeImage.image = [UIImage imageNamed:@"like1.png"];
            [request setPostValue:@"1" forKey:@"status"];
            
        }
        else
        {
            likeButton.tag=0;
            likeImage.image = [UIImage imageNamed:@"like.png"];
            [request setPostValue:@"0" forKey:@"status"];
            
        }
        [request startAsynchronous];
    }
}
-(void)shareButtonClick
{
    AppDelegate* appDele=(AppDelegate* )[UIApplication sharedApplication].delegate;
    if (!appDele.uid)
    {
        [fatherView pushViewController:nil];
    }
    else
    {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"请选择方式"
                                      delegate:self
                                      cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"分享到QQ空间"
                                      otherButtonTitles:@"分享到新浪微博",nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
        [actionSheet showInView:self];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
    {
        if (buttonIndex == 0)
        {
            
            TencentOAuth* _tentenOAuth;
            AppDelegate* dele=(AppDelegate*)[UIApplication sharedApplication].delegate;
            
            _tentenOAuth=dele.tententOAuth;
            //
//            NSLog(@"_tentenOAuth:%@",_tentenOAuth.accessToken);
//             NSLog(@"_tentenOAuth:%@",_tentenOAuth.openId);
//            NSLog(@"_tentenOAuth:%@",_tentenOAuth.expirationDate);

            TCAddShareDic *params = [TCAddShareDic dictionary];
            params.paramTitle = @"我通过使用发型屋找到一款很好看的发型，点击跳转";
            params.paramComment = @"潮流必备软件——发型屋";
            params.paramSummary= @"发型屋是一款潮流达人必备的一款软件，它可以帮助你找到你想要的发型，在线预约发型师，折扣价格，查看他人推荐发型并实时聊天";
            
            NSLog(@"%@",[diction objectForKey:@"works_pic"]);
            
            params.paramImages = [[diction objectForKey:@"works_pic"] firstObject];
            params.paramUrl = [NSString stringWithFormat:@"http://wap.faxingw.cn/web.php?m=Share&a=index&id=%@",[[diction objectForKey:@"works_id"] firstObject]];
            
            if(![_tentenOAuth addShareWithParams:params])
            {
                sign =@"qq";
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"你尚未绑定QQ账号,或你的账号授权已过期,需要重新获取" delegate:self cancelButtonTitle:@"暂不绑定" otherButtonTitles:@"现在绑定", nil];
                [alert show];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",@"操作成功"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
            }
            
        }


        else if (buttonIndex == 1)
        {
            AppDelegate* dele=(AppDelegate*)[UIApplication sharedApplication].delegate;
            SinaWeibo* _sinaWeibo=dele.sinaweibo;
             NSLog(@"%@",[diction objectForKey:@"works_pic"]);
            NSString* upText=[@"" stringByAppendingFormat:@"我通过使用发型屋找到一款很好看的发型，点击跳转>>>>>http://www.faxingw.cn/soufaxing/%@_hairpic.html",[diction objectForKey:@"works_id"]];
            [_sinaWeibo requestWithURL:@"statuses/upload.json"
                                params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        upText, @"status",
                                        [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[diction objectForKey:@"works_pic"] firstObject]]]], @"pic", nil]
                            httpMethod:@"POST"
                              delegate:self];
//            NSString* upText=[NSString stringWithFormat:@"我通过使用发型屋找到一款很好看的发型，点击跳转>>>>>http://wap.faxingw.cn/web.php?m=Share&a=index&id=%@",[diction objectForKey:@"works_id"]];
//            [_sinaWeibo requestWithURL:@"statuses/upload.json"
//                                params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                        upText, @"status",
//                                        [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/web.php?m=Share&a=index&id=%@",[diction objectForKey:@"works_id"]]]]], @"pic", nil]
//                            httpMethod:@"POST"
//                              delegate:self];
        }
        else if(buttonIndex == 2)
        {
            
        }
    }

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"move failed:%@", [error localizedDescription]);
    sign =@"sina";
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"你尚未绑定新浪微博账号,或你的账号授权已过期,需要重新获取" delegate:self cancelButtonTitle:@"暂不绑定" otherButtonTitles:@"现在绑定", nil];
    [alert show];
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    //    [self.indicator stopAnimating];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",@"操作成功"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
   if (buttonIndex == 1)
   {
       rigView = nil;
       rigView  = [[rigViewController alloc] init] ;
       rigView._hidden = NO;
       rigView._backsign = sign;
       [rigView getBack:self andSuc:@selector(rigThenshare) andErr:nil];
       [fatherView pushViewController:rigView];

   }
   else
   {
   
   }
}

-(void)rigThenshare
{
    if ([sign isEqualToString:@"qq"])//qq绑定返回触发
    {
        TencentOAuth* _tentenOAuth;
        AppDelegate* dele=(AppDelegate*)[UIApplication sharedApplication].delegate;
        
        _tentenOAuth=dele.tententOAuth;
        //
        //            NSLog(@"_tentenOAuth:%@",_tentenOAuth.accessToken);
        //             NSLog(@"_tentenOAuth:%@",_tentenOAuth.openId);
        //            NSLog(@"_tentenOAuth:%@",_tentenOAuth.expirationDate);
        
        TCAddShareDic *params = [TCAddShareDic dictionary];
        params.paramTitle = @"我通过使用发型屋找到一款很好看的发型，点击跳转";
        params.paramComment = @"潮流必备软件——发型屋";
        params.paramSummary= @"发型屋是一款潮流达人必备的一款软件，它可以帮助你找到你想要的发型，在线预约发型师，折扣价格，查看他人推荐发型并实时聊天";
        
        NSLog(@"%@",[diction objectForKey:@"works_pic"]);
        
        params.paramImages = [[diction objectForKey:@"works_pic"] firstObject];
        params.paramUrl = [NSString stringWithFormat:@"http://wap.faxingw.cn/web.php?m=Share&a=index&id=%@",[[diction objectForKey:@"works_id"] firstObject]];
        
        if(![_tentenOAuth addShareWithParams:params])
        {
            sign =@"qq";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"你尚未绑定QQ账号,或你的账号授权已过期,需要重新获取" delegate:self cancelButtonTitle:@"暂不绑定" otherButtonTitles:@"现在绑定", nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",@"操作成功"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }

    }
    else//新浪绑定返回触发
    {
        AppDelegate* dele=(AppDelegate*)[UIApplication sharedApplication].delegate;
        SinaWeibo* _sinaWeibo=dele.sinaweibo;
        NSLog(@"%@",[diction objectForKey:@"works_pic"]);
        NSString* upText=[@"" stringByAppendingFormat:@"我通过使用发型屋找到一款很好看的发型，点击跳转>>>>>http://www.faxingw.cn/soufaxing/%@_hairpic.html",[diction objectForKey:@"works_id"]];
        [_sinaWeibo requestWithURL:@"statuses/upload.json"
                            params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    upText, @"status",
                                    [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[diction objectForKey:@"works_pic"] firstObject]]]], @"pic", nil]
                        httpMethod:@"POST"
                          delegate:self];
        //            NSString* upText=[NSString stringWithFormat:@"我通过使用发型屋找到一款很好看的发型，点击跳转>>>>>http://wap.faxingw.cn/web.php?m=Share&a=index&id=%@",[diction objectForKey:@"works_id"]];
        //            [_sinaWeibo requestWithURL:@"statuses/upload.json"
        //                                params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
        //                                        upText, @"status",
        //                                        [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wap.faxingw.cn/web.php?m=Share&a=index&id=%@",[diction objectForKey:@"works_id"]]]]], @"pic", nil]
        //                            httpMethod:@"POST"
        //                              delegate:self];
    }
}
    - (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
        
    }
    -(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
        
    }
    -(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex
{
        
    }



- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    if (_photos.count > 1) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.font = [UIFont boldSystemFontOfSize:20];
        _indexLabel.frame = self.bounds;
        _indexLabel.backgroundColor = [UIColor redColor];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        [self addSubview:_indexLabel];
    }
    
    // 保存图片按钮
    CGFloat btnWidth = self.bounds.size.height;
    _saveImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveImageBtn.frame = CGRectMake(20, 0, btnWidth, btnWidth);
    _saveImageBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [_saveImageBtn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon.png"] forState:UIControlStateNormal];
    [_saveImageBtn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon_highlighted.png"] forState:UIControlStateHighlighted];
    [_saveImageBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_saveImageBtn];
}

- (void)saveImage
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MJPhoto *photo = _photos[_currentPhotoIndex];
        UIImageWriteToSavedPhotosAlbum(photo.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showSuccess:@"保存失败" toView:nil];
    } else {
        MJPhoto *photo = _photos[_currentPhotoIndex];
        photo.save = YES;
        _saveImageBtn.enabled = NO;
        [MBProgressHUD showSuccess:@"成功保存到相册" toView:nil];
    }
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    // 更新页码
    _indexLabel.text = [NSString stringWithFormat:@"发型图册(%d / %d)", _currentPhotoIndex + 1, _photos.count];
    
    MJPhoto *photo = _photos[_currentPhotoIndex];
    // 按钮
    _saveImageBtn.enabled = photo.image != nil && !photo.save;
    
    [fatherView refreashNavLab:_currentPhotoIndex+1 and:_photos.count];
//     [self getData];
}

@end
