//
//  FriendProfileCell.m
//  WordCountB1
//
//  Created by Clayton Selby on 4/24/13.
//  Copyright (c) 2013 abc. All rights reserved.
//

#import "FriendProfileCell.h"

@implementation FriendProfileCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
        self.profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.frame.size.width, self.frame.size.height)];
        [self addSubview:self.profileImage];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
