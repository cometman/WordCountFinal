//
//  WordListModel.h
//  WordCountB1
//
//  Created by Clayton Selby on 8/29/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {__unsafe_unretained NSString *word; int count;} Word;

@interface WordListModel : NSObject <NSCoding>

@property (nonatomic) NSMutableArray *words;
@property (nonatomic) NSString *title;

-(id)initWithWords:(NSMutableArray *)words andTitle:(NSString *)title;

-(void) countWord:(NSString *) word;


@end
