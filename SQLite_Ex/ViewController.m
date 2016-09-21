//
//  ViewController.m
//  sample_db
//
//  Created by Krishna Prabha S on 7/21/15.
//  Copyright (c) 2015 KaryaTechnologies. All rights reserved.
//



//[self.appDelegate.DBAccess DBOperation:query operation:CREATE]


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize appDelegate, OUTPUT, OPERATION;

- (void)viewDidLoad {
    self.appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)creation:(id)sender {
    [OPERATION setText: @"Creation"];
    NSString *query = @"CREATE TABLE IF NOT EXISTS myDetails (id integer primary key, name text)";
    if ([[self.appDelegate.DBAccess DBOperation:query operation:CREATE][0]  isEqual: @TRUE]) {
        OUTPUT.text = @"Mission Accomplished...!";
    } else {
        OUTPUT.text = @"Mission Abort...!";
    }
}

-(IBAction)selection:(id)sender {
    [OPERATION setText: @"Selection"];
    NSString *query = @"SELECT * FROM myDetails";
    if ([self.appDelegate.DBAccess DBOperation:query operation:SELECT].count > 0) {
        NSLog(@"Mission Accomplished...!");
        OUTPUT.text = [NSString stringWithFormat:@"Values-> %@", [self.appDelegate.DBAccess DBOperation:query operation:SELECT]];
    } else {
        OUTPUT.text = @"Mission Abort...!";
    }
}

-(IBAction)insertion:(id)sender {
    [OPERATION setText: @"Insertion"];
    NSString *query = @"INSERT INTO myDetails (id, name) values (107326, 'Faleela')";
    if ([[self.appDelegate.DBAccess DBOperation:query operation:INSERT][0]  isEqual: @TRUE]) {
        OUTPUT.text = @"Mission Accomplished...!";
    } else {
        OUTPUT.text = @"Mission Abort...!";
    }
}

-(IBAction)deletion:(id)sender {
    [OPERATION setText: @"Deletion"];
    NSString *query = @"DELETE FROM myDetails WHERE id = 1001";
    if ([[self.appDelegate.DBAccess DBOperation:query operation:DELETE][0]  isEqual: @TRUE]) {
        OUTPUT.text = @"Mission Accomplished...!";
    } else {
        OUTPUT.text = @"Mission Abort...!";
    }
}

-(IBAction)updation:(id)sender {
    [OPERATION setText: @"Updation"];
    NSString *query = @"UPDATE myDetails set name = 'Anand' WHERE id = 1001";
    if ([[self.appDelegate.DBAccess DBOperation:query operation:UPDATE][0]  isEqual: @TRUE]) {
        OUTPUT.text = @"Mission Accomplished...!";
    } else {
        OUTPUT.text = @"Mission Abort...!";
    }
}

-(IBAction)counting:(id)sender {
    [OPERATION setText: @"Counting"];
    NSString *query = @"SELECT COUNT(*) FROM myDetails";
    if ([self.appDelegate.DBAccess DBOperation:query operation:COUNT].count > 0) {
        NSLog(@"Mission Accomplished...!");
        OUTPUT.text = [NSString stringWithFormat:@"Values-> %@", [self.appDelegate.DBAccess DBOperation:query operation:COUNT][0]];
    } else {
       OUTPUT.text = @"Mission Abort...!";
    }
}

-(IBAction)mutipleInsertion:(id)sender {
    [OPERATION setText: @"Mutiple Value Insertion"];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSString *tableName = @"myDetails";
    NSInteger idNo = 1000;
    for (int i = 0; i < 10; i++) {
        NSMutableDictionary *row = [[NSMutableDictionary alloc] init];
        [row setObject:[NSString stringWithFormat:@"%ld", (long)++idNo] forKey:@"id"];
        [row setObject:[NSString stringWithFormat:@"Anand%d", i+1] forKey:@"name"];
        [data addObject:row];
    }
    NSLog(@"%@", data);
    if ([self.appDelegate.DBAccess DBOperation:tableName operation:211]) {
                NSLog(@"Mission Accomplished...!");
    } else {
        OUTPUT.text = @"Mission Abort...!";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
