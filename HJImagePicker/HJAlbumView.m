//
//  HJAlbumView.m
//  HJImagePickerDemo
//
//  Created by 谢豪杰 on 2017/6/15.
//  Copyright © 2017年 Hjay. All rights reserved.
//

#import "HJAlbumView.h"
#import "HJAlbumTableViewCell.h"
#import <Masonry.h>

@interface HJAlbumView ()



@end


@implementation HJAlbumView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configureUIAppearance];
    }
    return self;

}

#pragma mark-
#pragma mark- configureUIAppearance
- (void)configureUIAppearance {
    [self addSubview:self.tableView];
    [self setupSubviewsConstraints];
}

#pragma mark-
#pragma mark- setter && getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[HJAlbumTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HJAlbumTableViewCell class])];
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
    
}

#pragma mark-
#pragma mark- setupSubviewsConstraints
- (void)setupSubviewsConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}


@end
