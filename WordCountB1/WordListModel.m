//
//  WordListModel.m
//  WordCountB1
//
//  Created by Clayton Selby on 8/29/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "WordListModel.h"
#import "WCWord.h"

@implementation WordListModel

@synthesize words = _words;
@synthesize title = _title;

-(id)initWithWords:(NSMutableArray *)words andTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = title;
        _words = words;
//        [_words addObject:[[WCWord alloc] initWithWord:[words objectAtIndex:0] andCount:0]];
//        [_words addObject:[[WCWord alloc] initWithWord:[words objectAtIndex:1] andCount:0]];
//        [_words addObject:[[WCWord alloc] initWithWord:[words objectAtIndex:2] andCount:0]];
//        [_words addObject:[[WCWord alloc] initWithWord:[words objectAtIndex:3] andCount:0]];
    }
    return self;
}

//NSArray *words = [[NSArray alloc] initWithObjects:
//                  [[WCWord alloc] initWithWord:@"Jimmy" andCount:1],
//                  [[WCWord alloc] initWithWord:@"Like" andCount:11],
//                  [[WCWord alloc] initWithWord:@"Whatever" andCount:20],
//                  [[WCWord alloc] initWithWord:@"You Know" andCount:23], nil];
//WordListModel *p = [[WordListModel alloc] initWithWords:[words mutableCopy] andTitle:@"WonderList"];

-(void)countWord:(NSString *)targetWord {
    for (WCWord *item in _words) {
        if([item word] == targetWord) {
            [item incrementCount];
        }
    }
}

#pragma mark - NSCoding required methods

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_title forKey:@"title"];
    [aCoder encodeObject:[_words objectAtIndex:0] forKey:@"word1"];
    [aCoder encodeObject:[_words objectAtIndex:1] forKey:@"word2"];
    [aCoder encodeObject:[_words objectAtIndex:2] forKey:@"word3"];
    [aCoder encodeObject:[_words objectAtIndex:3] forKey:@"word4"];
//    for(int i = 0; i < [_words count]; i++) {
//        [aCoder encodeObject:[_words objectAtIndex:i] forKey:[NSString stringWithFormat:@"word%d",i]];
//        NSLog(@"%@", [_words objectAtIndex:i]);
//    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        NSLog(@"Decoding a word list. The title got set to %@", _title);
        
        // Grabbing the four words that were encoded with for loop and inserting into array.
        [self setWords:[NSArray arrayWithObjects:
                        [aDecoder decodeObjectForKey:@"word1"],
                        [aDecoder decodeObjectForKey:@"word2"],
                        [aDecoder decodeObjectForKey:@"word3"],
                        [aDecoder decodeObjectForKey:@"word4"], nil]];
        NSLog(@"And the words got set to: %@, %@, %@, and %@",[_words objectAtIndex:0],[_words objectAtIndex:1],[_words objectAtIndex:2],[_words objectAtIndex:3]);
    }
    return self;
}

@end
