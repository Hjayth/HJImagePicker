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
#import <Masonry.h>


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


@property CGRect previousPreheatRect;

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

@property (nonatomic , strong) PHCachingImageManager * imageManager;

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
//    [self setupSubviewsContraints];
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
    
    [UIView animateWithDuration:0.8 animations:^{
        weakSelf.albumView.frame = CGRectMake(0, -KScreenHeight + 64, KScreenWidth, KScreenHeight - 64);
    }];
    
}



#pragma mark-
#pragma mark- collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    PHFetchResult * result = self.selectedAlbumInfo[@"fetchResult"];
    return result.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJGridViewCell * photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellID forIndexPath:indexPath];
   // photoCell.photo = self.imageAssetsArrs[indexPath.row];
    NSInteger currentTag = photoCell.tag + 1;
    photoCell.tag = currentTag;
   // PHAsset *asset = self.assetsFetchResults[indexPath.item];
    PHAsset * asset = self.selectedAlbumInfo[@"fetchResult"][indexPath.row];
    [[[PHCachingImageManager alloc] init] requestImageForAsset:asset
                                 targetSize:CGSizeMake(self.view.frame.size.width / 3.f, self.view.frame.size.width / 3.f)
                                contentMode:PHImageContentModeAspectFill
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  
                                  // Only update the thumbnail if the cell tag hasn't changed. Otherwise, the cell has been re-used.
                                  if (photoCell.tag == currentTag) {
                                      photoCell.photo = result;
                                  }
                              }];

    return photoCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HJGridViewCell * cell = (HJGridViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.photoAsset = self.selectedAlbumInfo[@"fetchResult"][indexPath.row];
    cell.isChosed = !cell.isChosed;
    if (cell.isChose) {
       // [self.selectedImageArr addObject:self.imageAssetsArrs[indexPath.row]];
        return;
    }
   // [self.selectedImageArr removeObject:self.imageAssetsArrs[indexPath.row]];

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
    self.selectedAlbumInfo = self.albumsArr[0];
    //self.imageAssetsArrs = [[HJPhotoFetchManager shareManager] fetchPhotosWithAssetCollectionFetchResult:self.albumsArr[0][@"fetchResult"]];
    [self.navigationView.centernItem setTitle:self.albumsArr[0][@"title"] forState:UIControlStateNormal];
}

/**
 update photo data
 */
- (void)updatePhotoData {
//    self.imageAssetsArrs = [[HJPhotoFetchManager shareManager] fetchPhotosWithAssetCollectionFetchResult:self.selectedAlbumInfo[@"fetchResult"]];
    [self.gridView.collectionView  reloadData ];

}

/**
 下滑和上收view

 @param show 是否显示album view
 */
- (void)pullDownViewShow:(BOOL)show {
    kHJWeakSelf(weakSelf);
    if (show) {
       
        [UIView animateWithDuration:0.8 animations:^{
            weakSelf.albumView.frame = CGRectMake(0, -KScreenHeight + 64, KScreenWidth, KScreenHeight - 64);
        }];
        
      // [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.albumView cache:YES];
        return;
    }
   
    [UIView animateWithDuration:0.8 animations:^{
        weakSelf.albumView.frame = CGRectMake(0,  64, KScreenWidth, KScreenHeight - 64);
    }];
}

- (void)updateNavTitle {
    [self.navigationView.centernItem setTitle:self.selectedAlbumInfo[@"title"] forState:UIControlStateNormal];

}
#pragma mark-
#pragma mark- Getters && Setters
- (HJGridView *)gridView {
    if (!_gridView) {
        _gridView = [[HJGridView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60)];
        _gridView.collectionView.dataSource = self;
        _gridView.collectionView.delegate = self;
        [_gridView.collectionView registerClass:[HJGridViewCell class] forCellWithReuseIdentifier:kPhotoCellID];
    }
    return _gridView;
}

- (HJAlbumView *)albumView {
    if (!_albumView) {
        _albumView = [[HJAlbumView alloc] initWithFrame:self.gridView.frame];
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

- (PHCachingImageManager *)imageManager {
    if (!_imageManager) {
        _imageManager = [[PHCachingImageManager alloc] init];
    }
    return _imageManager;
}
#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20.f);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(44.f);
    }];
    
    
    
    [self.gridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.albumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.gridView);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    NSLog(@"ss");
}



- (void)resetCachedAssets
{
    [self.imageManager stopCachingImagesForAllAssets];
    self.previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets
{
    BOOL isViewVisible = [self isViewLoaded] && [[self view] window] != nil;
    if (!isViewVisible) { return; }
    
    // The preheat window is twice the height of the visible rect
    CGRect preheatRect = self.gridView.collectionView.bounds;
    preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));
    
    // If scrolled by a "reasonable" amount...
    CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
    if (delta > CGRectGetHeight(self.collectionView.bounds) / 3.0f) {
        
        // Compute the assets to start caching and to stop caching.
        NSMutableArray *addedIndexPaths = [NSMutableArray array];
        NSMutableArray *removedIndexPaths = [NSMutableArray array];
        
        [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            NSArray *indexPaths = [self.gridView.collectionView aapl_indexPathsForElementsInRect:removedRect];
            [removedIndexPaths addObjectsFromArray:indexPaths];
        } addedHandler:^(CGRect addedRect) {
            NSArray *indexPaths = [self.collectionView aapl_indexPathsForElementsInRect:addedRect];
            [addedIndexPaths addObjectsFromArray:indexPaths];
        }];
        
        NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
        NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
        
        [self.imageManager startCachingImagesForAssets:assetsToStartCaching
                                            targetSize:AssetGridThumbnailSize
                                           contentMode:PHImageContentModeAspectFill
                                               options:nil];
        [self.imageManager stopCachingImagesForAssets:assetsToStopCaching
                                           targetSize:AssetGridThumbnailSize
                                          contentMode:PHImageContentModeAspectFill
                                              options:nil];
        
        self.previousPreheatRect = preheatRect;
    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler
{
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    } else {
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (NSArray *)assetsAtIndexPaths:(NSArray *)indexPaths
{
    if (indexPaths.count == 0) { return nil; }
    
    NSMutableArray *assets = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath *indexPath in indexPaths) {
        PHAsset *asset = self.selectedAlbumInfo[@"fetchResult"][indexPath.item];
        [assets addObject:asset];
    }
    return assets;
}

@end
