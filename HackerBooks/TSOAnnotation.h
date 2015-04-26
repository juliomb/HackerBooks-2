#import "_TSOAnnotation.h"

@interface TSOAnnotation : _TSOAnnotation {}

@property (nonatomic, readonly) BOOL hasLocation;

+(instancetype) annotationWith:(NSString *) name
                          book:(TSOBook *) notebook
                       context:(NSManagedObjectContext *) context;


@end
