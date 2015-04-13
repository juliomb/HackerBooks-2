// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TSOAnnotation.h instead.

@import CoreData;

extern const struct TSOAnnotationAttributes {
	__unsafe_unretained NSString *creationDate;
	__unsafe_unretained NSString *modificationDate;
	__unsafe_unretained NSString *text;
} TSOAnnotationAttributes;

extern const struct TSOAnnotationRelationships {
	__unsafe_unretained NSString *book;
	__unsafe_unretained NSString *localization;
	__unsafe_unretained NSString *photo;
} TSOAnnotationRelationships;

@class TSOBook;
@class TSOLocalization;
@class TSOPhoto;

@interface TSOAnnotationID : NSManagedObjectID {}
@end

@interface _TSOAnnotation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TSOAnnotationID* objectID;

@property (nonatomic, strong) NSDate* creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* modificationDate;

//- (BOOL)validateModificationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TSOBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TSOLocalization *localization;

//- (BOOL)validateLocalization:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TSOPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@end

@interface _TSOAnnotation (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;

- (NSDate*)primitiveModificationDate;
- (void)setPrimitiveModificationDate:(NSDate*)value;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (TSOBook*)primitiveBook;
- (void)setPrimitiveBook:(TSOBook*)value;

- (TSOLocalization*)primitiveLocalization;
- (void)setPrimitiveLocalization:(TSOLocalization*)value;

- (TSOPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(TSOPhoto*)value;

@end
