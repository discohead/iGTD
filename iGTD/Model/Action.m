#import "Action.h"


@interface Action ()

// Private interface goes here.

@end


@implementation Action

// Custom logic goes here.

-(NSString *)description
{
    return self.title;
}

- (void)awakeFromInsert
{
    [super awakeFromInsert];
    self.created = [NSDate date];
}

@end
