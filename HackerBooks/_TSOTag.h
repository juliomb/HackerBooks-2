// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TSOTag.h instead.

#import <CoreData/CoreData.h>

extern const struct TSOTagAttributes {
	__unsafe_unretained NSString *text;
} TSOTagAttributes;

extern const struct TSOTagRelationships {
	__unsafe_unretained NSString *books;
} TSOTagRelationships;

@class TSOBook;

@interface TSOTagID : NSManagedObjectID {}
@end

@interface _TSOTag : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) TSOTagID* objectID;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _TSOTag (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(TSOBook*)value_;
- (void)removeBooksObject:(TSOBook*)value_;

@end

@interface _TSOTag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
