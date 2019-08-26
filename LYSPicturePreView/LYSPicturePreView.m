//
//  LYSPicturePreView.m
//  LYSPicturePreviewDemo
//
//  Created by HENAN on 2019/8/26.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSPicturePreView.h"
#import "LYSPictureImage.h"

#define LYSPICTUREFANHUI @"iVBORw0KGgoAAAANSUhEUgAAACgAAAAoEAYAAADcbmQuAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAgY0hSTQAAeiYAAICEAAD6AAAAgOgAAHUwAADqYAAAOpgAABdwnLpRPAAAAAZiS0dEAAAAAAAA+UO7fwAAAAlwSFlzAAAASAAAAEgARslrPgAAAgtJREFUaN7tmrFqAkEURaOijSJIQAQxIFgIIlaKvfoFNlZBSGNlJWhpKfgBwS8QvyBNIBC0EBQsLATBSrSJlU2IOi/FxUJYt5mBNwnvNBeWQa6HHd2ZnYeHfw4pUqQKBSIiovkcOR7j+tMTdz9rgaByGcKOR3Kk0+HuaR0QU60iv7+dxR0OyHSau6814I57foaY08lZ3H6Pcbkcd19rgJBmE4KUcha32WBcKsXdlx0I8XiQ3S65slwi43Hu3uxAhM+HHAzcxU2nyMdH7t7sYOoFAhAyGt11pkiRen9HhkLcvdmBlWAQ+fbmfscNhxDn93P3ZgdCIhHkZOIu7vUV6fVy92YHImIx5GLhLq7X4+5rDRCSTCLX6zs/cApTtNXi7msNEJPJILdbZ3HnM/LlhbuvNdwu7r++nMVdl2DVKndfa4CQUgl5b3F/PEJwpcLd1xogplZD/vw4i7su7otF7r7WACGNBvJycRa32+GOy2a5+1oDxLTb7o8hq5VsaN4I83ggpN93FzefY1w0yt3bGiCmXr/rTJEi9fGBDIe5+5rG0BKIiPuL/FlkChtG/kQMIY8xhpAHaUNAkCzltJHNBENAkGxnaQNBsqGqDUTJlr42ECQvlbSBGHmtqY28WDcELMnRDm0gRg4XGUOOtxlCDlgaAqLkiK82csjcEBCZz0PYbIb8/MT1REL3838Bz/vn34Vzt/cAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTktMDgtMjZUMTc6NDY6MzcrMDg6MDCJOQzAAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDE5LTA4LTI2VDE3OjQ2OjM3KzA4OjAw+GS0fAAAAEp0RVh0c3ZnOmJhc2UtdXJpAGZpbGU6Ly8vaG9tZS9hZG1pbi9pY29uLWZvbnQvdG1wL2ljb25fdWFlZzB5eTFmYWIvZmFuaHVpMS5zdmfnVrN2AAAAAElFTkSuQmCC"

#define ISDAILIUHAI (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 896)) || CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)))

@interface LYSPicturePreView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIView *topToolView;
@property (nonatomic, assign) BOOL showToolViewEnable;
@property (nonatomic, strong) NSArray *titles;
@end

@implementation LYSPicturePreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self customSubViews];
    }
    return self;
}

- (void)customSubViews
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.scrollView];
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds)-50-(ISDAILIUHAI ? 34 : 0), CGRectGetWidth(self.bounds), 50)];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:self.pageControl];
    self.topToolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 44+(ISDAILIUHAI ? 44 : 20))];
    self.topToolView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    [self addSubview:self.topToolView];
    self.topToolView.hidden = YES;
    NSData *decodeData = [[NSData alloc]initWithBase64EncodedString:LYSPICTUREFANHUI options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
    UIImage *decodedImage = [UIImage imageWithData: decodeData];
    decodedImage = [self imageChangeColor:[UIColor darkGrayColor] image:decodedImage];
    UIImageView *backBtn = [[UIImageView alloc] initWithImage:decodedImage];
    backBtn.frame = CGRectMake(15, 12+(ISDAILIUHAI ? 44 : 20), 20, 20);
    [self.topToolView addSubview:backBtn];
    
    UITapGestureRecognizer *backClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClick)];
    [self addGestureRecognizer:backClick];
    
    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (ISDAILIUHAI ? 44 : 20), 100, 44)];
    self.topLabel.textColor = [UIColor whiteColor];
    [self.topToolView addSubview:self.topLabel];
}

