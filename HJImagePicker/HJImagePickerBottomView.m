//
//  HJImagePickerBottomView.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 19/06/2017.
//  Copyright © 2017 Hjay. All rights reserved.
//

#import "HJImagePickerBottomView.h"
#import <Masonry.h>

@interface HJImagePickerBottomView ()


@property (nonatomic , copy) confirmBlock confirm;


@end

@implementation HJImagePickerBottomView

- (instancetype)init {
    if (self = [super init]) {
        [self configureUIAppearance];
    }
    return self;

}

#pragma mark-
#pragma mark- configureUIAppearance 
- (void)configureUIAppearance {
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.selectedCountLabel];
    [self addSubview:self.confirmBut];
}

- (void)layoutSubviews {
    [self setupConstraints];
}


- (void)confirm:(confirmBlock)confim {
    if (confim) {
       self.confirm = confim;
    }

}

#pragma mark-
#pragma mark- Event  Responder
- (void)confirmWithCompelete:(id)sender {
    if (self.confirm) {
        self.confirm();
    }

}

#pragma mark-
#pragma mark- setter && getter
- (void)setCount:(NSInteger)count {
    _count = count;
//    self.selectedCountLabel.text = [NSString stringWithFormat:@"%@%ld%@%@",NSLocalizedStringFromTable(@"已选", @"HJImagePicker",nil),_count,NSLocalizedStringFromTable(@"张", @"HJImagePicker", nil),NSLocalizedStringFromTable(@"照片", @"HJImagePicker", nil)];
    self.selectedCountLabel.text = [NSString stringWithFormat:@"已选%ld张照片",_count];
}

- (UILabel *)selectedCountLabel {
    if (!_selectedCountLabel) {
        _selectedCountLabel = [UILabel new];
        _selectedCountLabel.textColor = [UIColor whiteColor];
    }
    return _selectedCountLabel;

}


- (UIButton *)confirmBut {
    if (!_confirmBut) {
        _confirmBut = [UIButton new];
        [_confirmBut setBackgroundColor:[UIColor blueColor]];
        [_confirmBut setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmBut addTarget:self
                        action:@selector(confirmWithCompelete:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBut;

}

#pragma mark-
#pragma mark- setupSubviewConstraints
- (void)setupConstraints {
    
    [self.confirmBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_right).offset(-120.f);
        make.top.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.selectedCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(14.f);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.confirmBut.mas_left);
    }];

}


@end
