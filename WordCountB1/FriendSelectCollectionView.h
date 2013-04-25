//
//  FriendSelectCollectionView.h
//  WordCountB1
//
//  Created by Clayton Selby on 4/24/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendProfileLayout.h"

@interface FriendSelectCollectionView : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar* searchBar;

@end
