//
//  ImagePickerViewController.m
//  InstagramCollage
//
//  Created by Anton on 7/8/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//

#import "ImagePickerViewController.h"
#import "CollageCollectionViewController.h"

@interface ImagePickerViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (strong, nonatomic) NSMutableArray *selectedPictures;
@property (strong, nonatomic) UIImageView *selectedImg;

@end

@implementation ImagePickerViewController

@synthesize imagesArray, selectedPictures, selectedImg;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selectedPictures = [NSMutableArray array];
    imagesArray = [NSMutableArray array];

    // creating collectionView custom layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection: UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumInteritemSpacing: 0.5f];
    [flowLayout setMinimumLineSpacing: 2.f];
    [flowLayout setItemSize: CGSizeMake (100, 100)];
    [flowLayout setSectionInset: UIEdgeInsetsMake (5, 5, 5, 5)];
    [self.imageCollectionView setCollectionViewLayout:flowLayout];

    self.imageCollectionView.dataSource = self;
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.allowsMultipleSelection = YES;
    self.imageCollectionView.layer.borderWidth = 0.f;
    self.imageCollectionView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    //NSLog(@"GETTING IMAGES ARRAY: %i", self.imagesArray.count);
 
    self.imagesArray = [[DataManager sharedManager] picturesUrl];
   [self.imageCollectionView reloadData];
    
}





#pragma mark  - ImagePickerCollectionView DataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesArray.count;
    //NSLog(@"COUNT URLS: %i", self.imagesArray.count);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"imageCell";
    
    ImageCollectionViewCell* collectionCell = [self.imageCollectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    if (!collectionCell) {
        collectionCell = [[ImageCollectionViewCell alloc] init];
    }
    
        collectionCell.imageFromInstagram.image = nil;
    
        NSString *url = [imagesArray objectAtIndex:indexPath.item];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]
                                           queue:[NSOperationQueue mainQueue]
                                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                                collectionCell.imageFromInstagram.image = [UIImage imageWithData:data];
                                           }];
    
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        view.backgroundColor = [UIColor colorWithRed:0.062 green:0.369 blue:0.689 alpha:0.8f];
        collectionCell.selectedBackgroundView = view;
    
        return collectionCell;
}


#pragma mark - ImagePickerCollectionView Delegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [selectedPictures addObject:[imagesArray objectAtIndex:indexPath.row]];

}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {

    [selectedPictures removeObject:[imagesArray objectAtIndex:indexPath.item]];
  
}

#pragma mark  - ImagePickerViewController button methods

- (IBAction)desmissController:(id)sender {
    [selectedPictures removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)getCollage:(id)sender {
    UIStoryboard *storyboard = self.storyboard;
    CollageViewController *collageViewController = [storyboard instantiateViewControllerWithIdentifier:@"printCollage"];
    [collageViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [collageViewController setImagesCollageArray:selectedPictures];
    [self presentViewController:collageViewController animated:YES completion:NULL];
}

/*- (IBAction)getCollage:(id)sender {
    UIStoryboard *storyboard = self.storyboard;
    CollageCollectionViewController *collageCollectionViewController = [storyboard instantiateViewControllerWithIdentifier:@"CollageCollectionView"];
    [collageCollectionViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [collageCollectionViewController setSelectedImages:selectedPictures];
    [self presentViewController:collageCollectionViewController animated:YES completion:nil];
}*/


#pragma mark - Other Methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
