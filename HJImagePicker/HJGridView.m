//
//  HJGridView.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJGridView.h"
#import "HJCollectionViewLayout.h"
#import "HJNavigationView.h"

@implementation HJGridView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUIAppearance];
    }
    return self;

}

#pragma mark-
#pragma mark- configureUIAppearance 
- (void)configureUIAppearance {
    [self addSubview:self.collectionView];

}

#pragma mark-
#pragma mark- <#代理类名#> delegate


#pragma mark-
#pragma mark- Event response

#pragma mark-
#pragma mark- Private Methods

#pragma mark-
#pragma mark- Getters && Setters
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        HJCollectionViewLayout * layout = [HJCollectionViewLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    }
    return _collectionView;

}


#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    
}


@end
