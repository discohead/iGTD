// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Action.m instead.

#import "_Action.h"

const struct ActionAttributes ActionAttributes = {
	.color = @"color",
	.created = @"created",
	.deadline = @"deadline",
	.priority = @"priority",
	.scheduledDate = @"scheduledDate",
	.textDescription = @"textDescription",
	.title = @"title",
	.updated = @"updated",
};

const struct ActionRelationships ActionRelationships = {
	.contacts = @"contacts",
	.context = @"context",
	.project = @"project",
	.tags = @"tags",
};

const struct ActionFetchedProperties ActionFetchedProperties = {
};

@implementation ActionID
@end

@implementation _Action

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Action" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Action";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Action" inManagedObjectContext:moc_];
}

- (ActionID*)objectID {
	return (ActionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"priorityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"priority"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic color;






@dynamic created;






@dynamic deadline;






@dynamic priority;



- (int16_t)priorityValue {
	NSNumber *result = [self priority];
	return [result shortValue];
}

- (void)setPriorityValue:(int16_t)value_ {
	[self setPriority:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePriorityValue {
	NSNumber *result = [self primitivePriority];
	return [result shortValue];
}

- (void)setPrimitivePriorityValue:(int16_t)value_ {
	[self setPrimitivePriority:[NSNumber numberWithShort:value_]];
}





@dynamic scheduledDate;






@dynamic textDescription;






@dynamic title;






@dynamic updated;






@dynamic contacts;

	
- (NSMutableSet*)contactsSet {
	[self willAccessValueForKey:@"contacts"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"contacts"];
  
	[self didAccessValueForKey:@"contacts"];
	return result;
}
	

@dynamic context;

	

@dynamic project;

	

@dynamic tags;

	
- (NSMutableSet*)tagsSet {
	[self willAccessValueForKey:@"tags"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tags"];
  
	[self didAccessValueForKey:@"tags"];
	return result;
}
	






@end
