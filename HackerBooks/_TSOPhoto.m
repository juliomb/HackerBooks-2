// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TSOPhoto.m instead.

#import "_TSOPhoto.h"

const struct TSOPhotoAttributes TSOPhotoAttributes = {
	.photoData = @"photoData",
};

const struct TSOPhotoRelationships TSOPhotoRelationships = {
	.annotation = @"annotation",
};

@implementation TSOPhotoID
@end

@implementation _TSOPhoto

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Photo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:moc_];
}

- (TSOPhotoID*)objectID {
	return (TSOPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic photoData;

@dynamic annotation;

- (NSMutableSet*)annotationSet {
	[self willAccessValueForKey:@"annotation"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"annotation"];

	[self didAccessValueForKey:@"annotation"];
	return result;
}

@end

