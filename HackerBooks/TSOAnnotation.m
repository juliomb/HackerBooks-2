#import "TSOAnnotation.h"
#import "TSOPhoto.h"

@interface TSOAnnotation ()

// Private interface goes here.

@end

@implementation TSOAnnotation

#pragma mark - class Methods
+(NSArray *) observableKeys{
    return @[TSOAnnotationAttributes.text, TSOAnnotationRelationships.book, @"photo.photoData"];
}

+(instancetype) annotationWith:(NSString *) text
                          book:(TSOBook *) book
                       context:(NSManagedObjectContext *) context{
    
    TSOAnnotation *n = [self insertInManagedObjectContext:context];
    
    n.text = text;
    n.book = book;
    n.photo = [TSOPhoto insertInManagedObjectContext:context];
    n.creationDate = [NSDate date];
    n.modificationDate = [NSDate date];
    
    return n;
    
}


#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // actualizo la fecha de moficiación
    self.modificationDate = [NSDate date];
    
}


@end
