//
//  WordListModel.h
//  WordCountB1
//
// Anything i want
//

#import <Foundation/Foundation.h>

typedef struct {__unsafe_unretained NSString *word; int count;} Word;

@interface WordListModel : NSObject <NSCoding>

@property (nonatomic) NSMutableArray *words;
@property (nonatomic) NSString *title;

-(id)initWithWords:(NSMutableArray *)words andTitle:(NSString *)title;

-(void) countWord:(NSString *) word;


@end
