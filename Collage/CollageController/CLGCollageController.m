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
static NSString * const kPrinterUnavailableErrorMessage = @"Print Unavailable!";

@interface CLGCollageController ()<UICollectionViewDataSource, UIPrintInteractionControllerDelegate>
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
    CLGCollageCell *cell = (CLGCollageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCollageCellIdentifier
                                                                                   forIndexPath:indexPath];
    
    IGMedia *media = self.viewModel.images[indexPath.row];
    [cell setImageUrl:media.lowImage.url];
    return cell;
}

@end
