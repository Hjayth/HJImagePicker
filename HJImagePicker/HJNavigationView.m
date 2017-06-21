//
//  HJNavnavigationView.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/19.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJNavigationView.h"
#import <Masonry.h>

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
- (UIButton *)centernItem {
    if (!_centernItem) {
        _centernItem = [UIButton new];
        _centernItem.imageEdgeInsets = UIEdgeInsetsMake(0, 120, 0, 0);
        _centernItem.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [_centernItem setImage:[UIImage imageNamed:@"imagePicker_nav_down"] forState:UIControlStateNormal];
        [_centernItem setImage:[UIImage imageNamed:@"imagePicker_nav_on"] forState:UIControlStateSelected];
     
        [_centernItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _centernItem;
}

#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    [self.centernItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.mas_equalTo(160.f);
        make.height.mas_equalTo(16.f);
    }];
}

@end
