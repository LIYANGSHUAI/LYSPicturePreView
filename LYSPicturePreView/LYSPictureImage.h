//
//  LYSPictureImage.h
//  LYSPicturePreviewDemo
//
//  Created by HENAN on 2019/8/26.
//  Copyright © 2019 HENAN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYSPictureImage : UIView
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) void(^clickAction)(void);
@end

NS_ASSUME_NONNULL_END
