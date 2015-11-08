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
#import "CLGCircleLayout.h"

static NSString * const kPrinterUnavailableErrorMessage = @"Print Unavailable!";

static CGFloat const kFlowLayoutPhotoSide = 100;

@interface CLGCollageController ()<UICollectionViewDataSource, UIPrintInteractionControllerDelegate>
@property (nonatomic, strong) CLGCollageViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *layouts;
@property (nonatomic) NSInteger currentLayoutIndex;
@end

@implementation CLGCollageController
@dynamic viewModel;

- (void)viewDidLoad
{
     NSAssert(self.viewModel, @"viewModel not seted");
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"Collage", nil);
    self.navigationItem.rightBarButtonItem.title = NSLocalizedString(@"Print", nil);
    
    
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
 
    _currentLayoutIndex = (_currentLayoutIndex +1) % self.layouts.count;
    [self.collectionView setCollectionViewLayout:self.layouts[_currentLayoutIndex]
                                        animated:YES];
}

- (IBAction)print:(id)sender
{
    UIPrintInteractionController *print = [UIPrintInteractionController sharedPrintController];
    if(!print){
        self.viewModel.alert = kPrinterUnavailableErrorMessage;
        return;
    }
    
    print.delegate = self;
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputPhoto;
    printInfo.jobName = @"Collage";
    
    print.printInfo = printInfo;
    print.printingItem = UIImageJPEGRepresentation([self screenshot], 1.f);;

    [print presentAnimated:YES
         completionHandler:^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError *error) {
        if(!completed && error){
            self.viewModel.alert = kPrinterUnavailableErrorMessage;
        }
    }];
}

- (UIPrintPaper *)printInteractionController:(UIPrintInteractionController *)printInteractionController
                                 choosePaper:(NSArray *)paperList {
    
    CGSize pageSize = [UIScreen mainScreen].bounds.size;
    return [UIPrintPaper bestPaperForPageSize:pageSize withPapersFromArray:paperList];
    
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
    return self.viewModel.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLGCollageCell *cell = (CLGCollageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CLGCollageCell class])
                                                                                   forIndexPath:indexPath];
    IGMedia *media = self.viewModel.images[indexPath.row];
    [cell configureWithCLGImage:media.lowImage];
    return cell;
}

@end
