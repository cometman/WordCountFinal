//
//  AppDelegate.h
//  WordCountB1
//
//  Created by Clayton Selby on 8/25/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WordListViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) WordListViewController *viewController;

@property (strong, nonatomic) UINavigationController* navController;

extern NSString *const SCSessionStateChangedNotification;

-(void) openSession;
-(void)performLogin:(id)sender;
-(void)showLoginView;
-(void) postTweet:(NSString *)tweetText andImage:(UIImage *)tweetImage;

@end
