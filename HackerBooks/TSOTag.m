#import "TSOTag.h"
#import "Settings.h"

@interface TSOTag ()

// Private interface goes here.

@end

@implementation TSOTag

+(instancetype) tagWithText:(NSString *) text
                       book:(TSOBook *) book
                    context:(NSManagedObjectContext *) context{
    
    
    TSOTag *tag = [self checkTagWithText:text
                                 context:context];
    
    if (tag == nil) {
        // si no existe lo creamos
        tag = [TSOTag insertInManagedObjectContext:context];
        tag.text = text;
    }
    
    if (book != nil){
        [tag addBooksObject:book];
    }
    
    return tag;
    
}



+(TSOTag *) checkTagWithText: (NSString *) text
                     context: (NSManagedObjectContext *) context{
    
    // Cogemos todos los tag
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:[TSOTag entityName]];
    
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:TSOTagAttributes.text
                                                       ascending:YES
                                                        selector:@selector(caseInsensitiveCompare:)]];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:fr error:&error];
    
    if (!error){
        
        for (TSOTag *tag in results) {
            
            // si lo encontramos lo devolvemos directamente
            if ([tag.text compare:text] == 0) {
                return tag;
            }
            
        }
        
    }else{
        NSLog(@"Error al recuperar tags: %@", error.userInfo);
    }
    
    return nil;
}



#pragma mark - Comparison
- (NSComparisonResult)compare:(TSOTag *)other{
    
    /* favorite always comes first */
    static NSString *fav = FAVOURITE_TAG;
    
    if ([[self text] isEqualToString:[other text]]) {
        return NSOrderedSame;
    }else if ([[self text] isEqualToString:fav]){
        return NSOrderedAscending;
    }else if ([[other text] isEqualToString:fav]){
        return NSOrderedDescending;
    }else{
        return [self.text compare:other.text];
    }
}

@end
