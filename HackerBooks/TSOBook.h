#import "_TSOBook.h"

@interface TSOBook : _TSOBook {}

+(instancetype) bookWithTitle:(NSString *) title
                      authors:(NSString *) authors
                      context:(NSManagedObjectContext *) context;


@end
