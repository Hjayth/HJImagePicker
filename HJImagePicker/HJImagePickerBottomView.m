//
//  HJImagePickerBottomView.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 19/06/2017.
//  Copyright © 2017 Hjay. All rights reserved.
//

#import "HJImagePickerBottomView.h"

@interface HJImagePickerBottomView ()


@property (nonatomic , copy) confirmBlock confirm;
@property (nonatomic , strong) UILabel * selectedCountLabel;

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
    [self addSubview:self.selectedCountLabel];
    [self addSubview:self.confirmBut];
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
    self.selectedCountLabel.text = [NSString stringWithFormat:@"%@%ld%@%@",NSLocalizedStringFromTable(@"已选", @"HJImagePicker",nil),_count,NSLocalizedStringFromTable(@"张", @"HJImagePicker", nil),NSLocalizedStringFromTable(@"照片", @"HJImagePicker", nil)];
}

- (UILabel *)selectedCountLabel {
    if (!_selectedCountLabel) {
        _selectedCountLabel = [UILabel new];
        
    }
    return _selectedCountLabel;

}


- (UIButton *)confirmBut {
    if (!_confirmBut) {
        _confirmBut = [UIButton new];
        [_confirmBut addTarget:self
                        action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBut;

}

#pragma mark-
#pragma mark- setupSubviewConstraints
- (void)setupConstraints {



}


@end
