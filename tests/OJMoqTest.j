@import "../Framework/OJMoq/OJMoq.j"

@implementation OJMoqTest : OJTestCase

- (void)testThatOJMoqDoesInitialize_functional
{
	// functional way of instantiation
	var aMock = moq();
	[self assertNotNull:aMock];
}

- (void)testThatOJMoqDoesInitializeWithBaseObject_functional
{
	// functional way of instantiation
	var aMock = moq(@"Test");
	[self assertNotNull:aMock];
}

- (void)testThatOJMoqDoesInitializeWithBaseObject_class
{
	// object-oriented, class method way of instatiation
	var aMock = [OJMoq mockBaseObject:@"Test"];
	[self assertNotNull:aMock];
}

- (void)testThatOJMoqDoesInitializeWithBaseObject_instance
{
	// object-oriented, instanced method way of instatiation
	var aMock = [[OJMoq alloc] initWithBaseObject:@"Test"];
	[self assertNotNull:aMock];
}

- (void)testThatOJMoqDoesVerifyAnExpectation
{
	var aMock = moq();
	[aMock expectSelector:@selector(a) times:1];
	[aMock a];
	[aMock verifyThatAllExpectationsHaveBeenMet];
}

- (void)testThatOJMoqDoesVerifyMultipleExpectations
{
	var aMock = moq();
	[aMock expectSelector:@selector(a) times:1];
	[aMock expectSelector:@selector(b) times:1];
	[aMock a];
	[aMock b];
	[aMock verifyThatAllExpectationsHaveBeenMet];
}

- (void)testThatOJMoqDoesInvalidateAnExpectation
{
	var aMock = moq();
	[aMock expectSelector:@selector(a) times:2];
	[aMock a];
	[self assertThrows:function(){[mock verifyThatAllExpectationsHaveBeenMet];}];
}

- (void)testThatOJMoqDoesInvalidateAnExpectationThatHasNeverBeenCalled
{
	var aMock = moq();
	[aMock expectSelector:@selector(a) times:1];
	[self assertThrows:function(){[mock verifyThatAllExpectationsHaveBeenMet];}];
}

// AKA Stubbing!
- (void)testThatOJMoqDoesReturnForAnyCall
{
	var aMock = moq();
	var returnValue = [aMock a];
	[self assertNotNull:returnValue];
}

- (void)testThatOJMoqDoesReturnSetValue
{
	var aMock = moq();
	var returnValue = "Return";
	[aMock selector:@selector(a) returns:returnValue];
	[self assert:[aMock a] equals:returnValue];
}

- (void)testThatOJMoqDoesDistinguishBetweenArguments
{
	var aMock = moq();
	[aMock expectSelector:@selector(a:) times:1 withArguments:[CPArray arrayWithObject:@"Arg1"]];
	[aMock expectSelector:@selector(a:) times:1 withArguments:[CPArray arrayWithObject:@"Arg2"]];
	[aMock a:@"Arg1"];
	[aMock a:@"Arg2"];
	[aMock verifyThatAllExpectationsHaveBeenMet];
}

- (void)testThatOJMoqDoesDistinguishBetweenArgumentsAndThrowWhenNotMet
{
	var aMock = moq();
	[aMock expectSelector:@selector(a:) times:1 withArguments:[CPArray arrayWithObject:@"Arg1"]];
	[aMock expectSelector:@selector(a:) times:1 withArguments:[CPArray arrayWithObject:@"Arg2"]];
	[aMock a:@"Arg1"];
	[self assertThrows:function(){[mock verifyThatAllExpectationsHaveBeenMet];}];
}

- (void)testThatOJMoqDoesThrowWhenCalledTooMuch
{
	var aMock = moq();
	[aMock expectSelector:@selector(a) times:2];
	[aMock a];
	[aMock a];
	[self assertThrows:function(){[mock verifyThatAllExpectationsHaveBeenMet];}];
}

- (void)testThatOJMoqDoesThrowWhenCalledTooLittle
{
	var aMock = moq();
	[aMock expectSelector:@selector(a) times:2];
	[aMock a];
	[self assertThrows:function(){[mock verifyThatAllExpectationsHaveBeenMet];}];
}

- (void)testThatOJMoqDoesDistinguishBetweenArgumentsWhenGettingReturnValue
{
	var aMock = moq();
	var returnValue = "Value";
	[aMock selector:@selector(a:) withArguments:[CPArray arrayWithObject:@"Arg1"] returns:returnValue];
	[self assert:[aMock a:@"Arg1"] equals:returnValue];
	[self assert:[aMock a:@"Arg2"] notEqual:returnValue];
}

// Adding these because ojtest does not have them. Should eventually
// do a pull request for these.
- (void)assert:(id)expected notEqual:(id)actual
{
    [self assert:expected notEqual:actual message:nil];
}

- (void)assert:(id)expected notEqual:(id)actual message:(CPString)message
{
    if (expected === actual || [expected isEqual:actual])
        [self failEqual:expected actual:actual message:message];
}

- (void)failEqual:(id)expected actual:(id)actual message:(CPString)message
{
    [self fail:((message ? message+" " : "")+"expected inequality. Expected:<"+expected+"> Got:<"+actual+">")];
}

// Only necessarily until new release of ojtest.
// I don't need this (on the 0.8 branch) but leaving it
// for compatibility reasons. When 0.8 is officially
// released, I will remove this finally.
- (void)assertThrows:(Function)zeroArgClosure
{
    var exception = nil;
    try { zeroArgClosure(); }
    catch (e) { exception = e; }
    [self assertNotNull:exception message:"Should have caught an exception, but got nothing"];
}

@end