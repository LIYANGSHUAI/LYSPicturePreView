//
//  LYSPicturePreView.h
//  LYSPicturePreviewDemo
//
//  Created by HENAN on 2019/8/26.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LYSPicturePreViewDelegate <NSObject>

- (void)didClickBackBtnAction;

@end

@interface LYSPicturePreView : UIView
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, assign) id<LYSPicturePreViewDelegate> delegate;
// 加载网络图片,并默认显示第几张图
- (void)updateImageUrlWith:(NSArray<NSString *> *)imageUrls titles:(NSArray<NSString *> *)titles currentPage:(NSInteger)currentPage;
// 加载本地图片,并默认显示第几张图
- (void)updateImageWith:(NSArray<UIImage *> *)images titles:(NSArray<NSString *> *)titles currentPage:(NSInteger)currentPage;
@end

NS_ASSUME_NONNULL_END
