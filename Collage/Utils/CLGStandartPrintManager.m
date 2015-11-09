//
//  CLGStandartPrintManager.m
//  Collage
//
//  Created by Denis Skokov on 09.11.15.
//  Copyright © 2015 Denis Skokov. All rights reserved.
//

#import "CLGStandartPrintManager.h"

static NSString * const kPrinterUnavailableErrorMessage = @"Print Unavailable!";

@interface CLGStandartPrintManager()  <UIPrintInteractionControllerDelegate>

@end

@implementation CLGStandartPrintManager


- (void)printImage:(UIImage *)image
{
    UIPrintInteractionController *print = [UIPrintInteractionController sharedPrintController];
    if(!print){
        self.lastMessage = kPrinterUnavailableErrorMessage;
        return;
    }
    
    print.delegate = self;
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputPhoto;
    printInfo.jobName = @"Collage";
    
    print.printInfo = printInfo;
    print.printingItem = UIImageJPEGRepresentation(image, 1.f);
    
    [print presentAnimated:YES
         completionHandler:^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError *error) {
             if(!completed && error){
                 self.lastMessage = kPrinterUnavailableErrorMessage;
             }
         }];

}

- (UIPrintPaper *)printInteractionController:(UIPrintInteractionController *)printInteractionController
                                 choosePaper:(NSArray *)paperList {
    
    CGSize pageSize = [UIScreen mainScreen].bounds.size;
    return [UIPrintPaper bestPaperForPageSize:pageSize withPapersFromArray:paperList];
    
}
@end
