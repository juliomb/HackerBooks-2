#import "TSOBook.h"
#import "TSOPhoto.h"
#import "TSOPdf.h"
#import "TSOTag.h"
#import "Settings.h"

@interface TSOBook ()

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
    
    
    // Tags
    NSArray *tags = [[dictionary objectForKey:@"tags"] componentsSeparatedByString:@", "];
    for (NSString *tag in tags){
        
        // Los vamos añadiendo si no existen
        [TSOTag tagWithText:tag
                       book:book
                    context:context];
        
    }
    
    return book;
}


-(NSString *) stringWithTags{
    NSArray *tags = [self.tags allObjects];
    NSMutableString *tagString = [@"| " mutableCopy];
    for (TSOTag *tag in tags) {
        tagString = [[[tagString stringByAppendingString:tag.text] stringByAppendingString:@" | "] mutableCopy];
    }
    
    return tagString;
}


-(BOOL) isFavourite{
    NSArray *tags = [self.tags allObjects];
    for (TSOTag *tag in tags) {
        if ([tag.text isEqualToString:FAVOURITE_TAG]) {
            return YES;
        }
    }
    return NO;
}


-(void) addToFavourites{
    
    // Añadimos el tag favoritos
    [TSOTag tagWithText:FAVOURITE_TAG book:self context:self.managedObjectContext];
    
    // guardamos
    NSError *error;
    [self.managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"Error al guardar el tag favoritos");
    }
    
}

-(void) removeFromFavourites{
    
    // Eliminamos el tag favoritos
    TSOTag *tag = [TSOTag tagWithText:FAVOURITE_TAG book:self context:self.managedObjectContext];
    [self.managedObjectContext deleteObject:tag];
    
    // guardamos
    NSError *error;
    [self.managedObjectContext save:&error];
    
    if (error) {
        NSLog(@"Error al guardar el tag favoritos");
    }
    
}



@end
