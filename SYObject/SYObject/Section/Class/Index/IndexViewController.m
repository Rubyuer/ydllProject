//
//  IndexViewController.m
//  SYObject
//
//  Created by Jejms on 2019/5/6.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "IndexViewController.h"
#import "ImageCollectionViewCell.h"

#import "RecommendViewController.h"

#import "IndexSubViewController.h"
#import "DetailsViewController.h"

@interface IndexViewController ()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *scBgView;

@property (weak, nonatomic) IBOutlet UIView *funView;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation IndexViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([CoreStatus isNetworkEnable]) {
        _funView.hidden = NO;
    }else {
        _funView.hidden = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    [self initUI];
}
- (void)refreshData {
    if ([CoreStatus isNetworkEnable]) {
        _funView.hidden = NO;
    }else {
        _funView.hidden = YES;
    }
    [_scrollView.mj_header endRefreshing];
}

- (IBAction)more:(UIButton *)sender {
    RecommendViewController *vc = [[RecommendViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)item:(UIButton *)sender {
    if ([CoreStatus isNetworkEnable]) {
        
    }else {
        [MBProgressHUD showErrorNo:@"无网络" toView:ShareAppDelegate.window];
        return;
    }
    if (sender.tag == 0 || sender.tag == 1 || sender.tag == 2 || sender.tag == 3) {
        IndexSubViewController *vc = [[IndexSubViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = sender.tag + 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (sender.tag == 4) { // 热门推荐 - 三文鱼
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 5) { // 热门推荐 - 鳗鱼寿司
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 6) { // 热门推荐 - 海峡卷
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 3;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 7) { // 热门推荐 - 军舰寿司
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 4;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)initUI {
    WS(weakSelf);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    _scrollView.mj_header = header;
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 318/690.0*ScreenWidth) delegate:self placeholderImage:[UIImage qmui_imageWithColor:RGBA(248, 248, 248, 0)]];
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.backgroundColor = RGBA(248, 248, 248, 1);
    cycleScrollView.autoScrollTimeInterval = 6;
    cycleScrollView.delegate = self;
    cycleScrollView.showPageControl = YES;
    cycleScrollView.localizationImageNamesGroup = @[@"index_collection_1", @"index_collection_2", @"index_collection_3"];
    [self.scBgView addSubview:cycleScrollView];
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    _numLabel.text = [NSString stringWithFormat:@"%ld",index + 1];
}



@end
