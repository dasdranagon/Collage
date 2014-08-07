//
//  CLGCollageController.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGCollageController.h"
#import "CLGCollageViewModel.h"
#import "CLGCollageCell.h"
#import "IGMedia.h"
#import "IGImage.h"

#import "CLGSimpleTileLayout.h"

static NSString * const kCollageCellIdentifier = @"kCollageCellIdentifier";

@interface CLGCollageController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) CLGCollageViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation CLGCollageController

- (void)viewDidLoad
{
     NSAssert(self.viewModel, @"viewModel not seted");
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CLGCollageCell" bundle:nil] forCellWithReuseIdentifier:kCollageCellIdentifier];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 100);
    self.collectionView.collectionViewLayout =  flowLayout;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.collectionView setCollectionViewLayout:[[CLGSimpleTileLayout alloc] init]
                                        animated:YES];
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLGCollageCell *cell = (CLGCollageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCollageCellIdentifier
                                                                                   forIndexPath:indexPath];
    
    IGMedia *media = self.viewModel.images[indexPath.row];
    [cell setImageUrl:media.thumbnail.url];
    return cell;
}

#pragma mark -- UICollectionViewDelegate

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(100, 100);
//}

@end
