//
//  DataStore.h
//  sample_db
//
//  Created by Krishna Prabha S on 7/21/15.
//  Copyright (c) 2015 KaryaTechnologies. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

typedef enum {
    CREATE = 111,
    INSERT = 211,
    SELECT = 311,
    DELETE = 411,
    UPDATE = 511,
    COUNT = 611
} DB_OP;

@interface DataStore : NSObject

@property (nonatomic, assign) sqlite3 *sqliteDB;
@property (nonatomic, assign) DB_OP DB_OPERATION;
@property (nonatomic, strong) NSString *databasePath;
-(id)initDataStore:(NSString*) databaseName;
-(NSArray*)DBOperation:(NSString *) query operation: (int) operation;

@end


