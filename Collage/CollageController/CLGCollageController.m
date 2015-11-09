//
//  CLGCollageController.m
//  Collage
//
//  Created by Denis Skokov on 06.08.14.
//  Copyright (c) 2014 Denis Skokov. All rights reserved.
//

#import "CLGCollageController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "CLGCollageLogic.h"
#import "CLGCollageCell.h"
#import "IGMedia.h"
#import "IGImage.h"

#import "CLGSimpleTileLayout.h"
#import "CLGCircleLayout.h"

static NSString * const kPrinterUnavailableErrorMessage = @"Print Unavailable!";

static CGFloat const kFlowLayoutPhotoSide = 100;

@interface CLGCollageController ()<UICollectionViewDataSource>
@property (nonatomic, strong) CLGCollageLogic *logic;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *layouts;
@property (nonatomic) NSInteger currentLayoutIndex;
@end

@implementation CLGCollageController
@dynamic logic;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Collage", nil);
    self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Print", nil);
    
    RAC(self.logic, alert) = [RACObserve(self.printManager, lastMessage) skip:1];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(kFlowLayoutPhotoSide, kFlowLayoutPhotoSide);
    
    self.collectionView.collectionViewLayout =  flowLayout;
    
    self.layouts = @[flowLayout, [CLGCircleLayout new], [CLGSimpleTileLayout new]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self changeLayout:nil];
}

- (IBAction)changeLayout:(id)sender
{
 
    self.currentLayoutIndex = (self.currentLayoutIndex +1) % self.layouts.count;
    [self.collectionView setCollectionViewLayout:self.layouts[self.currentLayoutIndex]
                                        animated:YES];
}

- (IBAction)print:(id)sender
{
    [self.printManager printImage:[self screenshot]];
}

- (UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.collectionView.frame.size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[self.collectionView layer] renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark -- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.logic.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLGCollageCell *cell = (CLGCollageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CLGCollageCell class])
                                                                                   forIndexPath:indexPath];
    IGMedia *media = self.logic.images[indexPath.row];
    [cell configureWithCLGImage:media.lowImage];
    return cell;
}

@end
