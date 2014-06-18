#import "Contact.h"


@interface Contact ()

// Private interface goes here.

@end


@implementation Contact

// Custom logic goes here.
-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@end
