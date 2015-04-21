#import "_TSOTag.h"

@interface TSOTag : _TSOTag {}

+(instancetype) tagWithText:(NSString *) text
                       book:(TSOBook *) book
                    context:(NSManagedObjectContext *) context;

- (NSComparisonResult)compare:(TSOTag *)tag;

@end
