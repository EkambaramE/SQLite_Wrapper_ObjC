//
//  ViewController.h
//  sample_db
//
//  Created by Krishna Prabha S on 7/21/15.
//  Copyright (c) 2015 KaryaTechnologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *SELECT_BT;
@property (weak, nonatomic) IBOutlet UIButton *CREATE_BT;
@property (weak, nonatomic) IBOutlet UIButton *INSERT_BT;
@property (weak, nonatomic) IBOutlet UIButton *DELETE_BT;
@property (weak, nonatomic) IBOutlet UIButton *COUNT_BT;
@property (weak, nonatomic) IBOutlet UIButton *UPDATE_BT;
@property (weak, nonatomic) IBOutlet UILabel *OPERATION;
@property (weak, nonatomic) IBOutlet UITextView *OUTPUT;
@property (strong, nonatomic) AppDelegate *appDelegate;

@end

