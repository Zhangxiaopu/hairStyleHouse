//
//  scanCell.m
//  hairStyleHouse
//
//  Created by jeason on 13-11-28.
//  Copyright (c) 2013年 jeason. All rights reserved.
//

#import "scanCell.h"
#import "scanImageViewController.h"
#import "UIImageView+WebCache.h"
@implementation scanCell
@synthesize fatherView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        firstImage = [[UIImageView alloc ] init];
       
        secondImage = [[UIImageView alloc ] init];
        
        thirdImage = [[UIImageView alloc ] init];
        
        
        firstButton = [UIButton buttonWithType:UIButtonTypeCustom];
        secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
        thirdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [firstButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
         [secondButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
         [thirdButton addTarget:self action:@selector(imageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:firstImage];
        [self addSubview:firstButton];
        [self addSubview:secondImage];
        [self addSubview:secondButton];
        [self addSubview:thirdImage];
        [self addSubview:thirdButton];
        // Initialization code
    }
    return self;
}
-(void)setCell:(NSDictionary *)dic andIndex:(NSInteger)index
{
    if (index%3==0)
    {
        NSString * headStr= [dic objectForKey:@"work_image"];
        [firstImage setImageWithURL:[NSURL URLWithString:headStr]];
        firstImage.frame =CGRectMake(12, 20, 90, 120);
        firstButton.frame =CGRectMake(12, 20, 90, 120);
        firstButton.tag = index;
    }
    else if (index%3==1)
    {
        NSString * headStr= [dic objectForKey:@"work_image"];
        [secondImage setImageWithURL:[NSURL URLWithString:headStr]];
        secondImage.frame =CGRectMake(114, 20, 90, 120);
        secondButton.frame =CGRectMake(114, 20, 90, 120);
        secondButton.tag = index;
    }
    else if (index%3==2)
    {
        NSString * headStr= [dic objectForKey:@"work_image"];
        [thirdImage setImageWithURL:[NSURL URLWithString:headStr]];
        thirdImage.frame =CGRectMake(216, 20, 90, 120);
        thirdButton.frame =CGRectMake(216, 20, 90, 120);
        thirdButton.tag = index;
    }
}

-(void)imageButtonClick:(UIButton *)_button
{
    [fatherView selectImage:_button.tag];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
