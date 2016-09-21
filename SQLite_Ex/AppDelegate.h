//
//  AppDelegate.h
//  sample_db
//
//  Created by Krishna Prabha S on 7/21/15.
//  Copyright (c) 2015 KaryaTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DataStore *DBAccess;

@end