- (void)backClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickBackBtnAction)]) {
        [self.delegate didClickBackBtnAction];
    }
}

- (UIImage*)imageChangeColor:(UIColor *)color image:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(bounds);
    [image drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
- (void)showToolView
{
    self.topToolView.hidden = NO;
}

- (void)hiddenToolView
{
    self.topToolView.hidden = YES;
}

- (void)updateImageUrlWith:(NSArray<NSString *> *)imageUrls titles:(NSArray<NSString *> *)titles currentPage:(NSInteger)currentPage
{
    self.titles = titles;
    CGFloat w = CGRectGetWidth(self.bounds);
    CGFloat h = CGRectGetHeight(self.bounds);
    [imageUrls enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LYSPictureImage *imageView = [[LYSPictureImage alloc] initWithFrame:CGRectMake(w * idx, 0, w, h)];
        imageView.imageUrl = obj;
        [self.scrollView addSubview:imageView];
        [imageView setClickAction:^{
            self.showToolViewEnable = !self.showToolViewEnable;
            if (self.showToolViewEnable) {
                [self showToolView];
            } else {
                [self hiddenToolView];
            }
        }];
    }];
    [self.scrollView setContentSize:CGSizeMake(imageUrls.count * w, h)];
    [self.scrollView setContentOffset:CGPointMake(w * currentPage, 0)];
    self.pageControl.numberOfPages = imageUrls.count;
    self.pageControl.currentPage = currentPage;
    self.topLabel.text = self.titles[currentPage];
    [self.topLabel sizeToFit];
    CGFloat x = (CGRectGetWidth(self.topToolView.frame) - CGRectGetWidth(self.topLabel.frame))/2.0;
    self.topLabel.frame = CGRectMake(x, (ISDAILIUHAI ? 44 : 20), CGRectGetWidth(self.topLabel.frame), 44);
}

- (void)updateImageWith:(NSArray<UIImage *> *)images titles:(NSArray<NSString *> *)titles currentPage:(NSInteger)currentPage
{
    self.titles = titles;
    CGFloat w = CGRectGetWidth(self.bounds);
    CGFloat h = CGRectGetHeight(self.bounds);
    [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LYSPictureImage *imageView = [[LYSPictureImage alloc] initWithFrame:CGRectMake(w * idx, 0, w, h)];
        imageView.image = obj;
        [self.scrollView addSubview:imageView];
        [imageView setClickAction:^{
            self.showToolViewEnable = !self.showToolViewEnable;
            if (self.showToolViewEnable) {
                [self showToolView];
            } else {
                [self hiddenToolView];
            }
        }];
    }];
    [self.scrollView setContentSize:CGSizeMake(images.count * w, h)];
    [self.scrollView setContentOffset:CGPointMake(w * currentPage, 0)];
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = currentPage;
    self.topLabel.text = self.titles[currentPage];
    [self.topLabel sizeToFit];
    CGFloat x = (CGRectGetWidth(self.topToolView.frame) - CGRectGetWidth(self.topLabel.frame))/2.0;
    self.topLabel.frame = CGRectMake(x, (ISDAILIUHAI ? 44 : 20), CGRectGetWidth(self.topLabel.frame), 44);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / CGRectGetWidth(self.bounds);
    self.pageControl.currentPage = index;
    self.topLabel.text = self.titles[index];
    [self.topLabel sizeToFit];
    CGFloat x = (CGRectGetWidth(self.topToolView.frame) - CGRectGetWidth(self.topLabel.frame))/2.0;
    self.topLabel.frame = CGRectMake(x, (ISDAILIUHAI ? 44 : 20), CGRectGetWidth(self.topLabel.frame), 44);
}

@end
