//
//  KLNewFeatureViewController.m
//  JKStore
//
//  Created by Kuroba.Lei on 2018/6/12.
//  Copyright © 2018年 K.Lei. All rights reserved.
//

#import "JKFeatureViewController.h"
#import "JKFeatureCell.h"

@interface JKFeatureViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* collectionview */
@property (strong , nonatomic)UICollectionView *collectionView;

/* 图片数组 */
@property (nonatomic, copy) NSArray *imageArray;

/** 是否显示跳过按钮, 默认不显示 */
@property (nonatomic, assign) BOOL showSkip;
/** 是否显示page小圆点, 默认不显示 */
@property (nonatomic, assign) BOOL showPageCount;

/* 小圆点选中颜色 */
@property (nonatomic, strong) UIColor *selColor;
/* 跳过按钮 */
@property (nonatomic, strong) UIButton *skipButton;

/* page */
@property (strong , nonatomic)UIPageControl *pageControl;

// 最后一张底端的立即体验按钮
@property (nonatomic, strong) UIButton *jumpButton;

@end

static NSString *const KLNewFeatureCellID = @"JKFeatureCell";

@implementation JKFeatureViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *klFlowLayout = [UICollectionViewFlowLayout new];
        klFlowLayout.minimumLineSpacing = klFlowLayout.minimumInteritemSpacing = 0;
        klFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:klFlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = [UIScreen mainScreen].bounds;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.view insertSubview:_collectionView atIndex:0];
        
        [_collectionView registerClass:[JKFeatureCell class] forCellWithReuseIdentifier:KLNewFeatureCellID];
    }
    return _collectionView;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipButton.frame = CGRectMake(ScreenWidth - 80, NavigationHeight-44+(44-26)/2.0f, 60, 26);
        [_skipButton addTarget:self action:@selector(skipButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _skipButton.hidden = YES;
        _skipButton.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.8];
        _skipButton.titleLabel.font = PING_FANG(14.0f);
        _skipButton.layer.cornerRadius = _skipButton.frame.size.height/2.0f;
        _skipButton.layer.masksToBounds = YES;
        _skipButton.hidden = YES;
        [self.view addSubview:_skipButton];
    }return _skipButton;
}

- (UIPageControl *)pageControl {
    if (!_pageControl && _imageArray.count != 0) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.numberOfPages = _imageArray.count;
        _pageControl.userInteractionEnabled = false;
        [_pageControl setPageIndicatorTintColor:RGBA(255, 199, 204, 1)];
        UIColor *currColor = (_selColor == nil) ? RGBA(248, 26, 45, 1) : _selColor;
        [self.pageControl setCurrentPageIndicatorTintColor:currColor];
        _pageControl.frame = CGRectMake(0, ScreenHeight * 0.95, ScreenWidth, 35);
        [self.view addSubview:_pageControl];
    }return _pageControl;
}

#pragma mark - 基础设置
- (void)setUpFeatureAttribute:(void(^)(NSArray **imageArray,UIColor **selColor,BOOL *showSkip,BOOL *showPageCount))BaseSettingBlock {
    NSArray *imageArray;
    UIColor *selColor;
    
    BOOL showSkip;
    BOOL showPageCount;
    
    if (BaseSettingBlock) {
        BaseSettingBlock(&imageArray, &selColor, &showSkip, &showPageCount);
        
        self.imageArray = imageArray;
        self.selColor = selColor;
        self.showSkip = showSkip;
        self.showPageCount = showPageCount;
    }
}

#pragma mark - 是否展示跳过按钮
- (void)setShowSkip:(BOOL)showSkip {
    _showSkip = showSkip;
    self.skipButton.hidden = !self.showSkip;
}

#pragma mark - 是否展示page小圆点
- (void)setShowPageCount:(BOOL)showPageCount {
    _showPageCount = showPageCount;
    self.pageControl.hidden = !self.showPageCount;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBA(200, 200, 200, 1);
    
    [self.skipButton setTitle:@"跳过" forState:0];
    self.collectionView.backgroundColor = RGBA(200, 200, 200, 1);
    self.automaticallyAdjustsScrollViewInsets = false;
    
    [self.view bringSubviewToFront:self.jumpButton];
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JKFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KLNewFeatureCellID forIndexPath:indexPath];
    
    cell.nfImageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    
    cell.nfImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.hideBtnImg = @"hidden";
    [cell kl_GetCurrentPageIndex:indexPath.row lastPageIndex:_imageArray.count - 1];
    WS(weakSelf);
    cell.hideButtonClickBlock = ^{
        [weakSelf restoreRootViewController:nil];
    };
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _imageArray.count - 1) {
        [self skipButtonClick];
    }
}
#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenWidth, ScreenHeight);
}

#pragma mark - 通过代理来让她滑到最后一页再左滑动就切换控制器
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (_imageArray.count < 2) return; //一张图或者没有直接返回
        _collectionView.bounces = (scrollView.contentOffset.x > (_imageArray.count - 2) * ScreenWidth) ? YES : NO;
    if (scrollView.contentOffset.x >  (_imageArray.count - 1) * ScreenWidth) {
        [self restoreRootViewController:nil];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (!_showPageCount) return;
    CGPoint currentPoint = scrollView.contentOffset;
    NSInteger page = currentPoint.x / scrollView.frame.size.width;
    _pageControl.currentPage = page;
    
    if (page == _imageArray.count - 1) {
        self.jumpButton.hidden = NO;
    }else {
        self.jumpButton.hidden = YES;
    }
}

- (void)restoreRootViewController:(UIViewController *)rootViewController {
    [UIView transitionWithView:[UIApplication sharedApplication].keyWindow duration:0.7f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
//        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
//        [[AppDelegate sharedPorfiles] enterRootViewController];
        [UIView setAnimationsEnabled:oldState];
        
    } completion:nil];
}


#pragma mark - 跳过点击
- (void)skipButtonClick {
    [self restoreRootViewController:nil];
}


- (UIButton *)jumpButton {
    if (!_jumpButton) {
        _jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_jumpButton setImage:IMAGE_NAME(@"jk_pro_welcome_III_button") forState:UIControlStateNormal];
            _jumpButton.frame = CGRectMake(0, 0.95*ScreenHeight - WIDTH_SCALE(16.0f)-ScreenWidth/3.0f*36.0/125.0f, ScreenWidth/3.0f, ScreenWidth/3.0f*36.0/125.0f);
            _jumpButton.center = CGPointMake(self.view.center.x, _jumpButton.center.y);
//        _jumpButton.frame = CGRectMake(0, 0, ScreenWidth/3.0f, ScreenWidth/3.0f*36.0/125.0f);
//        _jumpButton.center = self.view.center;
        _jumpButton.adjustsImageWhenHighlighted = false;
        _jumpButton.hidden = YES;
        _jumpButton.userInteractionEnabled = NO;
        [self.view addSubview:_jumpButton];
        
    }return _jumpButton;
}

@end
