// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TSOPdf.h instead.

@import CoreData;

extern const struct TSOPdfAttributes {
	__unsafe_unretained NSString *pdfData;
} TSOPdfAttributes;

extern const struct TSOPdfRelationships {
	__unsafe_unretained NSString *book;
} TSOPdfRelationships;

@class TSOBook;

@interface TSOPdfID : NSManagedObjectID {}
@end

@interface _TSOPdf : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TSOPdfID* objectID;

@property (nonatomic, strong) NSData* pdfData;

//- (BOOL)validatePdfData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) TSOBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _TSOPdf (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePdfData;
- (void)setPrimitivePdfData:(NSData*)value;

- (TSOBook*)primitiveBook;
- (void)setPrimitiveBook:(TSOBook*)value;

@end
