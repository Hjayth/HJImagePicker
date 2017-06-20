//
//  HJGridView.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJGridView.h"
#import "HJCollectionViewFlowLayout.h"
#import "HJNavigationView.h"
#import "HJImagePickerBottomView.h"
#import <Masonry.h>


@implementation HJGridView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUIAppearance];
    }
    return self;

}

#pragma mark-
#pragma mark- configureUIAppearance 
- (void)configureUIAppearance {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [self addSubview:self.bottomView];
    [self setupSubviewsContraints];
}

#pragma mark-
#pragma mark- <#代理类名#> delegate


#pragma mark-
#pragma mark- Event response

#pragma mark-
#pragma mark- Private Methods

#pragma mark-
#pragma mark- Getters && Setters
- (HJNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [HJNavigationView new];
    }
    return _navigationView;

}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        HJCollectionViewFlowLayout * layout = [HJCollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 3.f,[UIScreen mainScreen].bounds.size.width / 3.f );;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;

}


- (HJImagePickerBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [HJImagePickerBottomView new];
    }
    return _bottomView;

}

#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(70.f);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    
}


@end
