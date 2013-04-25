//
//  FriendSelectCollectionView.m
//  WordCountB1
//
//  Created by Clayton Selby on 4/24/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "FriendSelectCollectionView.h"
#import "FriendProfileCell.h"

static NSString* const FriendCellIdentifier = @"FriendCell";

@interface FriendSelectCollectionView ()

@property (nonatomic, weak) IBOutlet FriendProfileLayout *friendProfileLayout;

@end



@implementation FriendSelectCollectionView

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
    
    // Push the content down to make room for search bar
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    [self.collectionView setContentInset:inset];

    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    
    [self.collectionView registerClass:[FriendProfileCell class]
            forCellWithReuseIdentifier:FriendCellIdentifier];
    
    UIToolbar* toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 40, self.view.bounds.size.width, 40)];
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    self.searchBar.placeholder = @"Find Friend";

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSearchBar)];
    [self.collectionView addGestureRecognizer:tapGesture];
//    [self.view addGestureRecognizer:tapGesture];
    [self.searchBar setDelegate:self];
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    
    NSArray* barItems = [[NSArray alloc] initWithObjects:cancelButton, nil];
    [self.view addSubview:self.searchBar];
    toolbar.items = barItems;
    
     [self.view addSubview:toolbar];
}

-(void) cancel
{
    NSLog(@"Returning to previous view");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) hideSearchBar
{
    NSLog(@"Search bar hiding");
    [self.searchBar resignFirstResponder];
 
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"Searching...");
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FriendProfileCell *photoCell =
    [collectionView dequeueReusableCellWithReuseIdentifier:FriendCellIdentifier
                                              forIndexPath:indexPath];
    
    // Load the image for the cell off the main thread
    [self performSelectorInBackground:@selector(loadImage:) withObject:photoCell];

    return photoCell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"Did select a cell %@",[cell description]);
}

-(void)loadImage:(FriendProfileCell *)photoCell
{
    NSURL* url = [NSURL URLWithString:@"http://jonbennallick.co.uk/wp-content/uploads/2012/08/Facebook-logo-ICON-02.png"];
    NSData* imageContents = [NSData dataWithContentsOfURL:url];
    
    UIImage* image = [UIImage imageWithData:imageContents];
    [photoCell.profileImage setImage:image];
}

@end
