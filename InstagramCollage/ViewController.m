//
//  ViewController.m
//  InstagramCollage
//
//  Created by Anton on 7/4/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "ImagePickerViewController.h"
#import "DataManager.h"



@interface ViewController ()

@property (assign, nonatomic) BOOL firstTimeAppear;

@end

@implementation ViewController

@synthesize textField, jsonUserIdData, jsonPictureUrlData, instaUserID;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(getPicturesFromServer:)
                                                 name: @"GetPicturesArray"
                                               object: nil];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(100, 80, 140, 100)];
    logo.image = [UIImage imageNamed:@"insta_logo.jpg"];
    logo.layer.cornerRadius = 10.f;
    [self.view addSubview:logo];
    
    //create textField and Button
    textField = [[UITextField alloc] initWithFrame:CGRectMake(40, 200, 250, 60)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Enter Instagram Username";
    textField.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.delegate = self;
    [self.view addSubview:textField];
    
    [textField becomeFirstResponder];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.layer.frame = CGRectMake(90, 280, 150, 40);
    button.layer.borderWidth = 0.5f;
    button.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5f].CGColor;
    button.layer.cornerRadius = 20.f;
    [button setTitle:@"Fetch Pictures" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getUserID:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:YES];
    
    
    if ([[DataManager sharedManager] accessToken] == nil) {
        self.firstTimeAppear = YES;
        [[DataManager sharedManager] authorizeUser];
    } else {
        self.firstTimeAppear = NO;
    }
    

    
}


- (void)getUserID:(id)sender {
    
    [[DataManager sharedManager] getUserIDFromServer:textField.text];
    [self.textField resignFirstResponder];
}

- (void) getPicturesFromServer: (NSNotificationCenter *)notification {

    UIStoryboard *storyboard = self.storyboard;
    ImagePickerViewController *imagePickerViewController = [storyboard instantiateViewControllerWithIdentifier:@"ImagePicker"];
    [imagePickerViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [imagePickerViewController setImagesArray:[[DataManager sharedManager] picturesUrl]];
    [self presentViewController:imagePickerViewController animated:YES completion:NULL];

}


#pragma mark - Hide Keyboard
//textField delegate method - hiding keyboard on Return button pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField1 {
    textField1 = textField;
    [textField1 resignFirstResponder];
    return YES;
}

//Hide keyboard while touched outside textFiled
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [textField resignFirstResponder];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
