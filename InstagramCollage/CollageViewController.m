//
//  CollageViewController.m
//  InstagramCollage
//
//  Created by Anton on 7/10/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//

#import "CollageViewController.h"

@interface CollageViewController ()

@end

@implementation CollageViewController {
    
    UIImageView *bigImg;

}

@synthesize imagesCollageArray, img, print;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NSLog(@"Get Objects %@", imagesCollageArray);

    //creating collage from selected pictures
    for (int i = 0; i < imagesCollageArray.count; i++) {
        NSString *url = [imagesCollageArray objectAtIndex:i];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
                                           queue:[NSOperationQueue mainQueue]
                                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                    
                                    CGFloat s = (float)(arc4random() % 20) / 100.f + 0.5f;
                                    CGFloat r = (double)(arc4random() % (int)(M_PI * 2*100)) / 100 - M_PI;
                                    CGAffineTransform scale = CGAffineTransformMakeScale(s, s);
                                    CGAffineTransform rotate = CGAffineTransformMakeRotation(r);
                                    CGAffineTransform transform  = CGAffineTransformConcat(scale, rotate);
                                    img.transform = transform;
                                               
                                               
                                   img = [[UIImageView alloc] initWithFrame:
                                                       CGRectMake(arc4random() % (200 - 30) + 20,
                                                                  arc4random() % (200 - 30) + 80,
                                                                  100, 100)];
                                               
                                   img.layer.borderWidth = 5.f;
                                   img.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7f].CGColor;
                                   img.image = [UIImage imageWithData:data];
                                   [self.view addSubview:img];

        }];
    }
}

//back to previous window
- (IBAction)backToGallery:(id)sender {
   
        [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sendToPrinter:(id)sender {
    
    //UIView rendering to UIIMage
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIPrintInteractionController *printer = [UIPrintInteractionController sharedPrintController];
    
    printer.delegate = self;
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = @"Collage";
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    printer.printInfo = printInfo;
    printer.showsPageRange = YES;
    printer.printingItem = resultingImage;
    UIViewPrintFormatter *viewFormatter = [self.view viewPrintFormatter];
    viewFormatter.startPage = 0;
    printer.printFormatter = viewFormatter;
    
    
    UIPrintInteractionCompletionHandler completionHandler = ^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError *error) {};
    
    [printer presentAnimated:YES completionHandler:completionHandler];
}
@end
