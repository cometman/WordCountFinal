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
    
    // Add the observor to tell whne the user logs into Facebook
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(createFriendController)
     name:SCSessionStateChangedNotification
     object:nil];

    
}


-(void) createFriendController
{
    if (!self.friendPickerController) {
        self.friendPickerController = [[FBFriendPickerViewController alloc]
                                       initWithNibName:nil bundle:nil];
        self.friendPickerController.title = @"Select friends";
    }
    
    
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
            NSLog(@"Friend: %@", [self.selectedUser first_name]) ;
            NSString *messageString = [@"Post word count to " stringByAppendingString:[self.selectedUser first_name]];
            UIAlertView *confirmScreen = [[UIAlertView alloc] initWithTitle:@"Confirm post" message:messageString delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"yes", nil];
            [confirmScreen show];
        }
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        NSLog(@"Clicked submit!");
    }
}
@end
