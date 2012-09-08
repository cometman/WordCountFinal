//
//  WordListModel.h
//  WordCountB1
//
<<<<<<< HEAD
// Anything i want
=======
//  Created by Clayton Selby on 8/29/12.
//  Look out for steep dropoffs.
>>>>>>> Fixed broken Copyright.
//

#import <Foundation/Foundation.h>

typedef struct {__unsafe_unretained NSString *word; int count;} Word;

@interface WordListModel : NSObject <NSCoding>

@property (nonatomic) NSMutableArray *words;
@property (nonatomic) NSString *title;

-(id)initWithWords:(NSMutableArray *)words andTitle:(NSString *)title;

-(void) countWord:(NSString *) word;


@end
