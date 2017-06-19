//
//  HJCollectionViewLayout.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/19.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJCollectionViewLayout.h"

@implementation HJCollectionViewLayout


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewLayoutAttributes * layout = [[UICollectionViewLayoutAttributes alloc] init];
    layout.size = CGSizeMake(100, 100);
    
    return layout;
}


@end
