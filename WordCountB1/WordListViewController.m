//
//  WordListViewController.m
//  WordCountB1
//
//  Created by Clayton Selby on 8/25/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "WordListViewController.h"
#import "SharedStore.h"
#import "WordListModel.h"
#import "WordCountViewController.h"
#import "NewListViewController.h"
#import "WCWord.h"
#import "NewListViewController.h"

@interface WordListViewController ()

@property (nonatomic, strong) NSMutableArray *wordProfiles;
@property (nonatomic, strong) UIImageView *characterHolder;

@end

@implementation WordListViewController

@synthesize wordProfiles = _wordProfiles;
@synthesize wordCountVC = _wordCountVC;

NewListViewController *newListView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Add WordCount VC on top (initial load)
        self.wordCountVC = [[WordCountViewController alloc] initWithNibName:@"WordCountViewController" bundle:nil];
        [self addChildViewController:self.wordCountVC];
        [self.view addSubview:self.wordCountVC.view];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    newListView = [[NewListViewController alloc] initWithNibName:@"NewListViewController" bundle:nil];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_bg"]];
    UIImage *characters = [UIImage imageNamed:@"characters"];
    _characterHolder = [[UIImageView alloc] initWithFrame:CGRectMake(30, 326, 226, 135)];
    _characterHolder.image = characters;
    _characterHolder.hidden = YES;
    [self.view addSubview:_characterHolder];
    _wordProfiles = [[SharedStore sharedList] allLists];
    
    if ([_wordProfiles count] <= 3) {
        _characterHolder.hidden = NO;
    }

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

- (void)cancelInput:(id)sender {
    [sender removeFromSuperview];
}

- (void)retrieveNewListFromPopup {
    
    // Present the New List SemiModal view
  
    
    
//    newListView.delegate = self;
   
    [self presentSemiModalViewController:newListView];

//    return [[WordListModel alloc] initWithWords:[@[@"1",@"2",@"3",@"4"] mutableCopy] andTitle:@"Whatevs"];
}

#pragma mark - TableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    // Special case for last cell to hold the characters
    if ([_wordProfiles count] > 3 && ([indexPath row] == [_wordProfiles count] + 2)) {
        UIView *lastCell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 226, 135)];
        UIImage *characterImage = [UIImage imageNamed:@"characters"];
        iv.image = characterImage;
        [lastCell addSubview:iv];
        [cell setBackgroundView:lastCell];
        return cell;
    }
    
    // Setting the background of the cell in a UIImageView
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg"]];
    [cell setBackgroundView:iv];
    
    // Editing the properties of the title text and detail text
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"New List";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
            cell.imageView.image = [UIImage imageNamed:@"new_profile"];
            break;
            
        case 1:
            cell.textLabel.text = @"Default";
            cell.detailTextLabel.text = @"Like  -  Umm  -  Basically  -  You Know";
            cell.imageView.image = [UIImage imageNamed:@"default_star"];
            break;
        case 5:
            _characterHolder.hidden = YES;
        default:
//            cell.textLabel.text = [NSString stringWithFormat:@"%@", [[_wordProfiles objectAtIndex:[indexPath row] - 2] objectAtIndex:0]];
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  -  %@  -  %@  -  %@", [[_wordProfiles objectAtIndex:[indexPath row] - 2] objectAtIndex:1],[[_wordProfiles objectAtIndex:[indexPath row] - 2] objectAtIndex:2],[[_wordProfiles objectAtIndex:[indexPath row] - 2] objectAtIndex:3],[[_wordProfiles objectAtIndex:[indexPath row] - 2] objectAtIndex:4]];
            NSLog(@"Row #: %d", [indexPath row]);
            NSInteger targetList = [indexPath row] - 2;
            WordListModel *targetWordList = [_wordProfiles objectAtIndex:targetList];
            NSLog(@"%d",targetWordList.words.count);
            cell.textLabel.text = [targetWordList title];
            NSString *wordsListedOut = [NSString stringWithFormat:@"%@  -  %@  -  %@  -  %@",
                                        [[[targetWordList words] objectAtIndex:0] word],
                                        [[[targetWordList words] objectAtIndex:1] word],
                                        [[[targetWordList words] objectAtIndex:2] word],
                                        [[[targetWordList words] objectAtIndex:3] word]];
            cell.detailTextLabel.text = wordsListedOut;
            cell.imageView.image = [UIImage imageNamed:@"profileEdit"];
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == [_wordProfiles count] + 2) {
        return 145; // The height of the characters, plus a little padding
    } else return 54; // Standard height of a row
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int dataRows = [_wordProfiles count];
    if (dataRows > 3)
        return dataRows + 3;
    else
        return dataRows + 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected row: %@", [tableView indexPathForSelectedRow]);
    if ([indexPath row] == 0) {
        newListView.tableView = tableView;
        [self retrieveNewListFromPopup];
    } else {
        NSLog(@"Current List (Before): %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"currentList"]);
        [[NSUserDefaults standardUserDefaults] setObject:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text] forKey:@"currentList"];
        NSString *listHelper= [[NSUserDefaults standardUserDefaults] objectForKey:@"currentList"];
        [[SharedStore sharedList]setCurrentList:listHelper];
        
        [self.wordCountVC slideViewBack];
    
        NSLog(@"Current List (After): %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"currentList"]);
    }
}

- (void)listCancel:(id)viewController {
    [self dismissSemiModalViewController:viewController];
}

#pragma mark - Overriding SemiModal presentation methods

- (void)presentSemiModalViewController:(NewListViewController *)vc {
#define DEGREES_TO_RADIANS(x) (M_PI * (x)/180.0)
    
    UIView *modalView = vc.view;
    UIView *coverView = vc.coverView;
    
    // Not sure what this does, but it was commented out in the file I stole from
    // UIWindow *mainWindow = [(id)[[UIApplication sharedApplication] delegate] window];
    
    CGPoint middleCenter = self.view.center;
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    
    CGPoint offScreenCenter = CGPointZero;
    
    offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height *1.2);
    [modalView setBounds:CGRectMake(0, 0, 320, 460)];
    [coverView setFrame:CGRectMake(0, 0, 320, 460)];
    
    modalView.center = offScreenCenter;
    
    coverView.alpha = 0.0f;
    
    [self.view addSubview:coverView];
    [self addChildViewController:vc];
    [self.view addSubview:modalView];
    
    // Show it with a transition effect
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    modalView.center = middleCenter;
    coverView.alpha = 0.7;
    [UIView commitAnimations];
}

- (void) dismissSemiModalViewController:(NewListViewController *)vc {
    double animationDelay = 0.7;
    UIView *modalView = vc.view;
    UIView *coverView = vc.coverView;
    
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    
    CGPoint offScreenCenter = CGPointZero;
    
    offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    [UIView beginAnimations:nil context:(__bridge void *)(modalView)];
    [UIView setAnimationDuration:animationDelay];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissSemiModalViewControllerEnded:finished:context:)];
    modalView.center = offScreenCenter;
    coverView.alpha = 0.0f;
    [UIView commitAnimations];
    
    [coverView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:animationDelay];
}

- (void)dismissSemiModalViewControllerEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    UIView *modalView = (__bridge UIView *)context;
    [modalView removeFromSuperview];
}

@end
