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
        NSLog(@"Clicked submit!");
    }
}

-(void)postToFacebook
{


//    [[NSMutableDictionary alloc] initWithObjectsAndKeys:
//     @"http://wordcount.jumpingbungee.com", @"link",
//     @"https://developers.facebook.com/attachment/iossdk_logo.png", @"picture",
//     @"Danielle posted a Word Count for Clay!", @"name",
//     @"How many times can someone say 'like' in a sentence?", @"caption",
//     @"The Facebook SDK for iOS makes it easier and faster to develop Facebook integrated iOS apps.", @"description",
//     nil];
 
    UIImage* testImage = [UIImage imageNamed:@"facebook"];
    NSString* captionForPhoto = @"Check out how many times Brandon said Like! http://google.com (Word Count for iOS)";
    
    NSData* pngFormat = UIImagePNGRepresentation(testImage);
//    NSString* userId = @"69101985";
    NSString* userId = @"100004512909286";
    
    NSArray* photoTags = [NSArray arrayWithObjects:userId, nil];
    NSMutableDictionary* params =     [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                      pngFormat, @"picture",
                                       captionForPhoto, @"caption",
                                       nil];
    // Code to post to a facebook wall
    // For production, uncomment this!
//    NSString* userId = [self.selectedUser objectForKey:@"id"];
   
    __block NSString* resultID;
    NSLog(@"User %@", userId);
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
         } else {
             alertText = [NSString stringWithFormat:
                          @"Posted action, id: %@",
                          [result objectForKey:@"id"]];
             
                          
         }
       
        [self tagPicturewithId:[result objectForKey:@"id"] andUserId:userId];
         //resultID = [result stringForKey:@"id"];
         NSLog(@"Value %@", [result objectForKey:@"id"]);
         
         


     }];

    
//    NSDictionary* tagParams = [[NSMutableDictionary alloc] initWithObjectsAndKeys:userId, @"id", nil];
    
//    NSString* currentToken = [[FBSession activeSession] accessToken];
    //

    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Found the report view class");

    
}

-(void) tagPicturewithId:(NSString*) pictureId andUserId:(NSString *)userId
{
         NSLog(@"picture id second:  %@ and userID %@", pictureId, userId);

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   userId,@"id",
                                   nil];
    
    [FBRequestConnection startWithGraphPath:[NSString stringWithFormat:@"%@/tags/%@",pictureId, userId] parameters:nil HTTPMethod:@"POST" completionHandler:^(FBRequestConnection *connection,
                                                                                                                                                                      id result,
                                                                                                                                                                      NSError *error) {
        if (error) {
            NSLog(@" Error in tagging %@", [error description]);
        }
    }];

}





@end
