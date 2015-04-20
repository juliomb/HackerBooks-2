#import "TSOPhoto.h"

@interface TSOPhoto ()

// Private interface goes here.

@end

@implementation TSOPhoto

+(instancetype) photoWithUrl: (NSString *) url
                     context: (NSManagedObjectContext *) context{
    
    TSOPhoto *photo = [self insertInManagedObjectContext:context];
    
    photo.photoUrl = url;
    
    return photo;
    
}

@end
