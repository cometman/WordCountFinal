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
@synthesize defaultList = _defaultList;

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedList];
}

+ (SharedStore *)sharedList {
    static SharedStore *ss = nil;
    if (!ss) {
        ss = [[super allocWithZone:nil] init];
    }
    return ss;
}

- (id)init {
    self = [super init];
//    if (self) {
//        allLists = [[NSMutableArray alloc] init];
//    }
    if (self) {
        NSString *path = [self itemArchivePath];
        allLists = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If the array hadn't been saved previously, create a new empty one.
        if (!allLists) allLists = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSMutableArray *)allLists {
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
//    BOOL success = [self saveChanges];
//    if (success) NSLog(@"Successfully saved");
//    else NSLog(@"Not successfully saved");
    
    return p;
}

- (WordListModel *)createList2 {
    NSArray *words = [[NSArray alloc] initWithObjects:
                      [[WCWord alloc] initWithWord:@"Clay" andCount:1],
                      [[WCWord alloc] initWithWord:@"ha" andCount:11],
                      [[WCWord alloc] initWithWord:@"ab" andCount:20],
                      [[WCWord alloc] initWithWord:@"ok" andCount:23], nil];
    WordListModel *p = [[WordListModel alloc] initWithWords:[words mutableCopy] andTitle:@"A new one"];
    [allLists addObject:p];
    
    return p;
}

- (WordListModel *)createListWithList:(WordListModel *)newList {
    [allLists insertObject:newList atIndex:0];
    
    BOOL success = [self saveChanges];
    if (success) NSLog(@"Successfully saved");
    else NSLog(@"Not successfully saved");
    
    return newList;
}

- (NSString *)itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // Get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    NSLog(@"Called itemArchivePath: %@",documentDirectory);
    
    return [documentDirectory stringByAppendingPathComponent:@"items.archive"];
}

-(WordListModel *)getDefaultWordList
{
        WCWord *word = [[WCWord
                      alloc] initWithWord:@"Like" andCount:0];
        WCWord *word2 = [[WCWord
                      alloc] initWithWord:@"Umm..." andCount:0];
        WCWord *word3 = [[WCWord
                          alloc] initWithWord:@"Basically" andCount:0];
        WCWord *word4 = [[WCWord
                      alloc] initWithWord:@"You Know" andCount:0];
    
        NSMutableArray *wordArray = [[NSMutableArray alloc] initWithObjects:word, word2, word3, word4, nil];
    
        self.defaultList = [[WordListModel alloc] initWithWords:wordArray andTitle:@"Default"];
    
        return self.defaultList;
}

-(WordListModel *) getCurrentWordListModel
{
     WordListModel* currentWordListModel;
    
    // Loop through all the lists to find the current list object
    for (int i = 0; i < [self.allLists count]; i++)
    {
        WordListModel *wordListModel = [self.allLists objectAtIndex:i];
        if ([wordListModel.title isEqualToString:self.currentList])
        {
            currentWordListModel = wordListModel;
             return currentWordListModel;
        }
    }   
    
    // If we do not find a list in the above loop, return the default list
    currentWordListModel = [self getDefaultWordList];
    return currentWordListModel;
}

- (BOOL)saveChanges {
    // Returns success or failure
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:allLists toFile:path];
}

@end
