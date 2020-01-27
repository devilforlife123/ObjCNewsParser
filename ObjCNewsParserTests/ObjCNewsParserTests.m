//
//  ObjCNewsParserTests.m
//  ObjCNewsParserTests
//
//  Created by suraj poudel on 28/1/20.
//  Copyright © 2020 suraj poudel. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ObjCNewsParserTests : XCTestCase
@property(nonatomic,strong)NSURLSession * sut;
@end

@implementation ObjCNewsParserTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.sut =
       [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

- (void)tearDown {
    
    self.sut = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testValidGetsHTTPStatusCode200{
    NSURL * url = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    XCTestExpectation * promise = [[XCTestExpectation alloc]initWithDescription:@"Status Code:200"];
    NSURLSessionDataTask * dataTask = [self.sut dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil){
            XCTFail(@"Error: %@", error.localizedDescription);
        }
        NSInteger statusCode = [(NSHTTPURLResponse*)response statusCode];
        if(statusCode == 200){
            XCTFail(@"Status code:%ld",(long)statusCode);
        }else{
            [promise fulfill];
        }
    }];
    [dataTask resume];
    
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
