// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TSOAnnotation.m instead.

#import "_TSOAnnotation.h"

const struct TSOAnnotationAttributes TSOAnnotationAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.text = @"text",
};

const struct TSOAnnotationRelationships TSOAnnotationRelationships = {
	.book = @"book",
	.localization = @"localization",
	.photo = @"photo",
};

@implementation TSOAnnotationID
@end

@implementation _TSOAnnotation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Annotation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Annotation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:moc_];
}

- (TSOAnnotationID*)objectID {
	return (TSOAnnotationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic text;

@dynamic book;

@dynamic localization;

@dynamic photo;

@end

