//
//  ViewController.m
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 30/04/18.
//
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NetworkUtility.h"
#import "Response.h"
@interface ViewController ()

@end

@implementation ViewController

-(void)loadView {
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]init];
    self.tableView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self.view addSubview:self.tableView];
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    
    [self initTableViewCell];
    
    // Activity Indicator
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake ([[UIScreen mainScreen] bounds].size.width/2 - 40, [[UIScreen mainScreen] bounds].size.height/2 - 40, 80, 80)];
    self.activityIndicatorView.color = [UIColor blackColor];
    [self.view addSubview:self.activityIndicatorView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPullToRefresh];
    [self getDataFromServer];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)startLoader {
    [self.activityIndicatorView startAnimating];
}
-(void)stopLoader {
    [self.activityIndicatorView stopAnimating];
}

-(void)initPullToRefresh {
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getDataFromServer)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:_refreshControl];
    
}
- (void)initTableViewCell {
    
    [self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

// Get data from server
- (void)getDataFromServer {
    
    [self startLoader];
   
    [NetworkUtility apiCallWithCompletion:^(NSDictionary *result, NSError *error) {
        [self stopLoader];
        [self.refreshControl endRefreshing];
        if (!error) {
            response = [[Response alloc] initWithJson:result];
            self.title = [NSString stringWithFormat:@"%@",response.title];
            [self.tableView reloadData];
        }
        else
        {
            [self showPopupWithMessage:@"Some error occurred!"];
        }
    }];
    
    
}

#pragma mark - UITableView Delegate & Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return response.rows.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Row * row = [response.rows objectAtIndex:indexPath.row];
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:row.imageHref]
                    placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    [cell.titleLabel setText:[NSString stringWithFormat:@"%@", row.title]];
    
    [cell.descriptionLabel setText:[NSString stringWithFormat:@"%@", row.desc]];
    
    cell.descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.descriptionLabel.numberOfLines=0;
    
    [cell.descriptionLabel sizeToFit];
    
    return cell;
}

-(void)showPopupWithMessage:(NSString*)message
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {}];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
