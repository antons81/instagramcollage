//
//  CollageCollectionViewController.h
//  InstagramCollage
//
//  Created by Anton on 7/12/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollageCollectionViewCell.h"
#import "CustomFlowLayout.h"

@interface CollageCollectionViewController : UIViewController <UICollectionViewDataSource,
UICollectionViewDelegate, UIPrintInteractionControllerDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collageCollectionView;
@property (strong, nonatomic) NSArray *selectedImages;

//@property (nonatomic, strong) IBOutlet UICollectionViewFlowLayout *flowLayout;


@end
