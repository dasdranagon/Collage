//
//  CLGImagePickerController.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGImagePickerController.h"
#import "CLGImagePickerLogic.h"
#import "CLGCollageLogic.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "CLGImageCell.h"
#import "IGMedia.h"
#import "IGImage.h"

@interface CLGImagePickerController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) CLGImagePickerLogic *logic;
@end

@implementation CLGImagePickerController
@dynamic logic;

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.navigationItem.title = NSLocalizedString(@"Select photos", nil);
    self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Collage", nil);
    
    @weakify(self);
    [[RACObserve(self.logic, images) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
    RAC(self.navigationItem.rightBarButtonItem, enabled) = RACObserve(self.logic, canMakeCollage);
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.logic.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLGImageCell *cell = (CLGImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CLGImageCell class])
                                                                           forIndexPath:indexPath];
    
    IGMedia *media = self.logic.images[indexPath.row];
    [cell configWithImage:media.thumbnail];
    [cell setChecked:[self.logic.selectedIndexs containsIndex:indexPath.row]];
    return cell;
}

#pragma mark -- UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.logic toggleIndex:indexPath.row];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

@end
