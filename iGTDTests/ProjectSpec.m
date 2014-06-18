#import <Specta/Specta.h>
#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import "Project.h"
#import "Contact.h"
#import "Context.h"
#import "Action.h"
#import "Tag.h"

SpecBegin(Project)

describe(@"A project", ^{
    
    __block Project *testProject;
    __block NSDate *deadlineDate;
    
    beforeEach(^{
        [MagicalRecord setupCoreDataStackWithInMemoryStore];
        deadlineDate = [NSDate distantFuture];
        testProject = [Project createEntity];
        testProject.name = @"Test Project";
        testProject.textDescription = @"A long text description.";
        testProject.deadline = deadlineDate;
        testProject.color = [UIColor yellowColor];
    });
    
    afterEach(^{
        [MagicalRecord cleanUp];
        testProject = nil;
        deadlineDate = nil;
    });
    
    context(@"given it has been created", ^{
        
        it(@"should be able to be fetched", ^{
            NSArray *projects = [Project findAll];
            Project *fetchedProject = [projects lastObject];
            expect([projects count]).to.equal(1);
            expect(fetchedProject.name).to.equal(@"Test Project");
        });
        
        it(@"should have the correct attribute values", ^{
            Project *fetchedProject = [Project findFirst];
            expect(fetchedProject.name).to.equal(@"Test Project");
            expect(fetchedProject.textDescription).to.equal(@"A long text description.");
            expect(fetchedProject.deadline).to.equal(deadlineDate);
            expect(fetchedProject.color).to.equal([UIColor yellowColor]);
        });
        
        it(@"should be able to have a context", ^{
            Context *testContext = [Context createEntity];
            testContext.name = @"Test Context";
            Project *fetchedProject = [Project findFirst];
            fetchedProject.context = testContext;
            expect(fetchedProject.context.name).to.equal(@"Test Context");
        });
        
        it(@"should be able to take an NSSet of Actions and an Individual Action", ^{
            Action *tAction = [Action createEntity];
            tAction.title = @"Test Action 1";
            NSSet *actions = [NSSet setWithObject:tAction];
            [testProject addActions:actions];
            expect([testProject.actions count]).to.equal(1);
            Action *anotherAction = [Action createEntity];
            [testProject addActionsObject:anotherAction];
            expect([testProject.actions count]).to.equal(2);
        });
        
        it(@"should be able to take an NSSet of Contacts and an individual Contact", ^{
            Contact *tContact = [Contact createEntity];
            tContact.firstName = @"Jared";
        });
        
    });
    
});

SpecEnd
