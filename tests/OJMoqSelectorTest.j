@import "../Framework/OJMoq/OJMoqSelector.j"

@implementation OJMoqSelectorTest : OJTestCase

- (void)testThatSelectorsWithDifferentNamesDoNotEquate
{
    var sel1 = [[OJMoqSelector alloc] initWithName:@"sel1" withArguments:[CPArray array]];
    var sel2 = [[OJMoqSelector alloc] initWithName:@"sel2" withArguments:[CPArray array]];
    [self assert:NO equals:[sel1 equals:sel2]];
    [self assert:NO equals:[sel2 equals:sel1]];
}

- (void)testThatSelectorsWithSameNamesButDifferentArgumentsDontEquate
{
    var sel1 = [[OJMoqSelector alloc] initWithName:@"same" withArguments:[CPArray arrayWithObject:@"yes"]];
    var sel2 = [[OJMoqSelector alloc] initWithName:@"same" withArguments:[CPArray arrayWithObject:@"no"]];
    [self assert:NO equals:[sel1 equals:sel2]];
    [self assert:NO equals:[sel2 equals:sel1]];
}

- (void)testThatSelectorsWithSameNamesAndNoArgumentsEquate
{
    var sel1 = [[OJMoqSelector alloc] initWithName:@"same" withArguments:[CPArray array]];
    var sel2 = [[OJMoqSelector alloc] initWithName:@"same" withArguments:[CPArray array]];
    [self assert:YES equals:[sel1 equals:sel2]];
    [self assert:YES equals:[sel2 equals:sel1]];
}

- (void)testThatSelectorsWithSameNamesAndOneSelectorWithNoArgumentsEquate
{
    var sel1 = [[OJMoqSelector alloc] initWithName:@"same" withArguments:[CPArray arrayWithObject:@"yes"]];
    var sel2 = [[OJMoqSelector alloc] initWithName:@"same" withArguments:[CPArray array]];
    [self assert:YES equals:[sel1 equals:sel2]];
    [self assert:YES equals:[sel2 equals:sel1]];
}

@end
