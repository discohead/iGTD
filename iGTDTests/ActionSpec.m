//
//  ActionSpec.m
//  iGTD
//
//  Created by Jared McFarland on 6/8/14.
//  Copyright (c) 2014 Jared McFarland. All rights reserved.
//

#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "Action.h"
#import "Tag.h"
#import "Project.h"
#import "Contact.h"
#import "Context.h"

SpecBegin(Action)

describe(@"An Action", ^{
    
    __block Action *testAction;
    __block NSDate *createdDate;
    __block NSDate *updatedDate;
    __block NSDate *deadlineDate;
    __block NSDate *scheduledDate;
    
    beforeAll(^{
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        createdDate = [NSDate distantPast];
        updatedDate = [NSDate date];
        deadlineDate = [NSDate distantFuture];
        scheduledDate = [NSDate distantFuture];
        testAction = [Action createEntity];
        testAction.title = @"A GTD Action";
        testAction.textDescription = @"A long description of the action";
        testAction.priority = @(1);
        testAction.created = createdDate;
        testAction.updated = updatedDate;
        testAction.scheduledDate = scheduledDate;
        testAction.deadline = deadlineDate;
        testAction.color = [UIColor redColor];
    });
    
    afterAll(^{
        testAction = nil;
        createdDate = nil;
        updatedDate = nil;
        deadlineDate = nil;
        scheduledDate = nil;
        [MagicalRecord cleanUp];
    });
    
    context(@"given it has been initialized", ^{
        
        it(@"should be able to be fetched", ^{
            NSArray *actions = [Action findAll];
            expect([actions count]).to.equal(1);
        });
        
        it(@"should have correct attribute values", ^{
            NSArray *actions = [Action findAll];
            Action *fetchedAction = [actions lastObject];
            expect(fetchedAction.title).to.equal(@"A GTD Action");
            expect(fetchedAction.textDescription).to.equal(@"A long description of the action");
            expect(fetchedAction.priority).to.equal(@(1));
            expect(fetchedAction.created).to.equal(createdDate);
            expect(fetchedAction.updated).to.equal(updatedDate);
            expect(fetchedAction.scheduledDate).to.equal(scheduledDate);
            expect(fetchedAction.deadline).to.equal(deadlineDate);
            expect(fetchedAction.color).to.equal([UIColor redColor]);
        });
        
        it(@"should be able to receive an NSSet of Tags", ^{
            Tag *iosTag = [Tag createEntity];
            iosTag.title = @"iOS";
            iosTag.color = [UIColor blueColor];
            NSSet *tags = [NSSet setWithObject:iosTag];
            [testAction addTags:tags];
            NSSet *fetchedTags = [testAction tags];
            expect([fetchedTags count]).to.equal(1);
            Tag *fetchedTag = [fetchedTags member:iosTag];
            expect(fetchedTag).to.equal(iosTag);
        });
        
        it(@"should be able to have a Context", ^{
            Context *homeContext = [Context createEntity];
            homeContext.name = @"Home";
            homeContext.color = [UIColor yellowColor];
            testAction.context = homeContext;
            Action *fetchedAction = [Action findFirst];
            expect(fetchedAction.context.name).to.equal(@"Home");
        });
        
        it(@"should be able to receive a NSSet of Contacts", ^{
            Contact *natalie = [Contact createEntity];
            Contact *jared = [Contact createEntity];
            NSSet *contacts = [NSSet setWithObjects:natalie, jared, nil];
            [testAction addContacts:contacts];
            Action *fetchedAction = [Action findFirst];
            expect([fetchedAction.contacts count]).to.equal(2);
        });
        
        it(@"should be able to have a Project", ^{
            Project *p1 = [Project createEntity];
            testAction.project = p1;
            Action *fetchedAction = [Action findFirst];
            expect(fetchedAction.project).to.equal(p1);
        });
        
    });
});

SpecEnd
