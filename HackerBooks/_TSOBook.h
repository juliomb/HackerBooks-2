// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TSOBook.h instead.

@import CoreData;

extern const struct TSOBookAttributes {
	__unsafe_unretained NSString *authors;
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *isFavourite;
	__unsafe_unretained NSString *title;
} TSOBookAttributes;

extern const struct TSOBookRelationships {
	__unsafe_unretained NSString *annotations;
	__unsafe_unretained NSString *pdf;
	__unsafe_unretained NSString *tags;
} TSOBookRelationships;

@class TSOAnnotation;
@class TSOPdf;
@class TSOTag;

@interface TSOBookID : NSManagedObjectID {}
@end

@interface _TSOBook : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TSOBookID* objectID;

@property (nonatomic, strong) NSString* authors;

//- (BOOL)validateAuthors:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSData* image;

//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* isFavourite;

@property (atomic) BOOL isFavouriteValue;
- (BOOL)isFavouriteValue;
- (void)setIsFavouriteValue:(BOOL)value_;

//- (BOOL)validateIsFavourite:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotations;

- (NSMutableSet*)annotationsSet;

@property (nonatomic, strong) TSOPdf *pdf;

//- (BOOL)validatePdf:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;

@end

@interface _TSOBook (AnnotationsCoreDataGeneratedAccessors)
- (void)addAnnotations:(NSSet*)value_;
- (void)removeAnnotations:(NSSet*)value_;
- (void)addAnnotationsObject:(TSOAnnotation*)value_;
- (void)removeAnnotationsObject:(TSOAnnotation*)value_;

@end

@interface _TSOBook (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(TSOTag*)value_;
- (void)removeTagsObject:(TSOTag*)value_;

@end

@interface _TSOBook (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthors;
- (void)setPrimitiveAuthors:(NSString*)value;

- (NSData*)primitiveImage;
- (void)setPrimitiveImage:(NSData*)value;

- (NSNumber*)primitiveIsFavourite;
- (void)setPrimitiveIsFavourite:(NSNumber*)value;

- (BOOL)primitiveIsFavouriteValue;
- (void)setPrimitiveIsFavouriteValue:(BOOL)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet*)primitiveAnnotations;
- (void)setPrimitiveAnnotations:(NSMutableSet*)value;

- (TSOPdf*)primitivePdf;
- (void)setPrimitivePdf:(TSOPdf*)value;

- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;

@end
