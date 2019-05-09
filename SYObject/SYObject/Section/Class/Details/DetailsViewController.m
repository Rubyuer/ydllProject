//
//  DetailsViewController.m
//  SYObject
//
//  Created by Jejms on 2019/5/7.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailHeadView.h"
#import "DetailTableViewCell.h"

#import "OrderPopView.h"

#import "OrderListViewController.h"
#import "CommentViewController.h"

@interface DetailsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) DetailHeadView *headView;

@property (nonatomic, strong) GoodModel *model;

@property (weak, nonatomic) IBOutlet UIButton *collectButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    
    _model = [[GoodModel alloc] init];
    
    [self initTableView];
    
    [self initData];
}
- (void)initData {
    WS(weakSelf);
    [[CoreDataManager sharedInstance] selectEntitySuccess:^(NSArray *results) {
        dispatch_async(dispatch_get_main_queue(), ^{
            for (GoodModel *model in results) {
                NSLog(@"%@ - %ld",model.title, model.idd);
                if (model.idd == weakSelf.idd) {
                    weakSelf.model = model;
                    weakSelf.headView.imgView.image =IMAGE_NAME(weakSelf.model.bigIcon);
                    weakSelf.headView.titleLabel.text = weakSelf.model.title;
                    weakSelf.headView.paramsLabel.text = [NSString stringWithFormat:@"月销%ld份,  好评%ld%%",weakSelf.model.sale, weakSelf.model.percent];
                    weakSelf.headView.priceLabel.text = [NSString stringWithFormat:@"¥%ld",weakSelf.model.price];
                    
                    if (model.isCollect) { // detail_collect
                        [weakSelf.collectButton setImage:IMAGE_NAME(@"detail_collect_select") forState:UIControlStateNormal];
                    }else {
                        [weakSelf.collectButton setImage:IMAGE_NAME(@"detail_collect") forState:UIControlStateNormal];
                    }
                    [weakSelf.tableView reloadData];
                    break;
                }
            }
        });
    } fail:^(NSError *error) {
        
    }];
}

- (IBAction)action:(UIButton *)sender {
    if ([CoreStatus isNetworkEnable]) {
        
    }else {
        [MBProgressHUD showErrorNo:@"无网络" toView:ShareAppDelegate.window];
        return;
    }
    if (IS_LOGIN) {
        
    }else {
        [MBProgressHUD showErrorNo:@"请先登录" toView:ShareAppDelegate.window];
        return;
    }
    if (sender.tag == 0) { // 收藏
        WS(weakSelf);
        if (self.model.isCollect) { // 已收藏
            [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
                [MBProgressHUD showSuccess:@"操作成功" toView:ShareAppDelegate.window];
                [weakSelf.collectButton setImage:IMAGE_NAME(@"detail_collect") forState:UIControlStateNormal];
            });
        }else { // 未收藏
            [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
                [MBProgressHUD showSuccess:@"操作成功" toView:ShareAppDelegate.window];
                [weakSelf.collectButton setImage:IMAGE_NAME(@"detail_collect_select") forState:UIControlStateNormal];
            });
        }
        self.model.isCollect = !self.model.isCollect;
        [[CoreDataManager sharedInstance] updateDataWithGoodsModel:self.model];
    }
    if (sender.tag == 1) { // 评论
//        CommentViewController *vc = [[CommentViewController alloc] init];
//        vc.model = self.model;
//        [self.navigationController pushViewController:vc animated:YES];
        
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定拨打商家电话么？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString *deviceType = [UIDevice currentDevice].model;
                if ([deviceType  isEqualToString:@"iPod touch"] ||
                    [deviceType  isEqualToString:@"iPad"] ||
                    [deviceType  isEqualToString:@"iPhone Simulator"]) {
                    
                    [MBProgressHUD showErrorNo:@"您的设备不支持拨打电话" toView:ShareAppDelegate.window];
                }else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:028-2343458"] options:@{} completionHandler:^(BOOL success) {
                        
                    }];
                }
                
            });
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    if (sender.tag == 2) { // 立即购买
        OrderPopView *view = [[OrderPopView alloc] init];
        view.model = self.model;
        WS(weakSelf);
        [view setOrderCommitBlock:^{
            [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
                weakSelf.model.date = [formatter stringFromDate:[NSDate date]];
                
                OrderListViewController *vc = [[OrderListViewController alloc] init];
                vc.model = weakSelf.model;
                vc.type = 1;
                [self.navigationController pushViewController:vc animated:YES];
                
                weakSelf.model.orderType = 1;
                [[CoreDataManager sharedInstance] updateDataWithGoodsModel:weakSelf.model];
            });
            
        }];
        [view show];
    }
}

- (void)initTableView {
//    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = self.headView;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DetailTableViewCell"];

    NSLog(@"idd==%ld   commName=%@",_model.idd, _model.commName);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_model.commTitle.length && _model.commName.length) ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell" forIndexPath:indexPath];
    
    if (_model.commIcon.length) {
        cell.iconView.backgroundColor = [UIColor clearColor];
        cell.iconView.image = IMAGE_NAME(_model.commIcon);
    }else {
        cell.iconView.backgroundColor = RGBA(230, 230, 230, 1);
    }
    cell.nameLabel.text = _model.commName;
    cell.dateLabel.text = _model.commDate;
    cell.detailLabel.text = _model.commTitle;
    
    for (UIView *view in cell.starView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imgView = (UIImageView *)view;
            if (_model.percent >= 60 && _model.percent < 70) {
                if (imgView.tag < 3) {
                    imgView.image = IMAGE_NAME(@"star_full");
                }else {
                    imgView.image = IMAGE_NAME(@"star_null");
                }
            }else if (_model.percent >= 70 && _model.percent < 80) {
                if (imgView.tag < 3) {
                    imgView.image = IMAGE_NAME(@"star_full");
                }else if (imgView.tag == 3) {
                    imgView.image = IMAGE_NAME(@"star_half");
                }else {
                    imgView.image = IMAGE_NAME(@"star_null");
                }
            }else if (_model.percent >= 80 && _model.percent < 90) {
                if (imgView.tag < 4) {
                    imgView.image = IMAGE_NAME(@"star_full");
                }else {
                    imgView.image = IMAGE_NAME(@"star_null");
                }
            }else if (_model.percent >= 90 && _model.percent < 100) {
                if (imgView.tag < 4) {
                    imgView.image = IMAGE_NAME(@"star_full");
                }else if (imgView.tag == 4) {
                    imgView.image = IMAGE_NAME(@"star_half");
                }else {
                    imgView.image = IMAGE_NAME(@"star_null");
                }
            }else if (_model.percent >= 100) {
                imgView.image = IMAGE_NAME(@"star_full");
            }
        }
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95.0f;
}




- (DetailHeadView *)headView {
    if (!_headView) {
        _headView = [[DetailHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 450-350+ScreenWidth*350/375.f)];
    }return _headView;
}



@end
