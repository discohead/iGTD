// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contact.m instead.

#import "_Contact.h"

const struct ContactAttributes ContactAttributes = {
	.address1 = @"address1",
	.address2 = @"address2",
	.birthday = @"birthday",
	.city = @"city",
	.color = @"color",
	.email = @"email",
	.firstName = @"firstName",
	.lastName = @"lastName",
	.name = @"name",
	.phone = @"phone",
	.relationship = @"relationship",
	.state = @"state",
	.zip = @"zip",
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
	
	if ([key isEqualToString:@"zipValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"zip"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic address1;






@dynamic address2;






@dynamic birthday;






@dynamic city;






@dynamic color;






@dynamic email;






@dynamic firstName;






@dynamic lastName;






@dynamic name;






@dynamic phone;






@dynamic relationship;






@dynamic state;






@dynamic zip;



- (int32_t)zipValue {
	NSNumber *result = [self zip];
	return [result intValue];
}

- (void)setZipValue:(int32_t)value_ {
	[self setZip:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveZipValue {
	NSNumber *result = [self primitiveZip];
	return [result intValue];
}

- (void)setPrimitiveZipValue:(int32_t)value_ {
	[self setPrimitiveZip:[NSNumber numberWithInt:value_]];
}





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
