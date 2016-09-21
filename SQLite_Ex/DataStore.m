//
//  NSObject+DataStore.m
//  sample_db
//
//  Created by Krishna Prabha S on 7/21/15.
//  Copyright (c) 2015 KaryaTechnologies. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore
@synthesize sqliteDB, DB_OPERATION, databasePath;

-(id) initDataStore:(NSString*) databaseName {
    NSArray *directoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = directoryPath[0];
    databasePath = [[NSString alloc] initWithString:[documentDirectory stringByAppendingPathComponent:databaseName]];
    NSLog(@"%@", databasePath);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:databasePath] == NO) {
        const char *dbPath = [databasePath UTF8String];
        if (sqlite3_open(dbPath, &sqliteDB) == SQLITE_OK) {
            NSLog(@"Database Created Succesfully...!");
        } else {
            NSLog(@"Database Creation Failed...!");
        }
    } else {
        NSLog(@"Database already Created...!");
    }
    return self;
}

-(NSMutableArray*) DBOperation:(NSString *)query operation:(int)operation {
    const char *dbPath = [databasePath UTF8String];
    const char *sql_statement = [query UTF8String];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    char *err;
    int count;
    switch (operation) {
        case CREATE:
            if (sqlite3_open(dbPath, &sqliteDB) == SQLITE_OK) {
                if (sqlite3_exec(sqliteDB, sql_statement, NULL, NULL, &err) == SQLITE_OK) {
                    NSLog(@"Table Created Successfully...!");
                    [result addObject:@TRUE];
                } else {
                    NSLog(@"Table Creation Failed...!");
                    [result addObject:@FALSE];
                }
            }
            break;
        case DELETE:
            if ([self CIDUOperation:query operation:@"Deletion"] == TRUE) {
                [result addObject:@TRUE];
            } else {
                [result addObject:@FALSE];
            }
            break;
        case UPDATE:
            if ([self CIDUOperation:query operation:@"Updation"] == TRUE) {
                [result addObject:@TRUE];
            } else {
                [result addObject:@FALSE];
            }
            break;
        case COUNT:
            [result addObjectsFromArray:[self SCOperation:query operation:@"Counting"]];
            count = (int)result.count;
            if (count == 0) {
                [result removeAllObjects];
            }
            break;
        case SELECT:
            [result addObjectsFromArray:[self SCOperation:query operation:@"Selection"]];
            count = (int)result.count;
            if (count == 0) {
                [result removeAllObjects];
            }
            break;
        case INSERT:
            if ([self CIDUOperation:query operation:@"Insertion"] == TRUE) {
                [result addObject:@TRUE];
            } else {
                [result addObject:@FALSE];
            }
            break;
        default:
            NSLog(@"You are going to die");
            break;
    }
    return result;
}

-(BOOL) CIDUOperation:(NSString*) query operation:(NSString*) operation {
    const char *dbPath = [databasePath UTF8String];
    const char *sql_statement = [query UTF8String];
    sqlite3_stmt *sqlite_stmt;
    BOOL result = false;
    
    if (sqlite3_open(dbPath, &sqliteDB) == SQLITE_OK) {
        if (sqlite3_prepare_v2(sqliteDB, sql_statement, -1, &sqlite_stmt, NULL) == SQLITE_OK) {
            if (sqlite3_step(sqlite_stmt) == SQLITE_DONE) {
                result = true;
                NSLog(@"%@ is Success...!", operation);
            } else {
                NSLog(@"%@ is Failed...!", operation);
            }
            sqlite3_finalize(sqlite_stmt);
        } else {
            NSLog(@"Database Error-> %s", sqlite3_errmsg(sqliteDB));
        }
        sqlite3_close(sqliteDB);
    } else {
        NSLog(@"Database is not opened...!");
    }
    return result;
}

-(NSMutableArray*)SCOperation:(NSString*) query operation:(NSString*) operation {
    
    const char *dbPath = [databasePath UTF8String];
    const char *sql_statement = [query UTF8String];
    sqlite3_stmt *sqlite_stmt;
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSNumber *count;
    if (sqlite3_open(dbPath, &sqliteDB) == SQLITE_OK) {
        if (sqlite3_prepare_v2(sqliteDB, sql_statement, -1, &sqlite_stmt, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(sqlite_stmt) == SQLITE_ROW) {
                
                if ([operation isEqualToString:@"Selection"]) {
                    NSMutableDictionary *dictionaryValues = [[NSMutableDictionary alloc] init];
                    for (int i = 0; i < sqlite3_data_count(sqlite_stmt); i++) {
                        
                        if (sqlite3_column_text(sqlite_stmt, i)) {
                            
                            [dictionaryValues setValue:[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlite_stmt, i)] forKey:[NSString stringWithUTF8String:(char *) sqlite3_column_name(sqlite_stmt, i)]];
                            
                        }
                        
                    }
                    
                    [result addObject:dictionaryValues];
                    
                    NSLog(@"%@ Selection Successful...!", operation);
                } else {
                    count = [NSNumber numberWithInt:sqlite3_column_int(sqlite_stmt, 0)];
                }
            }
            if ([operation isEqualToString:@"Counting"]) {
                [result addObject:count];
            }
            
        } else {
            
            NSLog(@"Database Error-> %s", sqlite3_errmsg(sqliteDB));
            
        }
        
        sqlite3_finalize(sqlite_stmt);
        
    } else {
        
        NSLog(@"Database is not opened...!");
        
    }
    sqlite3_close(sqliteDB);
    
    return result;
}



@end

