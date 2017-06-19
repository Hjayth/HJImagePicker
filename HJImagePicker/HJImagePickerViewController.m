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
#import "HJNavigationView.h"

@interface HJImagePickerViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>



/**
 photo album  list view
 */
@property (nonatomic  , strong) HJAlbumView * albumView;


/**
 photo list view
 */
@property (nonatomic , strong) HJGridView * gridView;


/**
 navigationView
 */
@property (nonatomic , strong) HJNavigationView * navigationView;


/**
  album array
 */
@property (nonatomic , strong) NSArray * albumsArr;


/**
 image assets array
 */
@property (nonatomic , strong) NSArray * imageAssetsArrs;



@end

@implementation HJImagePickerViewController

#pragma mark-
#pragma mark- View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self fetchPhotoData];
    [self configureUIAppearance];
    
}

#pragma mark-
#pragma mark- configureUIAppearance 
- (void)configureUIAppearance {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.gridView];
    [self.view addSubview:self.albumView];
    [self.view addSubview:self.navigationView];

}


#pragma mark-
#pragma mark- tableView dataSource && delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {


    return 0;
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     
    
}



#pragma mark-


#pragma mark-
#pragma mark- Event response

#pragma mark-
#pragma mark- Private Methods

/**
    获取图片数据
 */
- (void)fetchPhotoData {
    self.albumsArr = [[HJPhotoFetchManager shareManager] fetchAssetCollections];

}


/**
 下滑和上收view

 @param show 是否显示album view
 */
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
        _gridView = [HJGridView new];
    }
    return _gridView;
}

- (HJAlbumView *)albumView {
    if (!_albumView) {
        _albumView = [HJAlbumView new];
        _albumView.tableView.delegate = self;
        _albumView.tableView.dataSource = self;
        
    }
    return _albumView;

}

- (NSArray *)albumsArr {
    if (!_albumsArr) {
        _albumsArr = [NSArray array];
    }
    return _albumsArr;

}

- (NSArray *)imageAssetsArrs {
    if (!_imageAssetsArrs) {
        _imageAssetsArrs = [NSArray array];
    }
    return _imageAssetsArrs;

}
#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    
}


@end
