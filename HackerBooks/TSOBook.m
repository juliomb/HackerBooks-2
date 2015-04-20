#import "TSOBook.h"
#import "TSOPhoto.h"
#import "TSOPdf.h"

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


+(instancetype) bookWithDictionary:(NSDictionary *) dictionary
                           context:(NSManagedObjectContext *) context{
    
    TSOBook *book = [self insertInManagedObjectContext:context];
    
    book.title = [dictionary objectForKey:@"title"];
    book.authors = [dictionary objectForKey:@"authors"];
    
    // Creamos una Photo con la url
    book.photo = [TSOPhoto photoWithUrl:[dictionary objectForKey:@"image_url"]
                                context:context];
    
    // Hacemos lo mismo con el pdf
    book.pdf = [TSOPdf pdfWithUrl:[dictionary objectForKey:@"pdf_url"]
                          context:context];
    
    return book;
}

@end
