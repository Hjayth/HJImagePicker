//
//  HJCollectionViewFlowLayout.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 20/06/2017.
//  Copyright © 2017 Hjay. All rights reserved.
//

#import "HJCollectionViewFlowLayout.h"

@implementation HJCollectionViewFlowLayout

- (void)prepareLayout {
    self.minimumLineSpacing = self.lineSpace ? :0;
    self.minimumInteritemSpacing = self.itemSpace ? : 0;
    self.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width / 3.f,[UIScreen mainScreen].bounds.size.width / 3.f );
  
}

@end
