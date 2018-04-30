//
//  ViewController.m
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 30/04/18.
//
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array = [[NSArray alloc] init];
    [self plotUI];

    // Do any additional setup after loading the view, typically from a nib.
}
// Programatically UI plot
- (void)plotUI{
    int width = [[UIScreen mainScreen] bounds].size.width;
    int height = [[UIScreen mainScreen] bounds].size.height;
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0,20,width,height);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"Cell"];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_tableView reloadData];
    [self.view addSubview:_tableView];
   
}



// Table view Delegate & Datasource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
