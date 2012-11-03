//
//  FaceBookViewController.m
//  WordCountB1
//
//  Created by Clayton Selby on 9/9/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "FaceBookViewController.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "ReportViewController.h"
#import "WordCountViewController.h"
#import "WordListViewController.h"

@interface FaceBookViewController ()

@end

@implementation FaceBookViewController

@synthesize friendPickerController = _friendPickerController;
@synthesize selectedUser = _selectedUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}


-(void) createFriendController
{

    self.friendPickerController = [[FBFriendPickerViewController alloc]
                                       initWithNibName:nil bundle:nil];
    self.friendPickerController.title = @"Select friends";
    
    [self.navigationController pushViewController:self.friendPickerController
                                         animated:true];
    self.friendPickerController.view.frame = CGRectMake(0, 45, 320, 425);
    // self.friendPickerController.contentSizeForViewInPopover = CGSizeMake(self.view.frame.size.width, 350);
    self.friendPickerController.delegate =self;
    self.friendPickerController.allowsMultipleSelection = NO;
    [self.view addSubview:self.friendPickerController.view];
    [self.friendPickerController loadData];
    [self.friendPickerController updateView];
}
- (void)viewDidUnload
{
    [self setPostIndicator:nil];
    [self setPostIndicator:nil];
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)friendPickerViewControllerSelectionDidChange:
(FBFriendPickerViewController *)friendPicker
{
    // Check and make sure it is a valid selection 
    if ([friendPicker.selection lastObject])
    {
        self.selectedUser = [friendPicker.selection objectAtIndex:0];
        if (self.selectedUser)
        {
             [self postToFacebook];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex])
    {
       
    }
}

-(void)postToFacebook
{
//    [self.postIndicator setHidden:FALSE];
    [self.view addSubview:self.postIndicator];
    [self.postIndicator startAnimating];

    NSString* captionForPhoto = [NSString stringWithFormat:@"Tsk, tsk.  Look at %@'s Word Count!  Have a friend who uses the same words constantly?  Word Count em'!  http://jumpingbungee.com/wordcount", self.selectedUser.name];
    NSString* userId = self.selectedUser.id;
    
    // Retrieve the facebook photo to post from the file system
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString *docFile = [docDir stringByAppendingPathComponent: @"facebook.png"];
    
    NSData* savedFacebookImage = [[NSFileManager defaultManager] contentsAtPath:docFile];
    
    
    NSMutableDictionary* params =     [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                      savedFacebookImage, @"picture",
                                       captionForPhoto, @"caption",
                                       nil];
    // Code to post to a facebook wall
    [FBRequestConnection
     startWithGraphPath:[NSString stringWithFormat:@"me/photos"]
     parameters:params
     HTTPMethod:@"POST"
     completionHandler:^(FBRequestConnection *connection,
                         id result,
                         NSError *error) {
         NSString *alertText;
         if (error) {
             alertText = [NSString stringWithFormat:
                          @"error: domain = %@, code = %d",
                          error.domain, error.code];
         } 
       
        [self tagPicturewithId:[result objectForKey:@"id"] andUserId:userId];

     }];
 
}

/*
 Tag the user on Facebook
 */
-(void) tagPicturewithId:(NSString*) pictureId andUserId:(NSString *)userId
{
    [FBRequestConnection startWithGraphPath:[NSString stringWithFormat:@"%@/tags/%@",pictureId, userId] parameters:nil HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection,
                                                                                                                                                                      id result,
                                                                                                                                                                      NSError *error) {
        NSString* message = @"Great Success!  Go checkout your post!";
        
        if (error) {
            message = @"Uh oh...there was a problem.  Try again later please.";
        }

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert setAlpha:1.0f];
        [alert setBackgroundColor:[UIColor clearColor]];
        
            [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{

                [alert show];
                
            } completion:^ (BOOL completed) {
                
                    [self.postIndicator stopAnimating];
                    [self dismissViewControllerAnimated:YES completion:nil];
            }];

        
    }];

}





@end
