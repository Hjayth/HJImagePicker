//
//  HJAlbumTableViewCell.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJAlbumTableViewCell.h"

@interface HJAlbumTableViewCell ()

/**
 @bref album title
 */
@property (nonatomic , strong) UILabel * titleLabel;


/**
 *@bref album photo count
 */
@property (nonatomic , strong) UILabel * countLabel;


/**
 *@bref album coverImage
 */
@property (nonatomic , strong) UIImageView * coverImageView;
@end

@implementation HJAlbumTableViewCell

#pragma mark-
#pragma mark- View Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configureUIAppearance];
    }
    return self;
}


#pragma mark-
#pragma mark- configureUIAppearance 
- (void)configureUIAppearance {


}

#pragma mark-
#pragma mark- <#代理类名#> delegate


#pragma mark-
#pragma mark- Event response

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark-
#pragma mark- Private Methods

#pragma mark-
#pragma mark- Getters && Setters
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;

}


- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UILabel new];
    }
    return _countLabel;

}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [UIImageView new];
    }
    return _coverImageView;

}

- (void)setCoverImage:(UIImage *)coverImage {
    _coverImage = coverImage;
    self.coverImageView.image = _coverImage;

}


#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    
}


@end
