//
//  WCWord.h
//  WordCountB1
//
//  Created by Brandon Ashton on 8/30/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCWord : NSObject <NSCoding>

@property (nonatomic)NSString *word;
@property (nonatomic)int count;

- (id)initWithWord:(NSString *)word andCount:(int)count;

- (void)incrementCount:(NSInteger)byX;
- (void)incrementCount;

@end
