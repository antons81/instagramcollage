//
//  CollageViewController.h
//  InstagramCollage
//
//  Created by Anton on 7/10/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollageViewController : UIViewController <UIPrintInteractionControllerDelegate>

@property (strong, nonatomic) NSArray *imagesCollageArray;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *cancelCollage;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *print;
@property (strong, nonatomic) UIImageView *img;


@end
