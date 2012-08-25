//
//  WordListViewController.m
//  WordCountB1
//
//  Created by Clayton Selby on 8/25/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "WordListViewController.h"

NSInteger const NumDataRows = 5;

@interface WordListViewController ()

@end

@implementation WordListViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"profile_bg"]];
    if (NumDataRows <= 3) {
        UIImage *characters = [UIImage imageNamed:@"characters"];
        UIImageView *imageHolder = [[UIImageView alloc] initWithFrame:CGRectMake(30, 326, 226, 135)];
        imageHolder.image = characters;
        [self.view addSubview:imageHolder];
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

#pragma mark - TableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    // Special case for last cell to hold the characters
    if (NumDataRows > 3 && ([indexPath row] == NumDataRows + 2)) {
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
            cell.textLabel.text = @"Someone's List";
            cell.detailTextLabel.text = @"One  -  Two  -  Three  -  Four";
            cell.imageView.image = [UIImage imageNamed:@"profileEdit"];
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == NumDataRows + 2) {
        return 145;
    } else return 54;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (NumDataRows > 3)
        return NumDataRows + 3;
    else
        return NumDataRows + 2;
}

@end
