//
//  LYSPictureImage.m
//  LYSPicturePreviewDemo
//
//  Created by HENAN on 2019/8/26.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import "LYSPictureImage.h"

@interface LYSPictureImage ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGRect defaultRect;
@end

@implementation LYSPictureImage

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self customSubViews];
    }
    return self;
}

- (void)customSubViews
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.scrollView setMinimumZoomScale:1];
    [self.scrollView setMaximumZoomScale:3];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.scrollView setContentSize:self.bounds.size];
    [self addSubview:self.scrollView];
    self.imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview:self.imageView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
}
- (void)singleTapAction
{
    [self.scrollView setZoomScale:1 animated:YES];
    if (self.clickAction) {
        self.clickAction();
    }
}
- (void)doubleTapAction
{
    [self.scrollView setZoomScale:2 animated:YES];
    if (self.clickAction) {
        self.clickAction();
    }
}
- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
        NSURL *url = [NSURL URLWithString:imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        if(image != nil)
        {
            dispatch_async(dispatch_get_main_queue(),^{
                self.imageView.image = image;
                [self.imageView sizeToFit];
                CGFloat scale = CGRectGetWidth(self.bounds)/CGRectGetWidth(self.imageView.frame);
                CGFloat w = CGRectGetWidth(self.imageView.frame) * scale;
                CGFloat h = CGRectGetHeight(self.imageView.frame) * scale;
                CGFloat y = (CGRectGetHeight(self.bounds) - h) / 2.0;
                self.imageView.frame = CGRectMake(0, y, w, h);
                self.defaultRect = self.imageView.frame;
                [self.scrollView setContentSize:CGSizeMake(w, h)];
            });
        }
    });
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
    [self.imageView sizeToFit];
    CGFloat scale = CGRectGetWidth(self.bounds)/CGRectGetWidth(self.imageView.frame);
    CGFloat w = CGRectGetWidth(self.imageView.frame) * scale;
    CGFloat h = CGRectGetHeight(self.imageView.frame) * scale;
    CGFloat y = (CGRectGetHeight(self.bounds) - h) / 2.0;
    self.imageView.frame = CGRectMake(0, y, w, h);
    self.defaultRect = self.imageView.frame;
    [self.scrollView setContentSize:CGSizeMake(w, h)];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    float scale = scrollView.zoomScale;
    CGFloat w = CGRectGetWidth(self.defaultRect) * scale;
    CGFloat h = CGRectGetHeight(self.defaultRect) * scale;
    CGFloat y = (CGRectGetHeight(self.bounds) - h) / 2.0;
    self.imageView.frame = CGRectMake(0, y, w, h);
    [self.scrollView setContentSize:CGSizeMake(w, h)];
}

@end
