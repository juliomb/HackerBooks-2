// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TSOPdf.m instead.

#import "_TSOPdf.h"

const struct TSOPdfAttributes TSOPdfAttributes = {
	.pdfData = @"pdfData",
	.pdfUrl = @"pdfUrl",
};

const struct TSOPdfRelationships TSOPdfRelationships = {
	.book = @"book",
};

@implementation TSOPdfID
@end

@implementation _TSOPdf

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pdf" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pdf";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pdf" inManagedObjectContext:moc_];
}

- (TSOPdfID*)objectID {
	return (TSOPdfID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic pdfData;

@dynamic pdfUrl;

@dynamic book;

@end

