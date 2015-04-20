// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TSOBook.h instead.

@import CoreData;

extern const struct TSOBookAttributes {
	__unsafe_unretained NSString *authors;
	__unsafe_unretained NSString *title;
} TSOBookAttributes;

extern const struct TSOBookRelationships {
	__unsafe_unretained NSString *annotations;
	__unsafe_unretained NSString *pdf;
	__unsafe_unretained NSString *photo;
	__unsafe_unretained NSString *tags;
} TSOBookRelationships;

@class TSOAnnotation;
@class TSOPdf;
@class TSOPhoto;
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

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotations;

- (NSMutableSet*)annotationsSet;

@property (nonatomic, strong) TSOPdf *pdf;

//- (BOOL)validatePdf:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TSOPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

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

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet*)primitiveAnnotations;
- (void)setPrimitiveAnnotations:(NSMutableSet*)value;

- (TSOPdf*)primitivePdf;
- (void)setPrimitivePdf:(TSOPdf*)value;

- (TSOPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(TSOPhoto*)value;

- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;

@end
