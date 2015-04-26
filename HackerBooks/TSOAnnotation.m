#import "TSOAnnotation.h"
#import "TSOPhoto.h"
#import "TSOLocalization.h"
@import CoreLocation;

@interface TSOAnnotation () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation TSOAnnotation

@synthesize locationManager=_locationManager;

-(BOOL) hasLocation{
    return (nil != self.localization);
}


#pragma mark - class Methods
+(NSArray *) observableKeys{
    return @[TSOAnnotationAttributes.text, TSOAnnotationRelationships.book, @"photo.photoData", TSOAnnotationRelationships.localization];
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


#pragma mark - Init
-(void) awakeFromInsert{
    [super awakeFromInsert];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (((status == kCLAuthorizationStatusAuthorizedAlways) ||
         (status == kCLAuthorizationStatusNotDetermined) ||
         (status == kCLAuthorizationStatusAuthorizedWhenInUse)) &&
        [CLLocationManager locationServicesEnabled]) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        [self.locationManager startUpdatingLocation];
        
        // solo me interesan datos recientes
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self zapLocationManager];
        });
    }
}


#pragma mark - CLLocationManagerDelegate
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    // lo paramos para ahorrar batería
    [self zapLocationManager];
    
    if (![self hasLocation]) {
        
        // Pillamos la última loc
        CLLocation *loc = [locations lastObject];
        
        // La guardamos
        self.localization = [TSOLocalization locationWithCLLocation:loc
                                                       forAnotation:self];
    
    }else{
        
        NSLog(@"No deberíamos llegar aquí nunca");
        
    }

    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Error while getting core location : %@",[error localizedFailureReason]);
    if ([error code] == kCLErrorDenied) {
        NSLog(@"Acceso denegado");
    }
    [manager stopUpdatingLocation];
}


-(void) zapLocationManager{
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}


@end
