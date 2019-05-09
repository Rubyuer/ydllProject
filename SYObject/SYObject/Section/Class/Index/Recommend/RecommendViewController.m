//
//  RecommendViewController.m
//  SYObject
//
//  Created by Jejms on 2019/5/6.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "RecommendViewController.h"

#import "DetailsViewController.h"

@interface RecommendViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"热门推荐";
    
    self.scrollView.hidden = YES;
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
        self.scrollView.hidden = NO;
    });
}

- (IBAction)action:(UIButton *)sender {
    if (sender.tag == 0) {
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 1) {
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 2) {
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 3;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 3) {
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 4;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 4) {
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 7;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 5) {
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 8;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 6) {
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 9;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (sender.tag == 7) {
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = 10;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
