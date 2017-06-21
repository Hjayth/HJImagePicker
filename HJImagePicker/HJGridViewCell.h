//
//  HJGridViewCell.h
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

/**
 @bref 显示相册图片的cell
 */

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface HJGridViewCell : UICollectionViewCell

/**
 photo
 */
@property (nonatomic , assign) UIImage * photo;

/**
 mask image
 */
@property (nonatomic , strong) UIImage * maskImage;


/**
 photo selected status image
 */
@property (nonatomic , strong) UIImage * selectedImage;


/**
 photo UNSelected status image
 */
@property (nonatomic , assign) UIImage * unselectedImage;


@property (nonatomic , strong) UIImageView * photoImageView;

/**
 photoAsset
 */
@property (nonatomic , assign) PHAsset * photoAsset;
@end
