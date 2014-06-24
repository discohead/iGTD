#import "Project.h"


@interface Project ()

// Private interface goes here.

@end


@implementation Project

// Custom logic goes here.

- (NSString *)description
{
    return self.name;
}

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    self.created = [NSDate date];
}

@end
