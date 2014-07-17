// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contact.m instead.

#import "_Contact.h"

const struct ContactAttributes ContactAttributes = {
	.abRecordID = @"abRecordID",
	.color = @"color",
	.firstName = @"firstName",
	.lastName = @"lastName",
	.name = @"name",
};

const struct ContactRelationships ContactRelationships = {
	.actions = @"actions",
	.projects = @"projects",
	.tags = @"tags",
};

const struct ContactFetchedProperties ContactFetchedProperties = {
};

@implementation ContactID
@end

@implementation _Contact

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Contact";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:moc_];
}

- (ContactID*)objectID {
	return (ContactID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"abRecordIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"abRecordID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic abRecordID;



- (int32_t)abRecordIDValue {
	NSNumber *result = [self abRecordID];
	return [result intValue];
}

- (void)setAbRecordIDValue:(int32_t)value_ {
	[self setAbRecordID:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveAbRecordIDValue {
	NSNumber *result = [self primitiveAbRecordID];
	return [result intValue];
}

- (void)setPrimitiveAbRecordIDValue:(int32_t)value_ {
	[self setPrimitiveAbRecordID:[NSNumber numberWithInt:value_]];
}





@dynamic color;






@dynamic firstName;






@dynamic lastName;






@dynamic name;






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
	

@dynamic tags;

	
- (NSMutableSet*)tagsSet {
	[self willAccessValueForKey:@"tags"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tags"];
  
	[self didAccessValueForKey:@"tags"];
	return result;
}
	






@end
