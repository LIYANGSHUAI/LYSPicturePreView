//
//  ViewController.m
//  LYSPicturePreviewDemo
//
//  Created by HENAN on 2019/8/26.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "ViewController.h"
#import "LYSPicturePreView.h"
@interface ViewController ()<LYSPicturePreViewDelegate>
@property (nonatomic,strong) LYSPicturePreView *preview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.preview = [[LYSPicturePreView alloc] initWithFrame:self.view.bounds];
    
    
//    [self.preview updateImageUrlWith:@[@"http://pic33.nipic.com/20131007/13639685_123501617185_2.jpg",@"http://pic26.nipic.com/20121221/9252150_142515375000_2.jpg",@"https://ss3.baidu.com/-rVXeDTa2gU2pMbgoY3K/it/u=2381973937,1303139169&fm=202&mola=new&crop=v1"] titles:@[@"测试1",@"测试2",@"测试3"] currentPage:0];
    
    UIImage *image1 = [UIImage imageNamed:@"1.jpg"];
    UIImage *image2 = [UIImage imageNamed:@"2.jpg"];
    UIImage *image3 = [UIImage imageNamed:@"3.jpg"];
    UIImage *image4 = [UIImage imageNamed:@"4.jpg"];
    UIImage *image5 = [UIImage imageNamed:@"5.jpg"];
    [self.preview updateImageWith:@[image1,image2,image3,image4,image5] titles:@[@"1",@"2",@"3",@"4",@"5"] currentPage:2];
    
    self.preview.topLabel.textColor = [UIColor grayColor];
    self.preview.delegate = self;
    
}

- (void)didClickBackBtnAction
{
    [self.preview removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view addSubview:self.preview];
}

@end
