//
//  HowToViewController.m
//  WordCountB1
//
//  Created by Brandon Ashton on 8/29/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "HowToViewController.h"

// Step 1 text: Find a repetitive friend
// Step 2 text: Pull out the app and count
// Step 3 text: Let everyone know about it

@interface HowToViewController ()

@end

@implementation HowToViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end