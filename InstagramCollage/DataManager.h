//
//  DataManager.h
//  InstagramCollage
//
//  Created by Anton on 8/3/14.
//  Copyright (c) 2014 áSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AuthViewController.h"


@interface DataManager : NSObject

@property (strong, nonatomic) NSMutableArray *picturesUrl;
@property (strong, nonatomic) NSString *accessToken;

+ (DataManager *) sharedManager;

- (void)getUserIDFromServer:(NSString*)username;

- (void)getPicturesFromServer:(NSString*)userID;

- (void)authorizeUser;

@end
