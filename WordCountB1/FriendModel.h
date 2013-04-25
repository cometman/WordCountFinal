//
//  FriendModel.h
//  WordCountB1
//
//  Created by Clayton Selby on 4/24/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendModel : NSObject

@property (nonatomic) NSMutableArray* friendArray;
@property (nonatomic) NSMutableDictionary* topFriends;

// Create dictionary from JSON friend data
-(NSMutableDictionary *) createDictionaryOfFriends:(NSString *) friends;

@end
