//
//  CLGImagePickerController.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGImagePickerController.h"
#import "CLGImagePickerViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "CLGImageCell.h"
#import "IGMedia.h"
#import "IGImage.h"

static NSString * const kImageCellIdentifier = @"kImageCellIdentifier";

@interface CLGImagePickerController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) CLGImagePickerViewModel *viewModel;
@end

@implementation CLGImagePickerController

- (void)viewDidLoad
{
    NSAssert(self.viewModel, @"viewModel not seted");
    [super viewDidLoad];
  
    @weakify(self);
    [_collectionView registerNib:[UINib nibWithNibName:@"CLGImageCell" bundle:nil] forCellWithReuseIdentifier:kImageCellIdentifier];
    [[RACObserve(self.viewModel, images) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLGImageCell *cell = (CLGImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kImageCellIdentifier
                                                                           forIndexPath:indexPath];
    
    IGMedia *media = self.viewModel.images[indexPath.row];
    [cell setImageUrl:media.thumbnail.url];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
