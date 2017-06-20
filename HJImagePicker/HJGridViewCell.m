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

@interface  HJGridViewCell ()

@property (nonatomic , strong) UIImageView * photoImageView;

@property (nonatomic , strong) UIImageView * maskView;

@property (nonatomic , strong) UIButton * choseImageView;

@end

@implementation HJGridViewCell
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureUIAppearance];
    }
    return self;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self configureUIAppearance];

}

#pragma mark-
#pragma mark- configureUIAppearance 
- (void)configureUIAppearance {
    self.unselectedImage = [UIImage imageNamed:@"imagePicker_checkbox"];
    self.selectedImage = [UIImage imageNamed:@"imagePicker_add"];
    [self.contentView addSubview:self.photoImageView];
  //  [self.contentView addSubview:self.maskView];
    self.isChosed = NO;
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

- (UIImageView *)maskView {
    if (!_maskView) {
        _maskView = [UIImageView new];
    }
    return _maskView;

}

-(void)setPhoto:(UIImage *)photo {
    _photo = photo;
    self.photoImageView.image = _photo;

}

-(void)setMaskImage:(UIImage *)maskImage {
    _maskImage = maskImage;
    self.maskView.image = _maskImage;

}

- (void)setPhotoAsset:(PHAsset *)photoAsset {
    _photoAsset = photoAsset;
   self.photoImageView.image =  [[HJPhotoFetchManager shareManager] fetchImageWithAsset:_photoAsset withSize:CGSizeMake(self.frame.size.width / 3.f, self.frame.size.width / 3.f)];

}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.choseImageView.selected = YES;
    
}

- (void)setIsChosed:(BOOL)isChosed {
    _isChosed = isChosed;
    self.choseImageView.selected = isChosed;
    
}
#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.choseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-14.f);
        make.top.equalTo(self.contentView.mas_top).offset(14.f);
        make.width.height.mas_equalTo(20.f);
    }];

}






@end
