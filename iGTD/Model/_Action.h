// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Action.h instead.

#import <CoreData/CoreData.h>


extern const struct ActionAttributes {
	__unsafe_unretained NSString *color;
	__unsafe_unretained NSString *created;
	__unsafe_unretained NSString *deadline;
	__unsafe_unretained NSString *priority;
	__unsafe_unretained NSString *scheduledDate;
	__unsafe_unretained NSString *textDescription;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *updated;
} ActionAttributes;

extern const struct ActionRelationships {
	__unsafe_unretained NSString *contacts;
	__unsafe_unretained NSString *context;
	__unsafe_unretained NSString *project;
	__unsafe_unretained NSString *tags;
} ActionRelationships;

extern const struct ActionFetchedProperties {
} ActionFetchedProperties;

@class Contact;
@class Context;
@class Project;
@class Tag;

@class NSObject;








@interface ActionID : NSManagedObjectID {}
@end

@interface _Action : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ActionID*)objectID;





@property (nonatomic, strong) id color;



//- (BOOL)validateColor:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* created;



//- (BOOL)validateCreated:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* deadline;



//- (BOOL)validateDeadline:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* priority;



@property int16_t priorityValue;
- (int16_t)priorityValue;
- (void)setPriorityValue:(int16_t)value_;

//- (BOOL)validatePriority:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* scheduledDate;



//- (BOOL)validateScheduledDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* textDescription;



//- (BOOL)validateTextDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* updated;



//- (BOOL)validateUpdated:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *contacts;

- (NSMutableSet*)contactsSet;




@property (nonatomic, strong) Context *context;

//- (BOOL)validateContext:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Project *project;

//- (BOOL)validateProject:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;





@end

@interface _Action (CoreDataGeneratedAccessors)

- (void)addContacts:(NSSet*)value_;
- (void)removeContacts:(NSSet*)value_;
- (void)addContactsObject:(Contact*)value_;
- (void)removeContactsObject:(Contact*)value_;

- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(Tag*)value_;
- (void)removeTagsObject:(Tag*)value_;

@end

@interface _Action (CoreDataGeneratedPrimitiveAccessors)


- (id)primitiveColor;
- (void)setPrimitiveColor:(id)value;




- (NSDate*)primitiveCreated;
- (void)setPrimitiveCreated:(NSDate*)value;




- (NSDate*)primitiveDeadline;
- (void)setPrimitiveDeadline:(NSDate*)value;




- (NSNumber*)primitivePriority;
- (void)setPrimitivePriority:(NSNumber*)value;

- (int16_t)primitivePriorityValue;
- (void)setPrimitivePriorityValue:(int16_t)value_;




- (NSDate*)primitiveScheduledDate;
- (void)setPrimitiveScheduledDate:(NSDate*)value;




- (NSString*)primitiveTextDescription;
- (void)setPrimitiveTextDescription:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




- (NSDate*)primitiveUpdated;
- (void)setPrimitiveUpdated:(NSDate*)value;





- (NSMutableSet*)primitiveContacts;
- (void)setPrimitiveContacts:(NSMutableSet*)value;



- (Context*)primitiveContext;
- (void)setPrimitiveContext:(Context*)value;



- (Project*)primitiveProject;
- (void)setPrimitiveProject:(Project*)value;



- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;


@end
