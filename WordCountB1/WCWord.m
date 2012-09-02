//
//  WCWord.m
//  WordCountB1
//
//  Created by Brandon Ashton on 8/30/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "WCWord.h"

@implementation WCWord

@synthesize word = _word;
@synthesize count = _count;

- (id)initWithWord:(NSString *)word andCount:(int)count {
    if ((self = [super init])) {
        _word = word;
        _count = count;
    }
    return self;
}

- (void)incrementCount:(NSInteger)byX {
    _count = _count + byX;
}

- (void)incrementCount {
    [self incrementCount:1];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"'%@': %d",_word,_count];
}

#pragma mark - NSCoding required methods

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_word forKey:@"word"];
    [aCoder encodeInt:_count forKey:@"count"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        [self setWord:[aDecoder decodeObjectForKey:@"word"]];
        [self setCount:[aDecoder decodeIntForKey:@"count"]];
    }
    return self;
}

@end
