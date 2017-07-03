//
//  HJGridViewCell.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJGridViewCell.h"
#import <Masonry.h>
#import "HJPhotoFetchManager.h"
#import "HJImagePickerViewController.h"

@interface  HJGridViewCell ()

/**
 maskView
 */
@property (nonatomic , strong) UIView * maskView;

/**
 selectedStatus imageView
 */
@property (nonatomic , strong) UIButton * choseImageView;

@end

@implementation HJGridViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUIAppearance];
    }
    return self;

}

#pragma mark-
#pragma mark- configureUIAppearance 
- (void)configureUIAppearance {
    self.unselectedImage = [UIImage imageNamed:@"imagePicker_checkbox"];
    self.selectedImage = [UIImage imageNamed:@"imagePicker_checkboxCur"];
    [self.contentView addSubview:self.photoImageView];
    [self.contentView addSubview:self.maskView];
    [self.contentView addSubview:self.choseImageView];
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
- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [UIImageView new];
        _photoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _photoImageView.clipsToBounds = YES;
        _photoImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _photoImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _photoImageView;

}



- (UIButton *)choseImageView {
    if (!_choseImageView) {
        _choseImageView = [UIButton new];
        _choseImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_choseImageView setImage:self.unselectedImage forState:UIControlStateNormal];
        [_choseImageView setImage:self.selectedImage forState:UIControlStateSelected];
    }
    return _choseImageView;

}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [UIView new];
        _maskView.hidden = YES;
    }
    return _maskView;

}

- (void)setImagePickerType:(BOOL)imagePickerType {
    if (!imagePickerType) {
        self.maskView.hidden = YES;
        self.choseImageView.hidden = YES;
    }
}

-(void)setMaskImage:(UIImage *)maskImage {
    _maskImage = maskImage;
  //  self.maskView.image = _maskImage;

}



- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.choseImageView.selected = selected;
    self.maskView.hidden = !selected;
}


#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.choseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-14.f);
        make.top.equalTo(self.contentView.mas_top).offset(14.f);
        make.width.height.mas_equalTo(20.f);
    }];

}






@end
