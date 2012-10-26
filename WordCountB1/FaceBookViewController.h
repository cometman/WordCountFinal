//
//  FaceBookViewController.h
//  WordCountB1
//
//  Created by Clayton Selby on 9/9/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FaceBookViewController : UIViewController <FBFriendPickerDelegate>

@property (strong, nonatomic) FBFriendPickerViewController *friendPickerController;
@property (strong, nonatomic) id<FBGraphUser> selectedUser;


- (IBAction)logOut:(id)sender;
- (IBAction)cancel:(id)sender;
-(void) postToFacebook;
-(void) createFriendController;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *postIndicator;


@end
