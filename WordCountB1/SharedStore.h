//
//  SharedStore.h
//  WordCountB1
//
//  Created by Clayton Selby on 8/29/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WordListModel;

@interface SharedStore : NSObject {
    NSMutableArray *allLists;
}

@property (nonatomic, strong)NSString *currentList;

+ (SharedStore *)sharedList;

- (NSArray *)allLists;
- (WordListModel *)createList;

- (NSString *)itemArchivePath;
//- (BOOL)saveChanges;

@end
