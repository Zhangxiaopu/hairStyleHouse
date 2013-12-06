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
#import "AppDelegate.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "commentViewController.h"
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
    NSLog(@"appDele.uid:%@",appDele.uid);
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
-(void)shareButtonClick
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
     [self getData];
}

@end
