//
//  ImagePickerViewController.h
//  InstagramCollage
//
//  Created by Anton on 7/8/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCollectionViewCell.h"
#import "CollageViewController.h"
#import "DataManager.h"


@interface ImagePickerViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *imagesArray;


@end
