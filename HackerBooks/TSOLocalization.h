#import "_TSOLocalization.h"
@import CoreLocation;

@interface TSOLocalization : _TSOLocalization {}


+(instancetype) locationWithCLLocation:(CLLocation *) location
                          forAnotation:(TSOAnnotation *) anotation;


@end
