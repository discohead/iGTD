// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Action.m instead.

#import "_Action.h"

const struct ActionAttributes ActionAttributes = {
	.color = @"color",
	.completed = @"completed",
	.created = @"created",
	.deadline = @"deadline",
	.isAllDay = @"isAllDay",
	.priority = @"priority",
	.scheduledDate = @"scheduledDate",
	.startTime = @"startTime",
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
	
	if ([key isEqualToString:@"completedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"completed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isAllDayValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isAllDay"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"priorityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"priority"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"startTimeValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"startTime"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic color;






@dynamic completed;



- (BOOL)completedValue {
	NSNumber *result = [self completed];
	return [result boolValue];
}

- (void)setCompletedValue:(BOOL)value_ {
	[self setCompleted:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveCompletedValue {
	NSNumber *result = [self primitiveCompleted];
	return [result boolValue];
}

- (void)setPrimitiveCompletedValue:(BOOL)value_ {
	[self setPrimitiveCompleted:[NSNumber numberWithBool:value_]];
}





@dynamic created;






@dynamic deadline;






@dynamic isAllDay;



- (BOOL)isAllDayValue {
	NSNumber *result = [self isAllDay];
	return [result boolValue];
}

- (void)setIsAllDayValue:(BOOL)value_ {
	[self setIsAllDay:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsAllDayValue {
	NSNumber *result = [self primitiveIsAllDay];
	return [result boolValue];
}

- (void)setPrimitiveIsAllDayValue:(BOOL)value_ {
	[self setPrimitiveIsAllDay:[NSNumber numberWithBool:value_]];
}





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






@dynamic startTime;



- (int16_t)startTimeValue {
	NSNumber *result = [self startTime];
	return [result shortValue];
}

- (void)setStartTimeValue:(int16_t)value_ {
	[self setStartTime:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveStartTimeValue {
	NSNumber *result = [self primitiveStartTime];
	return [result shortValue];
}

- (void)setPrimitiveStartTimeValue:(int16_t)value_ {
	[self setPrimitiveStartTime:[NSNumber numberWithShort:value_]];
}





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
