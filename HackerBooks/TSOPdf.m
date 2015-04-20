#import "TSOPdf.h"

@interface TSOPdf ()

// Private interface goes here.

@end

@implementation TSOPdf

+(instancetype) pdfWithUrl: (NSString *) url
                   context: (NSManagedObjectContext *) context{
    
    TSOPdf *pdf = [TSOPdf insertInManagedObjectContext:context];
    pdf.pdfUrl = url;
    
    return pdf;
    
}

@end
