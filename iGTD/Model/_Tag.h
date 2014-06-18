// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Tag.h instead.

#import <CoreData/CoreData.h>


extern const struct TagAttributes {
	__unsafe_unretained NSString *color;
	__unsafe_unretained NSString *title;
} TagAttributes;

extern const struct TagRelationships {
	__unsafe_unretained NSString *actions;
	__unsafe_unretained NSString *contacts;
	__unsafe_unretained NSString *projects;
} TagRelationships;

extern const struct TagFetchedProperties {
} TagFetchedProperties;

@class Action;
@class Contact;
@class Project;

@class NSObject;


@interface TagID : NSManagedObjectID {}
@end

@interface _Tag : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TagID*)objectID;





@property (nonatomic, strong) id color;



//- (BOOL)validateColor:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *actions;

- (NSMutableSet*)actionsSet;




@property (nonatomic, strong) NSSet *contacts;

- (NSMutableSet*)contactsSet;




@property (nonatomic, strong) NSSet *projects;

- (NSMutableSet*)projectsSet;





@end

@interface _Tag (CoreDataGeneratedAccessors)

- (void)addActions:(NSSet*)value_;
- (void)removeActions:(NSSet*)value_;
- (void)addActionsObject:(Action*)value_;
- (void)removeActionsObject:(Action*)value_;

- (void)addContacts:(NSSet*)value_;
- (void)removeContacts:(NSSet*)value_;
- (void)addContactsObject:(Contact*)value_;
- (void)removeContactsObject:(Contact*)value_;

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(Project*)value_;
- (void)removeProjectsObject:(Project*)value_;

@end

@interface _Tag (CoreDataGeneratedPrimitiveAccessors)


- (id)primitiveColor;
- (void)setPrimitiveColor:(id)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveActions;
- (void)setPrimitiveActions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveContacts;
- (void)setPrimitiveContacts:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;


@end
