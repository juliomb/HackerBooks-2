#import "_TSOPhoto.h"

@interface TSOPhoto : _TSOPhoto {}

+(instancetype) photoWithUrl: (NSString *) url
                     context: (NSManagedObjectContext *) context;


@end
