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
        _words = words;
        _title = title;
    }
    return self;
}


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
    for(int i = 0; i < [_words count]; i++) {
        [aCoder encodeObject:[_words objectAtIndex:i] forKey:[NSString stringWithFormat:@"word%d",i]];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setTitle:[aDecoder decodeObjectForKey:@"title"]];
        
        // Grabbing the four words that were encoded with for loop and inserting into array.
        [self setWords:[NSArray arrayWithObjects:
                        [aDecoder decodeObjectForKey:@"word1"],
                        [aDecoder decodeObjectForKey:@"word2"],
                        [aDecoder decodeObjectForKey:@"word3"],
                        [aDecoder decodeObjectForKey:@"word4"], nil]];
    }
    return self;
}

@end
