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


#pragma mark-
#pragma mark- Helper methods
/**
 get the indexPaths in the section
 */
@implementation NSIndexSet (Convenience)
- (NSArray *)aapl_indexPathsFromIndexesWithSection:(NSUInteger)section {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        [indexPaths addObject:[NSIndexPath indexPathForItem:idx inSection:section]];
    }];
    return indexPaths;
}
@end

/**
 get the indexpath in the rect
 */
@implementation UICollectionView (Convenience)
- (NSArray *)aapl_indexPathsForElementsInRect:(CGRect)rect {
    NSArray *allLayoutAttributes = [self.collectionViewLayout layoutAttributesForElementsInRect:rect];
    if (allLayoutAttributes.count == 0) { return nil; }
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:allLayoutAttributes.count];
    for (UICollectionViewLayoutAttributes *layoutAttributes in allLayoutAttributes) {
        NSIndexPath *indexPath = layoutAttributes.indexPath;
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}
@end

@interface HJImagePickerViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDataSource
>

@property CGRect previousPreheatRect;

//photo album  list view
@property (nonatomic  , strong) HJAlbumView * albumView;

// photo list view
@property (nonatomic , strong) HJGridView * gridView;

// navigationView
@property (nonatomic , strong) HJNavigationView * navigationView;

//  album array
@property (nonatomic , strong) NSArray * albumsArr;

// the fetchResult
@property (nonatomic , strong) PHFetchResult * fetchResult;

// selectedAssetsArr
@property (nonatomic , strong) NSMutableArray * selectedAssetsArr;

// selectedImageArr;
@property (nonatomic , strong) NSMutableArray * selectedImageArr;

// selectedAlbumInfo
@property (nonatomic , strong) NSDictionary * selectedAlbumInfo;

//phcancheImageManager request for the image (Photo.kit)
@property (nonatomic , strong) PHCachingImageManager * imageManager;

@end

@implementation HJImagePickerViewController

#pragma mark-
#pragma mark- View Life Cycle
- (HJImagePickerViewController *)initWithImagePickerType:(HJImagePickerType)imagePickerType {
    if (self = [super init]) {
        self.imagePickerType = imagePickerType;
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        self.imagePickerType = HJImagePickerTypeMultiSelection;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:YES];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self fetchPhotoData];
    [self configureUIAppearance];
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:NO];
    }

}
#pragma mark-
#pragma mark- configureUIAppearance 
- (void)configureUIAppearance {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.gridView];
    [self.view addSubview:self.navigationView];
    self.navigationView.centernItem.selected = NO;
    [self.navigationView.rightItem addTarget:self action:@selector(didCancel:) forControlEvents:UIControlEventTouchUpInside];
    kHJWeakSelf(weakSelf);
    [self.gridView.bottomView confirm:^{
        
        [weakSelf backToTheLastView];
        
        if ([weakSelf.delegate respondsToSelector:@selector(imagePicker:didFinishedSelectedImageAssets:)]) {
            [weakSelf.delegate imagePicker:self didFinishedSelectedImageAssets:self.selectedAssetsArr];
        }
        
        if ([weakSelf.delegate respondsToSelector:@selector(imagePicker:didFinishedSelectedImages:) ]) {
            [weakSelf.delegate imagePicker:self didFinishedSelectedImages:self.selectedImageArr];
        }
    }];
    [self.navigationView.centernItem addTarget:self action:@selector(navCenterItemAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setupSubviewsContraints];
    [self resetCachedAssets];
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
    NSInteger currentTag = albumCell.tag + 1;
    albumCell.tag = currentTag;
    [self.imageManager requestImageForAsset:self.albumsArr[indexPath.row][@"fetchResult"][0] targetSize:CGSizeMake(44, 44.f) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (albumCell.tag == currentTag) {
            [albumCell.coverImageView setImage:result];
        }
    }];
    albumCell.albumInfo = self.albumsArr[indexPath.row];
    return albumCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedAlbumInfo = self.albumsArr[indexPath.row];
    self.fetchResult = self.selectedAlbumInfo[@"fetchResult"];
    [self updateNavTitle];
    [self navCenterItemAction:self.navigationView.centernItem];
    [self updatePhotoData];
    kHJWeakSelf(weakSelf);
    
    [UIView animateWithDuration:0.8 animations:^{
        weakSelf.albumView.frame = CGRectMake(0, -KScreenHeight + 64, KScreenWidth, KScreenHeight - 64);
    }];
    
}

