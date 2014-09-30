//
//  CollageCollectionViewController.m
//  InstagramCollage
//
//  Created by Anton on 7/12/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//

#import "CollageCollectionViewController.h"



@interface CollageCollectionViewController ()

@end

@implementation CollageCollectionViewController

@synthesize collageCollectionView, selectedImages;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //NSLog(@"%@", selectedImages);
    // Configure layout
    CustomFlowLayout *customLayout = [[CustomFlowLayout alloc] init];
    //self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [customLayout setItemSize:CGSizeMake(100, 100)];
    //[self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    customLayout.minimumInteritemSpacing = 0.00004f;
    //[self.collageCollectionView setCollectionViewLayout:self.flowLayout];
    self.collageCollectionView.bounces = YES;
    [self.collageCollectionView setShowsHorizontalScrollIndicator:NO];
    [self.collageCollectionView setShowsVerticalScrollIndicator:NO];
    
    self.collageCollectionView.collectionViewLayout = customLayout;
    
    self.collageCollectionView.delegate = self;
    self.collageCollectionView.dataSource = self;
    
    
    
    [self.collageCollectionView reloadData];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return selectedImages.count;
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollageCollectionViewCell *cell = [self.collageCollectionView dequeueReusableCellWithReuseIdentifier:@"collageCell" forIndexPath:indexPath];
    cell.selectedImage.image = nil;
  
    /*NSString *url = [selectedImages objectAtIndex:indexPath.item];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               cell.selectedImage.image = [UIImage imageWithData:data];
                               
                           }];*/
    cell.selectedImage.image = [UIImage imageNamed:@"insta_logo.jpg"];
    
    return cell;

}


#pragma mark - UICollectionViewDelegate





#pragma mark - Buttons Methods

- (IBAction)backToGallery:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)sendToPrinter:(id)sender {
    
    UIPrintInteractionController *printer = [UIPrintInteractionController sharedPrintController];
    
    printer.delegate = self;
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = @"Collage";
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    printer.printInfo = printInfo;
    printer.showsPageRange = YES;
    printer.printingItem = self.collageCollectionView;
    UIViewPrintFormatter *viewFormatter = [self.view viewPrintFormatter];
    viewFormatter.startPage = 0;
    printer.printFormatter = viewFormatter;
    
    
    UIPrintInteractionCompletionHandler completionHandler = ^(UIPrintInteractionController *printInteractionController, BOOL completed, NSError *error) {};
    
    [printer presentAnimated:YES completionHandler:completionHandler];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
