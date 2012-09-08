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
@synthesize wordCountView = _wordCountView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Add WordCount VC on top (initial load)
        WordCountViewController *wordCountVC = [[WordCountViewController alloc] initWithNibName:@"WordCountViewController" bundle:nil];
        [self addChildViewController:wordCountVC];
        _wordCountView = [wordCountVC view];
        [self.view addSubview:_wordCountView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_bg"]];
    UIImage *characters = [UIImage imageNamed:@"characters"];
    _characterHolder = [[UIImageView alloc] initWithFrame:CGRectMake(30, 326, 226, 135)];
    _characterHolder.image = characters;
    _characterHolder.hidden = YES;
    [self.view addSubview:_characterHolder];
    [[SharedStore sharedList] createList];
    [[SharedStore sharedList] createList2];
    [[SharedStore sharedList] createList];
//    [[SharedStore sharedList] createList];
//    [[SharedStore sharedList] createList];
//    [[SharedStore sharedList] createList];
    _wordProfiles = [[[SharedStore sharedList] allLists] mutableCopy];
    NSLog(@"%@", [[_wordProfiles objectAtIndex:0] title]);
    
//    _wordProfiles = [@[
//    @[@"Holy Prayers",@"Lord",@"Father God",@"Jesus",@"Father"],
//    @[@"Brandon's List",@"Like",@"Basically",@"And",@"You Know"],
//    @[@"Clay's List",@"Groovy",@"Like Such As",@"And Then",@"Yup"],
//    @[@"Andres's List",@"I'm Mexican!",@"Crazy Apes",@"What?",@"Sure"]] mutableCopy];

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

- (WordListModel *)retrieveNewListFromPopup {
    UIButton *bgView = [[UIButton alloc] initWithFrame:[self.view bounds]];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.7;
    [self.view addSubview:bgView];
    [bgView addTarget:self action:@selector(cancelInput:) forControlEvents:UIControlEventTouchUpInside];
    NewListViewController *addList = [[NewListViewController alloc] init];
    addList.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.view addSubview:addList.view];
    return [[WordListModel alloc] initWithWords:[@[@"1",@"2",@"3",@"4"] mutableCopy] andTitle:@"Whatevs"];
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
            
        default:
//            cell.textLabel.text = [NSString stringWithFormat:@"%@", [[_wordProfiles objectAtIndex:[indexPath row] - 2] objectAtIndex:0]];
//            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  -  %@  -  %@  -  %@", [[_wordProfiles objectAtIndex:[indexPath row] - 2] objectAtIndex:1],[[_wordProfiles objectAtIndex:[indexPath row] - 2] objectAtIndex:2],[[_wordProfiles objectAtIndex:[indexPath row] - 2] objectAtIndex:3],[[_wordProfiles objectAtIndex:[indexPath row] - 2] objectAtIndex:4]];
            NSLog(@"Row #: %d", [indexPath row]);
            NSInteger targetList = [indexPath row] - 2;
            WordListModel *targetWordList = [_wordProfiles objectAtIndex:targetList];
            NSLog(@"%@",targetWordList);
            cell.textLabel.text = [targetWordList title];
            NSString *wordsListedOut = [NSString stringWithFormat:@"%@  -  %@  -  %@  -  %@",
                                        [[targetWordList words] objectAtIndex:0],
                                        [[targetWordList words] objectAtIndex:1],
                                        [[targetWordList words] objectAtIndex:2],
                                        [[targetWordList words] objectAtIndex:3]];
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
//        WordListModel *newFromUser = [[WordListModel alloc] initWithWords:[@[@"1",@"2",@"3",@"4"] mutableCopy] andTitle:@"Whatevs"];
        WordListModel *newFromUser = [self retrieveNewListFromPopup];
        [tableView beginUpdates];
        if([_wordProfiles count] == 3) {
//            NSIndexPath *ip = [[NSIndexPath alloc] init];
            NSIndexPath *ip = [NSIndexPath indexPathForRow:6 inSection:0];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationNone];
            _characterHolder.hidden = YES;
        }
        [[SharedStore sharedList] createListWithList:newFromUser];
//        [[SharedStore sharedList] createList];
        _wordProfiles = [[[SharedStore sharedList] allLists] mutableCopy];
//        NSIndexPath *ip = [[NSIndexPath alloc] init];
        NSIndexPath *ip = [NSIndexPath indexPathForRow:2 inSection:0];
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationTop];
        
        [tableView endUpdates];
//        [tableView reloadData];
        NSLog(@"What");
    } else {
        NSLog(@"Current List (Before): %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"currentList"]);
        [[NSUserDefaults standardUserDefaults] setObject:[[[tableView cellForRowAtIndexPath:indexPath] textLabel] text] forKey:@"currentList"];
        NSString *listHelper= [[NSUserDefaults standardUserDefaults] objectForKey:@"currentList"];
        [[SharedStore sharedList]setCurrentList:listHelper];
    
        NSLog(@"Current List (After): %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"currentList"]);
    }
}

-(void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    
}

@end
