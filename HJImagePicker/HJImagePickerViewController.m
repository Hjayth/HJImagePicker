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
#import "HJAlbumTableViewCell.h"
#import "HJGridViewCell.h"
#import "HJImagePickerBottomView.h"

static float kAlbumCellHeight = 70.f;
static  NSString * const kAlbumCellID = @"HJAlbumTableViewCell";
static  NSString * const kPhotoCellID = @"HJGridViewCell";
#define KScreenHeight    [[UIScreen mainScreen] bounds].size.height
#define KScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define kHJWeakSelf(weakSelf) __weak typeof(self) (weakSelf) = self


@interface HJImagePickerViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDataSource
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


/**
 selectedImageArr;
 */
@property (nonatomic , strong) NSMutableArray * selectedImageArr;


/**
 selectedAlbumInfo
 */
@property (nonatomic , strong) NSDictionary * selectedAlbumInfo;

@end

@implementation HJImagePickerViewController

#pragma mark-
#pragma mark- View Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (self.navigationController) {
//        self.navigationController.navigationBarHidden = YES;
//    }
    
}

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
    [self.navigationView.rightItem addTarget:self action:@selector(didCancel:) forControlEvents:UIControlEventTouchUpInside];
    kHJWeakSelf(weakSelf);
    [self.gridView.bottomView confirm:^{
        if ([weakSelf.delegate respondsToSelector:@selector(imagePicker:selectedImages:)]) {
            [weakSelf.delegate imagePicker:self selectedImageAssets:self.selectedImageArr];
        }
    }];
    
    [self.navigationView.centernItem addTarget:self action:@selector(navCenterItemAction:) forControlEvents:UIControlEventTouchUpInside];

}


#pragma mark-
#pragma mark- tableView dataSource && delegate
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return kAlbumCellHeight;
    
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return self.albumsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJAlbumTableViewCell * albumCell = [tableView dequeueReusableCellWithIdentifier:kAlbumCellID];
    if (!albumCell) {
        albumCell = [[HJAlbumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kAlbumCellID];
    }
    albumCell.albumInfo = self.albumsArr[indexPath.row];
    return albumCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedAlbumInfo = self.albumsArr[indexPath.row];
    [self updateNavTitle];
    [self updatePhotoData];
    kHJWeakSelf(weakSelf);
    [UIView transitionWithView:self.albumView duration:1.f options:UIViewAnimationOptionTransitionCurlUp animations:^{
        weakSelf.albumView.frame = CGRectMake(0, 64.f, KScreenWidth, KScreenWidth - 64);
     } completion:nil];
    
}



#pragma mark-
#pragma mark- collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageAssetsArrs.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJGridViewCell * photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellID forIndexPath:indexPath];
    photoCell.photo = self.imageAssetsArrs[indexPath.row];
  
    return photoCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HJGridViewCell * cell = (HJGridViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (cell.selected) {
        [self.selectedImageArr addObject:self.imageAssetsArrs[indexPath.row]];
        return;
    }
    [self.selectedImageArr removeObject:self.imageAssetsArrs[indexPath.row]];

}


#pragma mark-
#pragma mark- Event response

/**
 nav cancel btn responder

 @param sender cancel btn
 */
- (void)didCancel:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didCancelimagePicker:)]) {
        [self.delegate didCancelimagePicker:self];
    }

}

/**
 nav centerItemAction
 

 @param sender navCenterItem
 */
- (void)navCenterItemAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self pullDownViewShow:sender.selected];

}
#pragma mark-
#pragma mark- Private Methods

/**
    fetch photo data
 */
- (void)fetchPhotoData {
    self.albumsArr = [[HJPhotoFetchManager shareManager] fetchAssetCollections];
    self.imageAssetsArrs = [[HJPhotoFetchManager shareManager] fetchPhotosWithAssetCollectionFetchResult:self.albumsArr[0][@"fetchResult"]];
    [self.navigationView.centernItem setTitle:self.albumsArr[0][@"title"] forState:UIControlStateNormal];
}

/**
 update photo data
 */
- (void)updatePhotoData {
    self.imageAssetsArrs = [[HJPhotoFetchManager shareManager] fetchPhotosWithAssetCollectionFetchResult:self.selectedAlbumInfo[@"fetchResult"]];
    [self.gridView.collectionView  reloadData ];

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

- (void)updateNavTitle {
    [self.navigationView.centernItem setTitle:self.selectedAlbumInfo[@"title"] forState:UIControlStateNormal];

}
#pragma mark-
#pragma mark- Getters && Setters
- (HJGridView *)gridView {
    if (!_gridView) {
        _gridView = [HJGridView new];
        _gridView.collectionView.dataSource = self;
        _gridView.collectionView.delegate = self;
        [_gridView.collectionView registerClass:[HJGridViewCell class] forCellWithReuseIdentifier:kPhotoCellID];
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

- (NSMutableArray *)selectedImageArr {
    if (!_selectedImageArr) {
        _selectedImageArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectedImageArr;

}
#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    
}


@end
