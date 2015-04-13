// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TSOBook.m instead.

#import "_TSOBook.h"

const struct TSOBookAttributes TSOBookAttributes = {
	.authors = @"authors",
	.image = @"image",
	.isFavourite = @"isFavourite",
	.title = @"title",
};

const struct TSOBookRelationships TSOBookRelationships = {
	.annotations = @"annotations",
	.pdf = @"pdf",
	.tags = @"tags",
};

@implementation TSOBookID
@end

@implementation _TSOBook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Book";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Book" inManagedObjectContext:moc_];
}

- (TSOBookID*)objectID {
	return (TSOBookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"isFavouriteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isFavourite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic authors;

@dynamic image;

@dynamic isFavourite;

- (BOOL)isFavouriteValue {
	NSNumber *result = [self isFavourite];
	return [result boolValue];
}

- (void)setIsFavouriteValue:(BOOL)value_ {
	[self setIsFavourite:@(value_)];
}

- (BOOL)primitiveIsFavouriteValue {
	NSNumber *result = [self primitiveIsFavourite];
	return [result boolValue];
}

- (void)setPrimitiveIsFavouriteValue:(BOOL)value_ {
	[self setPrimitiveIsFavourite:@(value_)];
}

@dynamic title;

@dynamic annotations;

- (NSMutableSet*)annotationsSet {
	[self willAccessValueForKey:@"annotations"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"annotations"];

	[self didAccessValueForKey:@"annotations"];
	return result;
}

@dynamic pdf;

@dynamic tags;

- (NSMutableSet*)tagsSet {
	[self willAccessValueForKey:@"tags"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tags"];

	[self didAccessValueForKey:@"tags"];
	return result;
}

@end

