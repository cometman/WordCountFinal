//
//  SharedStore.m
//  WordCountB1
//
//  Created by Clayton Selby on 8/29/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "SharedStore.h"
#import "WordListModel.h"
#import "WCWord.h"

@implementation SharedStore

@synthesize currentList = _currentList;

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedList];
}

+ (SharedStore *)sharedList {
    static SharedStore *defaultList = nil;
    if (!defaultList) {
        defaultList = [[super allocWithZone:nil] init];
    }
    return defaultList;
}

- (id)init {
    self = [super init];
    if (self) {
        allLists = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)allLists {
    return allLists;
}

- (WordListModel *)createList {
    NSArray *words = [[NSArray alloc] initWithObjects:
                      [[WCWord alloc] initWithWord:@"Jimmy" andCount:1],
                      [[WCWord alloc] initWithWord:@"Like" andCount:11],
                      [[WCWord alloc] initWithWord:@"Whatever" andCount:20],
                      [[WCWord alloc] initWithWord:@"You Know" andCount:23], nil];
    WordListModel *p = [[WordListModel alloc] initWithWords:[words mutableCopy] andTitle:@"WonderList"];
    [allLists addObject:p];
    
    return p;
}

- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

//- (BOOL)saveChanges {
//    // Returns success or failure
//    NSString *path = [self itemArchivePath];
//    
//    return [NSKeyedArchiver archiveRootObject:allLists toFile:path];
//}

@end
