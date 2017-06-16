//
//  HJImagePickerViewController.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJImagePickerViewController.h"
#import "HJAlbumView.h"
#import "HJGridView.h"
#import "HJPhotoFetchManager.h"

@interface HJImagePickerViewController ()

/**
 photo album  list view
 */
@property (nonatomic  , strong) HJAlbumView * albumView;


/**
 photo list view
 */
@property (nonatomic , strong) HJGridView * gridView;


@end

@implementation HJImagePickerViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark-
#pragma mark-  delegate


#pragma mark-
#pragma mark- Event response

#pragma mark-
#pragma mark- Private Methods
- (void)pullDownViewShow:(BOOL)show {
    if (show) {
        
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.albumView cache:YES];
        return;
    }
   
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.albumView cache:YES];

}
#pragma mark-
#pragma mark- Getters && Setters
- (HJGridView *)gridView {
    if (!_gridView) {
        
    }
    return _gridView;
}

- (HJAlbumView *)albumView {
    if (!_albumView) {
        
    }
    return _albumView;

}

#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    
}


@end
