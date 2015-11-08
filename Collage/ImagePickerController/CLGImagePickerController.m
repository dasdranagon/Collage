//
//  CLGImagePickerController.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGImagePickerController.h"
#import "CLGImagePickerViewModel.h"
#import "CLGCollageViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "CLGImageCell.h"
#import "IGMedia.h"
#import "IGImage.h"

static NSString * const kGoToCollageScreenSegueIdentifier = @"goToCollageScreen";

@interface CLGImagePickerController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) CLGImagePickerViewModel *viewModel;
@end

@implementation CLGImagePickerController
@dynamic viewModel;

- (void)viewDidLoad
{
    NSAssert(self.viewModel, @"viewModel not seted");
    [super viewDidLoad];
  
    self.navigationItem.title = NSLocalizedString(@"Select photos", nil);
    self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Collage", nil);
    
    @weakify(self);
    [[RACObserve(self.viewModel, images) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
    
    RAC(self.navigationItem.rightBarButtonItem, enabled) = RACObserve(self.viewModel, canMakeCollage);
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLGImageCell *cell = (CLGImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CLGImageCell class])
                                                                           forIndexPath:indexPath];
    
    IGMedia *media = self.viewModel.images[indexPath.row];
    [cell configWithImage:media.thumbnail];
    [cell setChecked:[self.viewModel.selectedIndexs containsIndex:indexPath.row]];
    return cell;
}

#pragma mark -- UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 100);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel toggleIndex:indexPath.row];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:kGoToCollageScreenSegueIdentifier]){
        NSArray *images = [self.viewModel.images objectsAtIndexes:self.viewModel.selectedIndexs];
        CLGCollageViewModel *collageViewModel = [[CLGCollageViewModel alloc] initWidthImages:images];
        ((CLGViewController *)[segue destinationViewController]).viewModel = collageViewModel;
    }
}

@end
