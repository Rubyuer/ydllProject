//
//  CollectViewController.m
//  SYObject
//
//  Created by Rubyuer on 2019/5/6.
//  Copyright © 2019年 Rubyuer. All rights reserved.
//

#import "CollectViewController.h"

#import "CollectTableViewCell.h"
#import "DetailsViewController.h"

@interface CollectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<GoodModel *> *datas;


@end

@implementation CollectViewController
- (NSMutableArray<GoodModel *> *)datas {
    if (!_datas) {
        _datas = [[NSMutableArray<GoodModel *> alloc] init];
    }return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    
    [self initTableView];
    
    [self initData];
}

- (void)initData {
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
        [self.datas removeAllObjects];
        WS(weakSelf);
        [[CoreDataManager sharedInstance] selectEntitySuccess:^(NSArray *results) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (GoodModel *model in results) {
                    if (model.isCollect) {
                        [weakSelf.datas addObject:model];
                    }
                }
                [weakSelf.tableView reloadData];
            });
        } fail:^(NSError *error) {
            
        }];
    });
}

- (void)initTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [_tableView registerNib:[UINib nibWithNibName:@"CollectTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CollectTableViewCell"];
    
}

#pragma mark -- table View delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellReuser = @"CollectTableViewCell";
    CollectTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellReuser forIndexPath:indexPath];
    
    GoodModel *model = self.datas[indexPath.row];
    cell.iconView.image = IMAGE_NAME(model.icon);
    cell.titleLabel.text = model.title;
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%ld",model.price];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([CoreStatus isNetworkEnable]) {
        
    }else {
        [MBProgressHUD showErrorNo:@"无网络" toView:ShareAppDelegate.window];
        return;
    }
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
        
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = weakSelf.datas[indexPath.row].idd;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    });
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}


@end
