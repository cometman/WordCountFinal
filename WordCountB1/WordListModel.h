//
//  WordListModel.h
//  WordCountB1
//
//  Created by Clayton Selby on 8/29/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordListModel : NSObject

@property (nonatomic) NSMutableDictionary *words;
@property (nonatomic) NSString *title;

-(void) countWord:(NSString *) word;


@end
