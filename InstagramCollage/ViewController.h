//
//  ViewController.h
//  InstagramCollage
//
//  Created by Anton on 7/4/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePickerViewController.h"

//static const NSString *token = @"access_token=1223104.1fb234f.dce45f9e250d49499ae3da69d225495c";

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NSMutableData *jsonUserIdData;
@property (strong, nonatomic) NSMutableData *jsonPictureUrlData;
@property (strong, nonatomic) NSDictionary *instaUserID;

@property (strong, nonatomic) NSMutableArray *tempPics;


@end
