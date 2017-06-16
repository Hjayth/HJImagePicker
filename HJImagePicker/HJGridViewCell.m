//
//  HJGridViewCell.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJGridViewCell.h"

@interface  HJGridViewCell ()

@property (nonatomic , strong) UIImageView * photoImageView;

@property (nonatomic , strong) UIImageView * maskView;

@property (nonatomic , strong) UIImageView * choseImageView;

@end

@implementation HJGridViewCell
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureUIAppearance];
    }
    return self;

}

#pragma mark-
#pragma mark- configureUIAppearance 
- (void)configureUIAppearance {
    [self.contentView addSubview:self.photoImageView];
    [self.contentView addSubview:self.maskView];
    [self.contentView addSubview:self.choseImageView];
    

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

- (UIImageView *)choseImageView {
    if (!_choseImageView) {
        _choseImageView = [UIImageView new];
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

#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.maskView.hidden = NO;
        self.choseImageView.image = self.selectedImage;
        return;
    }
    
    self.maskView.hidden = YES;
    self.choseImageView.image = self.unselectedImage;
    
}


@end
