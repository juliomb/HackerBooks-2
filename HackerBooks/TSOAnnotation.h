#import "_TSOAnnotation.h"

@interface TSOAnnotation : _TSOAnnotation {}

+(instancetype) annotationWith:(NSString *) name
                          book:(TSOBook *) notebook
                       context:(NSManagedObjectContext *) context;


@end
