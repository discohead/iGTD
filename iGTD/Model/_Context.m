// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Context.m instead.

#import "_Context.h"

const struct ContextAttributes ContextAttributes = {
	.color = @"color",
	.title = @"title",
};

const struct ContextRelationships ContextRelationships = {
	.actions = @"actions",
	.projects = @"projects",
};

const struct ContextFetchedProperties ContextFetchedProperties = {
};

@implementation ContextID
@end

@implementation _Context

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Context" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Context";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Context" inManagedObjectContext:moc_];
}

- (ContextID*)objectID {
	return (ContextID*)[super objectID];
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
	

@dynamic projects;

	
- (NSMutableSet*)projectsSet {
	[self willAccessValueForKey:@"projects"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"projects"];
  
	[self didAccessValueForKey:@"projects"];
	return result;
}
	






@end
