//
//  DataManager.m
//  InstagramCollage
//
//  Created by Anton on 8/3/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//
//1223104


#import "DataManager.h"

@implementation DataManager

+ (DataManager *) sharedManager {

    static DataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });
    
return manager;
    
}

#pragma mark  - Get User Data

- (void)getUserIDFromServer:(NSString*)username {
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/search?q=%@&count=1&access_token=%@", username, self.accessToken];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
        
        NSString *userIdString = [[responseObject valueForKeyPath:@"data.id"] firstObject];

        
    [self getPicturesFromServer:userIdString];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[[UIAlertView alloc]
          initWithTitle:@"Error Retrieving User's ID"
          message:[error localizedDescription]
          delegate:nil
          cancelButtonTitle:@"Ok"
          otherButtonTitles:nil] show];
    }];
    
    [operation start];
    
}

- (void)getPicturesFromServer:(NSString*)userID {

NSString *urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/users/%@/media/recent?access_token=%@&count=10", userID, self.accessToken];
NSURL *url = [NSURL URLWithString:urlString];
NSURLRequest *request = [NSURLRequest requestWithURL:url];


AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
operation.responseSerializer = [AFJSONResponseSerializer serializer];

[operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
    
    self.picturesUrl = [responseObject valueForKeyPath:@"data.images.standard_resolution.url"];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"GetPicturesArray" object:self.picturesUrl];

    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
   [[[UIAlertView alloc]
    initWithTitle:@"Error Retrieving User's Pictures"
    message:[error localizedDescription]
    delegate:nil
    cancelButtonTitle:@"Ok"
    otherButtonTitles:nil] show];
    
}];

    [operation start];

}

- (void)authorizeUser {

    AuthViewController *authViewController = [[AuthViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:authViewController];
    UIViewController *vc  = [[[[UIApplication sharedApplication] windows] firstObject] rootViewController];
    [vc presentViewController:nav animated:YES completion:nil];
 
}


@end
