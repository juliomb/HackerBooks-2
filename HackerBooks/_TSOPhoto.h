// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TSOPhoto.h instead.

#import <CoreData/CoreData.h>

extern const struct TSOPhotoAttributes {
	__unsafe_unretained NSString *photoData;
	__unsafe_unretained NSString *photoUrl;
} TSOPhotoAttributes;

extern const struct TSOPhotoRelationships {
	__unsafe_unretained NSString *annotation;
	__unsafe_unretained NSString *book;
} TSOPhotoRelationships;

@class TSOAnnotation;
@class TSOBook;

@interface TSOPhotoID : NSManagedObjectID {}
@end

@interface _TSOPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TSOPhotoID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* photoUrl;

//- (BOOL)validatePhotoUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotation;

- (NSMutableSet*)annotationSet;

@property (nonatomic, strong) TSOBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

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

- (NSString*)primitivePhotoUrl;
- (void)setPrimitivePhotoUrl:(NSString*)value;

- (NSMutableSet*)primitiveAnnotation;
- (void)setPrimitiveAnnotation:(NSMutableSet*)value;

- (TSOBook*)primitiveBook;
- (void)setPrimitiveBook:(TSOBook*)value;

@end
