//
//  HJAlbumTableViewCell.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJAlbumTableViewCell.h"
#import <Photos/Photos.h>

static CGSize const kAlbumCoverImageSize = {44.f, 44.f};

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
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.countLabel];
    [self setupSubviewsContraints];
}


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
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _coverImageView;

}


- (void)setAlbumCoverImage:(UIImage *)albumCoverImage {
    _albumCoverImage = albumCoverImage;
    self.coverImageView.image = _albumCoverImage;
    

}

- (void)setAlbumTitle:(NSString *)albumTitle {
    _albumTitle = albumTitle;
    self.titleLabel.text = _albumTitle;

}

- (void)setAlbumImageCount:(NSInteger)albumImageCount {
    _albumImageCount = albumImageCount;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",_albumImageCount];
}


- (void)setAlbumInfo:(NSDictionary *)albumInfo {
    _albumInfo = albumInfo;
    
    __weak typeof(self)kWeakSelf = self;
    self.titleLabel.text = _albumInfo[@"title"];
    PHFetchResult * result = _albumInfo[@"fetchResult"];
    PHAsset * asset =(PHAsset *) [result objectAtIndex:0];
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:kAlbumCoverImageSize contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        kWeakSelf.coverImageView.image = result;
    }];
}
#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    
}


@end
