//
//  OrderListViewController.m
//  SYObject
//
//  Created by Rubyuer on 2019/5/6.
//  Copyright © 2019年 Rubyuer. All rights reserved.
//

#import "OrderListViewController.h"
#import "OListTableViewCell.h"
#import "OrderTableViewCell.h"
#import "OLHeadView.h"


@interface OrderListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) OLHeadView *headView;

@property (nonatomic, strong) UILabel *footerLabel;

@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单完成";
    
    
    [self initTableView];
    
    if (_type == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showSuccess:@"订单创建成功" toView:ShareAppDelegate.window];
        });
    }
}

- (void)initTableView {
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = self.headView;
    
    [_tableView registerNib:[UINib nibWithNibName:@"OListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"OListTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OListTableViewCell" forIndexPath:indexPath];
    
    cell.iconView.image = IMAGE_NAME(_model.icon);
    cell.titleLabel.text = _model.title;
    cell.numberLabel.text = [NSString stringWithFormat:@"x%ld",_model.number];
    
    cell.dateLabel.text = _model.date;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footerLabel;
}


- (OLHeadView *)headView {
    if (!_headView) {
        _headView = [[OLHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 235-140+140.0/375*ScreenWidth)];
        _headView.backgroundColor = [UIColor clearColor];
    }
    return _headView;
}

- (UILabel *)footerLabel {
    if (!_footerLabel) {
        _footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
        _footerLabel.textColor = RGBA(102, 102, 102, 1);
        _footerLabel.text = @"   地址：成都市成华区水碾河北三街";
        if (_model.type == 1) {
            
        }if (_model.type == 2) {
            
        }if (_model.type == 3) {
            
        }if (_model.type == 4) {
            
        }
        _footerLabel.font = PING_FANG(14.0f);
    }return _footerLabel;
}

@end
