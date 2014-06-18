// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Project.m instead.

#import "_Project.h"

const struct ProjectAttributes ProjectAttributes = {
	.color = @"color",
	.deadline = @"deadline",
	.name = @"name",
	.textDescription = @"textDescription",
};

const struct ProjectRelationships ProjectRelationships = {
	.actions = @"actions",
	.contacts = @"contacts",
	.context = @"context",
	.tags = @"tags",
};

const struct ProjectFetchedProperties ProjectFetchedProperties = {
};

@implementation ProjectID
@end

@implementation _Project

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Project";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Project" inManagedObjectContext:moc_];
}

- (ProjectID*)objectID {
	return (ProjectID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic color;






@dynamic deadline;






@dynamic name;






@dynamic textDescription;






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
	

@dynamic context;

	

@dynamic tags;

	
- (NSMutableSet*)tagsSet {
	[self willAccessValueForKey:@"tags"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tags"];
  
	[self didAccessValueForKey:@"tags"];
	return result;
}
	






@end
