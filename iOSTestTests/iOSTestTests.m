//
//  iOSTestTests.m
//  iOSTestTests
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 05/05/18.
//
//


#import <XCTest/XCTest.h>
#import "ViewController_Private.h"

@interface iOSTestTests : XCTestCase

@property (nonatomic, strong) ViewController *vc;

@end

@implementation iOSTestTests

- (void)setUp
{
    [super setUp];
    self.vc =  [[ViewController alloc] init];
    [self.vc performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
    [super tearDown];
}

#pragma mark - View loading tests
-(void)testThatViewLoads
{
    XCTAssertNotNil(self.vc.view, @"View not initiated properly");
}

- (void)testParentViewHasTableViewSubview
{
    NSArray *subviews = self.vc.view.subviews;
    XCTAssertTrue([subviews containsObject:self.vc.tableView], @"View does not have a table subview");
}

-(void)testThatTableViewLoads
{
    XCTAssertNotNil(self.vc.tableView, @"TableView not initiated");
}

#pragma mark - UITableView tests
- (void)testThatViewConformsToUITableViewDataSource
{
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource
{
    XCTAssertNotNil(self.vc.tableView.dataSource, @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([self.vc conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate
{
    XCTAssertNotNil(self.vc.tableView.delegate, @"Table delegate cannot be nil");
}





@end
