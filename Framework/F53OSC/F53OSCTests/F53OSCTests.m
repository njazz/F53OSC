//
//  F53OSCTests.m
//  F53OSCTests
//
//  Created by Alex on 04/01/2018.
//  Copyright © 2018 Alex Nadzharov. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "F53OSC.h"

@interface F53OSCTests : XCTestCase

@end

@implementation F53OSCTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testOSCTimeTag
{
    // TODO: all
    //F53OSCTimeTag* t = [F53OSCTimeTag timeTagWithDate:[NSDate dateWithTimeIntervalSinceNow:0]];
}

-(void) testOSCPacket
{
    F53OSCPacket *p = [[F53OSCPacket alloc] init];
    p.replySocket = [F53OSCSocket new];
    
    F53OSCPacket *p2 = [p copy];
    
    XCTAssertEqual(p.replySocket, p2.replySocket);
}

- (void)testOSCBundle
{

    F53OSCBundle* b = [F53OSCBundle bundleWithString:@"test-string"];
    // not yet
    XCTAssertNil([b asQSC]);
    //    XCTAssert([b.asQSC isEqualToString:@"test-string"]);

    F53OSCTimeTag* t = [F53OSCTimeTag immediateTimeTag];
    b = [F53OSCBundle bundleWithTimeTag:t elements:@[ @1, @"two" ]];
    XCTAssert([b.elements[0] intValue] == 1);
    XCTAssert([b.elements[1] isEqualToString:@"two"]);
    XCTAssert(b.timeTag == t);
}


- (void)testOSCMessage
{
    F53OSCMessage* m;
    m = [F53OSCMessage messageWithString:@""];

    m = [F53OSCMessage messageWithString:@"test message"];

    m = [F53OSCMessage messageWithAddressPattern:@"" arguments:@[]];

    m = [F53OSCMessage messageWithAddressPattern:@"/addr" arguments:@[]];

    m = [F53OSCMessage messageWithAddressPattern:@"/addr" arguments:@[ @"str", @2 ]];

    m = [F53OSCMessage messageWithAddressPattern:@"/addr" arguments:@[ @"str", @2 ] replySocket:nil];

    // TODO: withReplySocket
    
    //
    XCTAssert([F53OSCMessage legalMethod:@"legal-method"]);
    XCTAssert(![F53OSCMessage legalMethod:@"illegal method"]);
    XCTAssert(![F53OSCMessage legalMethod:@"illegal_method_жжжж"]);
    
    XCTAssert([F53OSCMessage legalAddress:@"/legal/address"]);
    XCTAssert(![F53OSCMessage legalAddress:@"illegal/address"]);
    XCTAssert(![F53OSCMessage legalAddress:@"/legal/address/жжжж"]);
    
    
}


@end
