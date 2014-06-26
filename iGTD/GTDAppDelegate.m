//
//  GTDAppDelegate.m
//  iGTD
//
//  Created by Jared McFarland on 6/8/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import "GTDAppDelegate.h"

#import "GTDMasterViewController.h"
#import "Project.h"
#import "Contact.h"
#import "Context.h"
#import "Tag.h"
#import "Action.h"

@implementation GTDAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [MagicalRecord setupCoreDataStack];
    
    // [self createTestData];
    
    return YES;
}

- (void)createTestData
{
    Context *home = [Context createEntity];
    home.name = @"Home";
    home.color = [UIColor blueColor];
    
    Context *office = [Context createEntity];
    office.name = @"Office";
    office.color = [UIColor redColor];
    
    Project *iosProject = [Project createEntity];
    iosProject.name = @"Learn iOS";
    iosProject.textDescription = @"Let's learn iOS for fun and profit!";
    iosProject.deadline = [NSDate distantFuture];
    iosProject.color = home.color;
    iosProject.context = home;
    
    Project *workProject = [Project createEntity];
    workProject.name = @"Prepare for DS season";
    workProject.textDescription = @"Build system and gameplan for this year's DS stores.";
    workProject.deadline = [NSDate distantFuture];
    workProject.color = office.color;
    workProject.context = office;
    
    Contact *natalie = [Contact createEntity];
    natalie.firstName = @"Natalie";
    natalie.lastName = @"Drusts";
    natalie.phone = @"808-333-5555";
    natalie.email = @"natalieskye4@yahoo.com";
    natalie.address1 = @"5255 Harmony Ave.";
    natalie.address2 = @"Apt 7";
    natalie.city = @"North Hollywood";
    natalie.state = @"CA";
    natalie.birthday = [NSDate date];
    natalie.relationship = @"Girlfriend";
    natalie.color = office.color;
    [workProject addContactsObject:natalie];
    
    Contact *mom = [Contact createEntity];
    mom.firstName = @"Sue";
    mom.lastName = @"Souders";
    mom.phone = @"937-369-4870";
    mom.email = @"ssouders112781@hotmail.com";
    mom.address1 = @"10108 Pond Creek Rd.";
    mom.address2 = nil;
    mom.city = @"Alexandria";
    mom.state = @"OH";
    mom.birthday = [NSDate distantFuture];
    mom.relationship = @"Mother";
    mom.color = home.color;
    [iosProject addContactsObject:mom];
    
    Tag *education = [Tag createEntity];
    education.title = @"Education";
    education.color = [UIColor yellowColor];
    [iosProject addTagsObject:education];
    [mom addTagsObject:education];
    
    Tag *fun = [Tag createEntity];
    fun.title = @"Fun";
    fun.color = [UIColor brownColor];
    [workProject addTagsObject:fun];
    [natalie addTagsObject:fun];
    
    Action *a1 = [Action createEntity];
    a1.title = @"Learn Core Data";
    a1.textDescription = @"Learn core data better.";
    a1.priority = @(2);
    a1.deadline = [NSDate distantFuture];
    a1.scheduledDate = nil;
    a1.color = home.color;
    a1.created = [NSDate date];
    a1.context = home;
    [a1 addTagsObject:education];
    [iosProject addActionsObject:a1];
    [a1 addContactsObject:natalie];
    [a1 addContactsObject:mom];
    
    Action *a2 = [Action createEntity];
    a2.title = @"Organize Filesystem";
    a2.textDescription = @"Clean up folders and re-organize.";
    a2.priority = @(3);
    a2.deadline = [NSDate distantPast];
    a2.scheduledDate = nil;
    a2.color = office.color;
    a2.created = [NSDate date];
    a2.context = office;
    [a2 addTagsObject:fun];
    [workProject addActionsObject:a2];
    [a2 addContactsObject:natalie];
    
    Action *a3 = [Action createEntity];
    a3.title = @"Refactor Code";
    a3.textDescription = @"Refactor code to make it better.";
    a3.priority = @(1);
    a3.deadline = [NSDate date];
    a3.scheduledDate = [NSDate date];
    a3.color = home.color;
    a3.created = [NSDate date];
    a3.context = home;
    [a3 addTagsObject:education];
    [a3 addTagsObject:fun];
    [iosProject addActionsObject:a3];
    [a3 addContactsObject:mom];
    
    Action *a4 = [Action createEntity];
    a4.title = @"Call Deb Thomas";
    a4.textDescription = @"Call to find out when new sheet arrives.";
    a4.priority = @(0);
    a4.deadline = [NSDate distantFuture];
    a4.scheduledDate = [NSDate date];
    a4.color = office.color;
    a4.created = [NSDate date];
    a4.context = office;
    [a4 addTagsObject:fun];
    [workProject addActionsObject:a4];
    [a4 addContactsObject:mom];
    
    NSManagedObjectContext *moc = [NSManagedObjectContext defaultContext];
    
    [moc saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (!success)
        {
            NSLog(@"Error saving Test Data: %@", [error localizedDescription]);
        } else
        {
            NSLog(@"TEST DATA SAVED!");
        }
    }];
    
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
    [MagicalRecord cleanUp];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    return [NSManagedObjectContext defaultContext];
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iGTD" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"iGTD.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
