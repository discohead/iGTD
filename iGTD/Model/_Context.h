// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Context.h instead.

#import <CoreData/CoreData.h>


extern const struct ContextAttributes {
	__unsafe_unretained NSString *color;
	__unsafe_unretained NSString *title;
} ContextAttributes;

extern const struct ContextRelationships {
	__unsafe_unretained NSString *actions;
	__unsafe_unretained NSString *projects;
} ContextRelationships;

extern const struct ContextFetchedProperties {
} ContextFetchedProperties;

@class Action;
@class Project;

@class NSObject;


@interface ContextID : NSManagedObjectID {}
@end

@interface _Context : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ContextID*)objectID;





@property (nonatomic, strong) id color;



//- (BOOL)validateColor:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *actions;

- (NSMutableSet*)actionsSet;




@property (nonatomic, strong) NSSet *projects;

- (NSMutableSet*)projectsSet;





@end

@interface _Context (CoreDataGeneratedAccessors)

- (void)addActions:(NSSet*)value_;
- (void)removeActions:(NSSet*)value_;
- (void)addActionsObject:(Action*)value_;
- (void)removeActionsObject:(Action*)value_;

- (void)addProjects:(NSSet*)value_;
- (void)removeProjects:(NSSet*)value_;
- (void)addProjectsObject:(Project*)value_;
- (void)removeProjectsObject:(Project*)value_;

@end

@interface _Context (CoreDataGeneratedPrimitiveAccessors)


- (id)primitiveColor;
- (void)setPrimitiveColor:(id)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;





- (NSMutableSet*)primitiveActions;
- (void)setPrimitiveActions:(NSMutableSet*)value;



- (NSMutableSet*)primitiveProjects;
- (void)setPrimitiveProjects:(NSMutableSet*)value;


@end
