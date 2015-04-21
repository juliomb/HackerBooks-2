#import "_TSOBook.h"

@interface TSOBook : _TSOBook {}


+(instancetype) bookWithTitle:(NSString *) title
                      authors:(NSString *) authors
                      context:(NSManagedObjectContext *) context;

+(instancetype) bookWithDictionary:(NSDictionary *) dict
                           context:(NSManagedObjectContext *) context;

-(NSString *) stringWithTags;

-(BOOL) isFavourite;
-(void) addToFavourites;
-(void) removeFromFavourites;


@end
