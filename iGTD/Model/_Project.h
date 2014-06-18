// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Project.h instead.

#import <CoreData/CoreData.h>


extern const struct ProjectAttributes {
	__unsafe_unretained NSString *color;
	__unsafe_unretained NSString *deadline;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *textDescription;
} ProjectAttributes;

extern const struct ProjectRelationships {
	__unsafe_unretained NSString *actions;
	__unsafe_unretained NSString *contacts;
	__unsafe_unretained NSString *context;
	__unsafe_unretained NSString *tags;
} ProjectRelationships;

extern const struct ProjectFetchedProperties {
} ProjectFetchedProperties;

@class Action;
@class Contact;
@class Context;
@class Tag;

@class NSObject;




@interface ProjectID : NSManagedObjectID {}
@end

@interface _Project : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ProjectID*)objectID;





@property (nonatomic, strong) id color;



//- (BOOL)validateColor:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* deadline;



//- (BOOL)validateDeadline:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* textDescription;



//- (BOOL)validateTextDescription:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *actions;

- (NSMutableSet*)actionsSet;




@property (nonatomic, strong) NSSet *contacts;

- (NSMutableSet*)contactsSet;




@property (nonatomic, strong) Context *context;

//- (BOOL)validateContext:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;





@end

@interface _Project (CoreDataGeneratedAccessors)

- (void)addActions:(NSSet*)value_;
- (void)removeActions:(NSSet*)value_;
- (void)addActionsObject:(Action*)value_;
- (void)removeActionsObject:(Action*)value_;

- (void)addContacts:(NSSet*)value_;
- (void)removeContacts:(NSSet*)value_;
- (void)addContactsObject:(Contact*)value_;
- (void)removeContactsObject:(Contact*)value_;

- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(Tag*)value_;
- (void)removeTagsObject:(Tag*)value_;

@end

@interface _Project (CoreDataGeneratedPrimitiveAccessors)


- (id)primitiveColor;
- (void)setPrimitiveColor:(id)value;




- (NSDate*)primitiveDeadline;
- (void)setPrimitiveDeadline:(NSDate*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitiveTextDescription;
- (void)setPrimitiveTextDescription:(NSString*)value;





- (NSMutableSet*)primitiveActions;
- (void)setPrimitiveActions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveContacts;
- (void)setPrimitiveContacts:(NSMutableSet*)value;



- (Context*)primitiveContext;
- (void)setPrimitiveContext:(Context*)value;



- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;


@end
