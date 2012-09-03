//
//  CountButton.h
//  WordCountB1
//
//  Created by Clayton Selby on 9/2/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountButton : UIButton

@property (nonatomic) UILabel* onesLabel;
@property (nonatomic) UILabel* tensLabel;
@property (nonatomic) UILabel* hundredsLabel;
@property (nonatomic) CGFloat countLabelX;
@property (nonatomic, strong) UIButton *buttonTrigger;

-(void) countWord:(id) sender;
-(void) addTitleLabel:(NSString *)title;

@end
