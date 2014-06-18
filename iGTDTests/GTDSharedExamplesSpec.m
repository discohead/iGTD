//
//  GTDSharedExamplesSpec.m
//  iGTD
//
//  Created by Jared McFarland on 6/8/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

SharedExamplesBegin(ManagedObjectBehavior)

sharedExamplesFor(@"a managed object", ^(NSDictionary *data) {
    Class managedObjectClass = data[@"class"];
    context(@"given it has been created", ^{
        
        id managedObject = [managedObjectClass createEntity];
        
        it(@"should be able to be fetched", ^{
            NSArray *entities = [managedObjectClass findAll];
            expect([entities count]).to.equal(1);
        });
        it(@"should be able to be saved", ^{
            NSManagedObjectContext *moc = [NSManagedObjectContext defaultContext];
            NSError *error;
            [moc save:&error];
            if (error) NSLog(@"Error: %@ saving context for %@",error,managedObject);
        });
    });
    
    
    
});

SharedExamplesEnd
