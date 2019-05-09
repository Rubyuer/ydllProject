//
//  OrderViewController.m
//  SYObject
//
//  Created by Jejms on 2019/5/6.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"

#import "OrderListViewController.h"

@interface OrderViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<GoodModel *> *datas;

@end

@implementation OrderViewController
- (NSMutableArray<GoodModel *> *)datas {
    if (!_datas) {
        _datas = [[NSMutableArray<GoodModel *> alloc] init];
    }return _datas;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    
    
    [self initTableView];
    
    
}

- (void)initData {
    [self.datas removeAllObjects];
    WS(weakSelf);
    [[CoreDataManager sharedInstance] selectEntitySuccess:^(NSArray *results) {
        dispatch_async(dispatch_get_main_queue(), ^{
            for (GoodModel *model in results) {
                if (model.orderType == 1 || model.orderType == 2) {
                    [weakSelf.datas addObject:model];
                }
            }
            [weakSelf.tableView reloadData];
        });
    } fail:^(NSError *error) {
        
    }];
}

- (void)initTableView {
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerNib:[UINib nibWithNibName:@"OrderTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OrderTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell" forIndexPath:indexPath];
    
    cell.model = self.datas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   GoodModel *model = self.datas[indexPath.row];
    if (model.orderType == 1) {
        [MBProgressHUD showHUDAddedTo:ShareAppDelegate.window animated:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:ShareAppDelegate.window animated:YES];
            OrderListViewController *vc = [[OrderListViewController alloc] initWithNibName:@"OrderListViewController" bundle:[NSBundle mainBundle]];
            vc.hidesBottomBarWhenPushed = YES;
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        });
    }else if (model.orderType == 2) {
        [MBProgressHUD showErrorNo:@"订单已完成" toView:ShareAppDelegate.window];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0f;
}


@end
