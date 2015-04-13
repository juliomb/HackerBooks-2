// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TSOPhoto.h instead.

@import CoreData;

extern const struct TSOPhotoAttributes {
	__unsafe_unretained NSString *photoData;
} TSOPhotoAttributes;

extern const struct TSOPhotoRelationships {
	__unsafe_unretained NSString *annotation;
} TSOPhotoRelationships;

@class TSOAnnotation;

@interface TSOPhotoID : NSManagedObjectID {}
@end

@interface _TSOPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TSOPhotoID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotation;

- (NSMutableSet*)annotationSet;

@end

@interface _TSOPhoto (AnnotationCoreDataGeneratedAccessors)
- (void)addAnnotation:(NSSet*)value_;
- (void)removeAnnotation:(NSSet*)value_;
- (void)addAnnotationObject:(TSOAnnotation*)value_;
- (void)removeAnnotationObject:(TSOAnnotation*)value_;

@end

@interface _TSOPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhotoData;
- (void)setPrimitivePhotoData:(NSData*)value;

- (NSMutableSet*)primitiveAnnotation;
- (void)setPrimitiveAnnotation:(NSMutableSet*)value;

@end
