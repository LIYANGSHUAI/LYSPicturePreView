# LYSPicturePreView
简单实现一个图片预览组件

```objc
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

```
