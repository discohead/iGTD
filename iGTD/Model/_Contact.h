// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Contact.h instead.

#import <CoreData/CoreData.h>


extern const struct ContactAttributes {
	__unsafe_unretained NSString *address1;
	__unsafe_unretained NSString *address2;
	__unsafe_unretained NSString *birthday;
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *color;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
	__unsafe_unretained NSString *phone;
	__unsafe_unretained NSString *relationship;
	__unsafe_unretained NSString *state;
	__unsafe_unretained NSString *zip;
} ContactAttributes;

extern const struct ContactRelationships {
	__unsafe_unretained NSString *actions;
	__unsafe_unretained NSString *projects;
	__unsafe_unretained NSString *tags;
} ContactRelationships;

extern const struct ContactFetchedProperties {
} ContactFetchedProperties;

@class Action;
@class Project;
@class Tag;





@class NSObject;








@interface ContactID : NSManagedObjectID {}
@end

@interface _Contact : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ContactID*)objectID;





@property (nonatomic, strong) NSString* address1;



//- (BOOL)validateAddress1:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* address2;



//- (BOOL)validateAddress2:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* birthday;



//- (BOOL)validateBirthday:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* city;



//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) id color;



//- (BOOL)validateColor:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* email;



//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* firstName;



//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lastName;



//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* phone;



//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* relationship;



//- (BOOL)validateRelationship:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* state;



//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* zip;



@property int32_t zipValue;
- (int32_t)zipValue;
- (void)setZipValue:(int32_t)value_;

//- (BOOL)validateZip:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *actions;

- (NSMutableSet*)actionsSet;




@property (nonatomic, strong) NSSet *projects;

- (NSMutableSet*)projectsSet;




@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;





@end

@interface _Contact (CoreDataGeneratedAccessors)

- (void)addActions:(NSSet*)value_;
- (void)removeActions:(NSSet*)value_;
- (void)addActionsObject:(Action*)value_;
- (void)removeActionsObject:(Action*)value_;

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(Project*)value_;
- (void)removeProjectsObject:(Project*)value_;

- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(Tag*)value_;
- (void)removeTagsObject:(Tag*)value_;

@end

@interface _Contact (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAddress1;
- (void)setPrimitiveAddress1:(NSString*)value;




- (NSString*)primitiveAddress2;
- (void)setPrimitiveAddress2:(NSString*)value;




- (NSDate*)primitiveBirthday;
- (void)setPrimitiveBirthday:(NSDate*)value;




- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (id)primitiveColor;
- (void)setPrimitiveColor:(id)value;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;




- (NSString*)primitivePhone;
- (void)setPrimitivePhone:(NSString*)value;




- (NSString*)primitiveRelationship;
- (void)setPrimitiveRelationship:(NSString*)value;




- (NSString*)primitiveState;
- (void)setPrimitiveState:(NSString*)value;




- (NSNumber*)primitiveZip;
- (void)setPrimitiveZip:(NSNumber*)value;

- (int32_t)primitiveZipValue;
- (void)setPrimitiveZipValue:(int32_t)value_;





- (NSMutableSet*)primitiveActions;
- (void)setPrimitiveActions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;



- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;


@end
