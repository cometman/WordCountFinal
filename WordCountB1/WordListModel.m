//
//  WordListModel.m
//  WordCountB1
//
//  Created by Clayton Selby on 8/29/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "WordListModel.h"

@implementation WordListModel
@synthesize words = _words;
@synthesize title = _title;

-(id)initWithWords:(NSMutableDictionary *)words andTitle:(NSString *)title
{
    self = [super init];
    if (self)
    {
        _words = words;
        _title = title;
    }
    return self;
}


-(void)countWord:(NSString *)word
{
    NSInteger wordCount = [[self.words objectForKey:word] integerValue];
    ++wordCount;
    [self.words setObject:[NSNumber numberWithInt:wordCount] forKey:word];
}

@end
