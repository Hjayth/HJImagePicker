//
//  HJNavnavigationView.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/19.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJNavigationView.h"
#import <Masonry.h>

@interface HJNavigationView ()

@property (nonatomic , strong) UIView * navView;

@end

@implementation HJNavigationView

- (instancetype)init {
    if (self = [super init]) {
        [self configureUIAppearance];
    }
    return self;
}


#pragma mark-
#pragma mark- configureUIAppearance 
- (void)configureUIAppearance {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.navView];
    [self addSubview:self.leftNavItem];
    [self addSubview:self.rightItem];
    [self addSubview:self.centernItem];

}

- (void)layoutSubviews {
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
- (UIView *)navView {
    if (!_navView) {
        _navView = [UIView new];
        _navView.backgroundColor = [UIColor clearColor];
    }
    return _navView;

}

- (UIButton *)centernItem {
    if (!_centernItem) {
        _centernItem = [UIButton new];
        _centernItem.imageEdgeInsets = UIEdgeInsetsMake(0, 100, 0, 0);
        _centernItem.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
        [_centernItem setImage:[UIImage imageNamed:@"imagePicker_nav_down"] forState:UIControlStateNormal];
        [_centernItem setImage:[UIImage imageNamed:@"imagePicker_nav_on"] forState:UIControlStateSelected];
     
        [_centernItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _centernItem;
}

- (UIButton *)rightItem {
    if (!_rightItem) {
        _rightItem = [UIButton new];
        [_rightItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightItem setTitle:@"取消" forState:UIControlStateNormal];
    }
    return _rightItem;

}

- (UIButton *)leftNavItem {
    if (!_leftNavItem) {
        _leftNavItem = [UIButton new];
        [_leftNavItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftNavItem setTitle:@"取消" forState:UIControlStateNormal];
    }
    return _leftNavItem;

}
#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
 
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20.f);
        make.left.right.bottom.equalTo(self);
    }];
    
    [self.centernItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.navView.mas_centerX);
        make.centerY.equalTo(self.navView.mas_centerY);
        make.width.mas_equalTo(160.f);
        make.height.mas_equalTo(16.f);
    }];
    
    [self.leftNavItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centernItem.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15.f);
        make.height.mas_equalTo(16.f);
        make.width.mas_equalTo(40.f);
    }];
    
    [self.rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centernItem.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15.f);
        make.height.mas_equalTo(16.f);
        make.width.mas_equalTo(40.f);
    }];
    
}

@end