#pragma mark-
#pragma mark- collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetchResult.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJGridViewCell * photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoCellID forIndexPath:indexPath];
    photoCell.imagePickerType = self.imagePickerType;
    NSInteger currentTag = photoCell.tag + 1;
    photoCell.tag = currentTag;
    PHAsset * asset = self.fetchResult[indexPath.row];
    photoCell.photoAsset = asset;
    [self.imageManager requestImageForAsset:asset
                                 targetSize:CGSizeMake(123.f,123.f)
                                contentMode:PHImageContentModeAspectFill
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  
                                  // Only update the thumbnail if the cell tag hasn't changed. Otherwise, the cell has been re-used.
                                  if (photoCell.tag == currentTag) {
                                      [photoCell.photoImageView setImage:result];
                                  }
    
                              }];
    
    if ([self.selectedAssetsArr containsObject:photoCell.photoAsset]) {
        photoCell.selected = YES;
        [self.gridView.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }else {
        photoCell.selected = NO;
    }
    
    return photoCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HJGridViewCell * cell = (HJGridViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.selectedAssetsArr addObject:cell.photoAsset];
    [self.selectedImageArr addObject:cell.photoImageView.image];
    switch (self.imagePickerType) {
        case HJImagePickerTpyeSingleSelection:
        {
                if ([self.delegate respondsToSelector:@selector(imagePicker:didFinishedSelectedImageAssets:)]) {
                    [self.delegate imagePicker:self didFinishedSelectedImageAssets:self.selectedAssetsArr];
                }
                
                if ([self.delegate respondsToSelector:@selector(imagePicker:didFinishedSelectedImages:) ]) {
                    [self.delegate imagePicker:self didFinishedSelectedImages:self.selectedImageArr];
                }
            [self backToTheLastView];
            
        }
            break;
            
       case  HJImagePickerTypeMultiSelection:
        {
            
        }
            break;
    }
    
    self.gridView.bottomView.count = self.selectedImageArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
     HJGridViewCell * cell = (HJGridViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.selectedAssetsArr removeObject:cell.photoAsset];
    [self.selectedImageArr removeObject:cell.photoImageView.image];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.gridView.collectionView) {
        [self updateCachedAssets];
    }

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
        [self backToTheLastView];
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
    self.fetchResult = self.selectedAlbumInfo[@"fetchResult"];
    [self.navigationView.centernItem setTitle:self.albumsArr[0][@"title"] forState:UIControlStateNormal];
    [self updateCachedAssets];
}

/**
 update photo data
 */
- (void)updatePhotoData {
    
    [self resetCachedAssets];
    self.imageManager = nil;
    [self.gridView.collectionView  reloadData ];
    [self updateCachedAssets];
}

/**
 下滑和上收view

 @param show 是否显示album view
 */
- (void)pullDownViewShow:(BOOL)show {
    kHJWeakSelf(weakSelf);
    if (!show) {
       
        [UIView animateWithDuration:0.8 animations:^{
            weakSelf.albumView.frame = CGRectMake(0, -KScreenHeight + 64, KScreenWidth, KScreenHeight - 64);
        }];
        [self.albumView removeFromSuperview];
        return;
    }
    
    [self.view insertSubview:self.albumView belowSubview:self.navigationView];
    [UIView animateWithDuration:0.8 animations:^{
        weakSelf.albumView.frame = CGRectMake(0,  64, KScreenWidth, KScreenHeight - 64);
    }];
}


/**
 updateNavTitle
 */
- (void)updateNavTitle {
    [self.navigationView.centernItem setTitle:self.selectedAlbumInfo[@"title"] forState:UIControlStateNormal];

}

