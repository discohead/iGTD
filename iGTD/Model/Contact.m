#import "Contact.h"


@interface Contact ()

// Private interface goes here.

@end


@implementation Contact

// Custom logic goes here.
-(NSString *)description
{
    return self.name;
}

-(NSString *)name {
    
    [self willAccessValueForKey:@"name"];
    
    NSString *fullName = [@[self.firstName, self.lastName] componentsJoinedByString:@" "];
    
    [self didAccessValueForKey:@"name"];
    
    return fullName;
}

@end
