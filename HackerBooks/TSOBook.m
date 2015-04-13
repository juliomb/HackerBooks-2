#import "TSOBook.h"

@interface TSOBook ()

// Private interface goes here.

@end

@implementation TSOBook


+(instancetype) bookWithTitle:(NSString *) title
                      authors:(NSString *) authors
                      context:(NSManagedObjectContext *) context{
    
    TSOBook *book = [self insertInManagedObjectContext:context];
    
    book.title = title;
    book.authors = authors;
    
    return book;
    
}

@end