- (void)backToTheLastView {
    if ([self.navigationController.viewControllers containsObject:self]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}



/**
 reset the asset cache
 */
- (void)resetCachedAssets
{
    [self.imageManager stopCachingImagesForAllAssets];
    self.previousPreheatRect = CGRectZero;
}


/**
 updateCacheAsset
 */
- (void)updateCachedAssets
{
    BOOL isViewVisible = [self isViewLoaded] && [[self view] window] != nil;
    if (!isViewVisible) { return; }
    
    // The preheat window is twice the height of the visible rect
    CGRect preheatRect = self.gridView.collectionView.bounds;
    preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));
    
    // If scrolled by a "reasonable" amount...
    CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
    if (delta > CGRectGetHeight(self.gridView.collectionView.bounds) / 3.0f) {
        
        // Compute the assets to start caching and to stop caching.
        NSMutableArray *addedIndexPaths = [NSMutableArray array];
        NSMutableArray *removedIndexPaths = [NSMutableArray array];
        
        [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            NSArray *indexPaths = [self.gridView.collectionView aapl_indexPathsForElementsInRect:removedRect];
            [removedIndexPaths addObjectsFromArray:indexPaths];
        } addedHandler:^(CGRect addedRect) {
            NSArray *indexPaths = [self.gridView.collectionView aapl_indexPathsForElementsInRect:addedRect];
            [addedIndexPaths addObjectsFromArray:indexPaths];
        }];
        
        NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
        NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
        PHImageRequestOptions * option = [[PHImageRequestOptions alloc] init];
        option.networkAccessAllowed = YES;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        [self.imageManager startCachingImagesForAssets:assetsToStartCaching
                                            targetSize:self.photoSize
                                           contentMode:PHImageContentModeAspectFill
                                               options:option];
        [self.imageManager stopCachingImagesForAssets:assetsToStopCaching
                                           targetSize:self.photoSize
                                          contentMode:PHImageContentModeAspectFill
                                              options:option];
        
        self.previousPreheatRect = preheatRect;
    }
}


/**
 compute difference between the two rect and get the which rect should be added and get which rect should be remove
 
 @param oldRect oldRect
 @param newRect newRect
 @param removedHandler remove handle
 @param addedHandler add handle
 */
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


/**
 assets at the indexPaths

 @param indexPaths indexpaths
 @return the assets at the indexPaths
 */
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


#pragma mark-
#pragma mark- Getters && Setters
- (HJGridView *)gridView {
    if (!_gridView) {
        _gridView = [[HJGridView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
        
        _gridView.collectionView.dataSource = self;
        _gridView.collectionView.delegate = self;
        _gridView.collectionView.allowsMultipleSelection = self.imagePickerType;
        _gridView.isAllowMulti= self.imagePickerType;
        [_gridView.collectionView registerClass:[HJGridViewCell class] forCellWithReuseIdentifier:kPhotoCellID];
        
    }
    return _gridView;
}

- (HJAlbumView *)albumView {
    if (!_albumView) {
        _albumView = [[HJAlbumView alloc] initWithFrame:CGRectMake(0, -KScreenHeight +64, KScreenWidth, KScreenHeight - 64)];
        _albumView.tableView.delegate = self;
        _albumView.tableView.dataSource = self;
    }
    return _albumView;

}

- (HJNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [HJNavigationView new];
    }
    return _navigationView;

}


- (NSArray *)albumsArr {
    if (!_albumsArr) {
        _albumsArr = [NSArray array];
    }
    return _albumsArr;

}

- (NSMutableArray *)selectedAssetsArr {
    if (!_selectedAssetsArr) {
        _selectedAssetsArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _selectedAssetsArr;
}

- (NSMutableArray *)selectedImageArr {
    if (!_selectedImageArr) {
        _selectedImageArr = [[NSMutableArray alloc] init];
    }
    return _selectedImageArr;

}

- (PHCachingImageManager *)imageManager {
    if (!_imageManager) {
        _imageManager = [[PHCachingImageManager alloc] init];
    }
    return _imageManager;
}

- (NSArray *)mediaType {
    if (!_mediaType) {
        _mediaType = @[@(PHAssetMediaTypeImage)];
    }
    return _mediaType;
}

#pragma mark-
#pragma mark- SetupConstraints
- (void)setupSubviewsContraints {
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0.f);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(64.f);
    }];
    
    [self.gridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
}




@end
