//
//  IndexSubViewController.m
//  SYObject
//
//  Created by Jejms on 2019/5/7.
//  Copyright © 2019 Rubyuer. All rights reserved.
//

#import "IndexSubViewController.h"
#import "ISHeadCollectionReusableView.h"
#import "ISubCollectionViewCell.h"

#import "DetailsViewController.h"

@interface IndexSubViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray<GoodModel *> *datas;

@end

@implementation IndexSubViewController
- (NSMutableArray<GoodModel *> *)datas {
    if (!_datas) {
        _datas = [[NSMutableArray<GoodModel *> alloc] init];
    }return _datas;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    
    [self initCollectionView];
    
    [self initData];
 
    if (_type == 1) {
        self.navigationItem.title = @"寿司";
    }
    if (_type == 2) {
        self.navigationItem.title = @"刺身";
    }
    if (_type == 3) {
        self.navigationItem.title = @"拉面";
    }
    if (_type == 4) {
        self.navigationItem.title = @"清酒";
    }
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
                    if (model.type == weakSelf.type) {
                        [weakSelf.datas addObject:model];
                    }
                }
                [weakSelf.collectionView reloadData];
            });
        } fail:^(NSError *error) {
            
        }];
    });
}


- (void)initCollectionView {
    
    _layout.sectionInset = UIEdgeInsetsMake(0, 12, 10, 12);
    _layout.itemSize = CGSizeMake((ScreenWidth-24-10)/2.0f, 180-120+(ScreenWidth-24-10)/2.0f*120/170.0f);
    _layout.minimumLineSpacing = 10.0f;
    _layout.minimumInteritemSpacing = 10.0f;
 
    _layout.headerReferenceSize = CGSizeMake(ScreenWidth, (ScreenWidth-24)*160.0/351.0+20);
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"ISubCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ISubCollectionViewCell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"ISHeadCollectionReusableView" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ISHeadCollectionReusableView"];
    
}


#pragma mark -- CollectionViewDataSourcce And Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ISubCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ISubCollectionViewCell" forIndexPath:indexPath];

    GoodModel *model = self.datas[indexPath.row];
    cell.model = model;
    
    
    
//    cell.iconView.backgroundColor = RGBA(arc4random()%255, arc4random()%255, arc4random()%255, 1);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (_type == 1) {
        DetailsViewController *vc = [[DetailsViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.idd = indexPath.row + 1 + (_type - 1)*4;
        [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ISHeadCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ISHeadCollectionReusableView" forIndexPath:indexPath];
    
//    view.imgView.backgroundColor = RGBA(arc4random()%255, arc4random()%255, arc4random()%255, 1);
    if (_type == 1) {
        view.imgView.image = IMAGE_NAME(@"shousi_top");
    }
    if (_type == 2) {
        view.imgView.image = IMAGE_NAME(@"cishen_top");
    }
    if (_type == 3) {
        view.imgView.image = IMAGE_NAME(@"limina_top");
    }
    if (_type == 4) {
        view.imgView.image = IMAGE_NAME(@"qingjiu_top");
    }
    
    return view;
}

- (void)dealloc {
    NSLog(@"%@ - dealloc",NSStringFromClass(self.class));
}

@end
