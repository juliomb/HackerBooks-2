#import "TSOLocalization.h"
#import "TSOAnnotation.h"
@import AddressBookUI;

@interface TSOLocalization ()

// Private interface goes here.

@end

@implementation TSOLocalization

+(instancetype) locationWithCLLocation:(CLLocation *) location
                          forAnotation:(TSOAnnotation *) anotation{
    
    // Primero buscamos si tenemos una location con estas coordenadas
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[TSOLocalization entityName]];
    NSPredicate *latitude = [NSPredicate predicateWithFormat:@"abs(latitude) -abs(%lf) < 0.001", location.coordinate.latitude];
    NSPredicate *longitude = [NSPredicate predicateWithFormat:@"abs(longitude) -abs(%lf) < 0.001", location.coordinate.longitude];
    req.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitude, longitude]];
    
    NSError *error = nil;
    NSArray *results = [anotation.managedObjectContext executeFetchRequest:req error:&error];
    
    if (!error) {
        if ([results count]) {
            TSOLocalization *found = [results lastObject];
            [found addAnnotationsObject:anotation];
            return found;
        }
    }else{
        NSLog(@"Error al buscar localizaciones existentes: %@", error.userInfo);
    }
    
    
    TSOLocalization *loc = [self insertInManagedObjectContext:anotation.managedObjectContext];
    loc.latitudeValue = location.coordinate.latitude;
    loc.longitudeValue = location.coordinate.longitude;
    [loc addAnnotationsObject:anotation];
    
    // Direccion
    CLGeocoder *coder = [CLGeocoder new];
    [coder reverseGeocodeLocation:location
                completionHandler:^(NSArray *placemarks, NSError *error) {
                    if (error) {
                        NSLog(@"Error obteniendo dirección -> %@", error);
                    }else{
                        loc.address = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
                    }
                }];
    
    return loc;
    
}



@end
