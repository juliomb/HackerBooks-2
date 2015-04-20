#import "_TSOPdf.h"

@interface TSOPdf : _TSOPdf {}

+(instancetype) pdfWithUrl: (NSString *) url
                   context: (NSManagedObjectContext *) context;

@end
