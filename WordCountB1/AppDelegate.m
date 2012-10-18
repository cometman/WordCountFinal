//
//  AppDelegate.m
//  WordCountB1
//
//  Created by Clayton Selby on 8/25/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "AppDelegate.h"
#import "WordListViewController.h"
#import "WordCountViewController.h"
#import "SharedStore.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FaceBookViewController.h"
#import "FriendTableViewController.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>

@implementation AppDelegate

@synthesize navController = _navController;
@synthesize permissions = _permissions;
@synthesize facebookPostImage = _facebookPostImage;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.permissions = [[NSArray alloc] initWithObjects:@"publish_actions", @"publish_stream", nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[WordListViewController alloc] initWithNibName:@"WordListViewController" bundle:nil];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = self.navController;
    
    [self.navController setNavigationBarHidden:YES];
    
    [self.window makeKeyAndVisible];
    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    BOOL success = [[SharedStore sharedList] saveChanges];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //[FBSession.activeSession close];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.


}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Facebook passes control to Safari for user to be authenticated, when the app is called back this method handles the incoming URL

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
        sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{

    return [FBSession.activeSession handleOpenURL:url];
}


//********** Facebook methods ********

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
            // If the facebook session is open and valid...
        case FBSessionStateOpen: {
            FaceBookViewController* faceBookViewController = [[FaceBookViewController alloc] initWithNibName:@"FaceBookViewController" bundle:nil];
            [faceBookViewController createFriendController];
            NSLog(@"Token created and loaded");
            [self.viewController presentModalViewController:faceBookViewController animated:YES];   

        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [self.navController popToRootViewControllerAnimated:NO];
            
            [FBSession.activeSession closeAndClearTokenInformation];
            
            [self showLoginView];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    [FBSession openActiveSessionWithPermissions:nil
                                   allowLoginUI:YES
                              completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

- (void)showLoginView
{
    // If the FB session is not active, take the user through the login process
    if (!FBSession.activeSession.isOpen)
    {
        NSArray* readPermission = [NSArray arrayWithObject:@"user_photos"];
        
        [FBSession openActiveSessionWithReadPermissions:readPermission allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            
            if (error)
            {
                NSLog(@" problem making sessions %@", [error description]);
            }
            
        }];
        
        [FBSession openActiveSessionWithPublishPermissions:self.permissions defaultAudience:FBSessionDefaultAudienceFriends allowLoginUI:NO completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            if (error)
            {
                NSLog(@"Error: %@", [error description]);
            }
            [self sessionStateChanged:session state:status error:error];
        }];
//        [FBSession openActiveSessionWithPermissions:nil
//                                       allowLoginUI:YES
//                                  completionHandler:
//         ^(FBSession *session,
//           FBSessionState state, NSError *error) {
//             
//             if (error)
//             {
//                 NSLog(@" problem making sessions %@", [error description]);
//             }
//             [self sessionStateChanged:session state:state error:error];
//          
//         }];
    }
 
}



#pragma mark - TWITTER IMPL

-(void) postTweet:(NSString *)tweetText andImage:(UIImage *)tweetImage
{
    NSURL *url = [NSURL URLWithString:@"https://upload.twitter.com/1/statuses/update_with_media.json"];
    
    // Create the post request for the target app
    TWRequest *request = [[TWRequest alloc] initWithURL:url parameters:nil requestMethod:TWRequestMethodPOST];
    
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    // Request permission to access Twitter accts.
    [store requestAccessToAccountsWithType:twitterAccountType withCompletionHandler:^(BOOL granted, NSError *error)
     {
         if (!granted)
         {
             NSLog(@"User rejected account access");
         }
         else
         {
             NSArray* twitterAccounts = [store accountsWithAccountType:twitterAccountType];
             
             if ([twitterAccounts count] > 0)
             {
                 ACAccount *account = [twitterAccounts objectAtIndex:0];
                 
                 [request setAccount:account];
                 
                 NSString *status = tweetText;
                 
                 [request addMultiPartData:[status dataUsingEncoding:NSUTF8StringEncoding] withName:@"status" type:@"multipart/form-data"];
             
                 // Perform the twitter request
                 
                 [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                     NSDictionary *dict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
                     NSLog(@"%@", dict);
                     
                     dispatch_async(dispatch_get_main_queue(), ^{
                         // Do cool stuff
                     });
                 }];
             }
         }
     }];
}
@end
