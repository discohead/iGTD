// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Tag.m instead.

#import "_Tag.h"

const struct TagAttributes TagAttributes = {
	.color = @"color",
	.title = @"title",
};

const struct TagRelationships TagRelationships = {
	.actions = @"actions",
	.contacts = @"contacts",
	.projects = @"projects",
};

const struct TagFetchedProperties TagFetchedProperties = {
};

@implementation TagID
@end

@implementation _Tag

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Tag";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Tag" inManagedObjectContext:moc_];
}

- (TagID*)objectID {
	return (TagID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic color;






@dynamic title;






@dynamic actions;

	
- (NSMutableSet*)actionsSet {
	[self willAccessValueForKey:@"actions"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"actions"];
  
	[self didAccessValueForKey:@"actions"];
	return result;
}
	

@dynamic contacts;

	
- (NSMutableSet*)contactsSet {
	[self willAccessValueForKey:@"contacts"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"contacts"];
  
	[self didAccessValueForKey:@"contacts"];
	return result;
}
	

@dynamic projects;

	
- (NSMutableSet*)projectsSet {
	[self willAccessValueForKey:@"projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projects"];
  
	[self didAccessValueForKey:@"projects"];
	return result;
}
	






@end
