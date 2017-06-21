//
//  HJAlbumTableViewCell.h
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//
/**
 @bref 显示每个相册的内容cell
 */
#import <UIKit/UIKit.h>


@interface HJAlbumTableViewCell : UITableViewCell


/**
 @bref album coverImage
 */
@property (nonatomic , assign) UIImage * albumCoverImage;


/**
 album title
 */
@property (nonatomic , strong) NSString * albumTitle;


/**
 album photo count 
 */
@property (nonatomic , assign) NSInteger albumImageCount;


@property (nonatomic , strong) NSDictionary * albumInfo;

/**
 *@bref album coverImage
 */
@property (nonatomic , strong) UIImageView * coverImageView;

@end
