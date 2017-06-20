//
//  HJCollectionViewFlowLayout.h
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 20/06/2017.
//  Copyright © 2017 Hjay. All rights reserved.
//
/**
 collectionViewFlowLayout
 */
#import <UIKit/UIKit.h>


@interface HJCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic) CGSize itemLayoutSize;

@property (nonatomic) CGFloat lineSpace;

@property (nonatomic) CGFloat itemSpace;

@end
