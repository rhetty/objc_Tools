//
//  BrowsableImageView.m
//  Created by Jiawei Huang on 2017/1/14.
//

#import "BrowsableImageView.h"

static const CGFloat kMaxZoomScale = 2.0f;
static const NSTimeInterval kAnimationInterval = 0.3f;

@interface BrowsableImageView() <UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIImageView *browsingImgView;
@property (nonatomic, assign) CGRect originalFrame;
@end

@implementation BrowsableImageView

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self enableTap];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self enableTap];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self enableTap];
  }
  return self;
}

- (void)enableTap
{
  self.userInteractionEnabled = YES;
  UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
  [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
  if (!self.image) {
    return;
  }
  // Create background view
  UIScrollView *bgView = [[UIScrollView alloc] init];
  bgView.frame = [UIScreen mainScreen].bounds;
  bgView.backgroundColor = [UIColor clearColor];
  UITapGestureRecognizer *tapBg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView:)];
  [bgView addGestureRecognizer:tapBg];
  bgView.maximumZoomScale = kMaxZoomScale;
  bgView.delegate = self;
  
  // Create new image view
  UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
  imageView.contentMode = self.contentMode;
  imageView.clipsToBounds = self.clipsToBounds;
  
  CGRect oRect = self.frame;
  CGRect fRect = CGRectZero;
  oRect = [self.superview convertRect:oRect toView:[UIApplication sharedApplication].keyWindow];
  
  if (imageView.image.size.width / imageView.image.size.height > bgView.frame.size.width / bgView.frame.size.height) {
    CGFloat imgHeight = imageView.image.size.height / imageView.image.size.width * bgView.frame.size.width;
    fRect = CGRectMake(0, (bgView.frame.size.height - imgHeight) * 0.5, bgView.frame.size.width, imgHeight);
  } else {
    CGFloat imgWidth = imageView.image.size.width / imageView.image.size.height * bgView.frame.size.height;
    fRect = CGRectMake((bgView.frame.size.width - imgWidth) * 0.5, 0, imgWidth, bgView.frame.size.height);
  }
  imageView.frame = oRect;
  
  // Display
  [bgView addSubview:imageView];
  [[[UIApplication sharedApplication] keyWindow] addSubview:bgView];
  
  self.browsingImgView = imageView;
  self.originalFrame = oRect;
  self.scrollView = bgView;
  
  [UIView animateWithDuration:kAnimationInterval animations:^{
    imageView.frame = fRect;
    self.scrollView.backgroundColor = [UIColor blackColor];
  }];
}

-(void)tapBgView:(UITapGestureRecognizer *)tapBgRecognizer
{
  self.scrollView.contentOffset = CGPointZero;
  [UIView animateWithDuration:kAnimationInterval animations:^{
    self.browsingImgView.frame = self.originalFrame;
    tapBgRecognizer.view.backgroundColor = [UIColor clearColor];
  } completion:^(BOOL finished) {
    [tapBgRecognizer.view removeFromSuperview];
    self.scrollView = nil;
    self.browsingImgView = nil;
  }];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return self.browsingImgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
  CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
  (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
  CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
  (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
  self.browsingImgView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                               scrollView.contentSize.height * 0.5 + offsetY);
}

@end
