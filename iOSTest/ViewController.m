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

@interface ViewController ()
{
    UITableView *tableView;
}
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation ViewController
-(void)loadView{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor whiteColor];
    tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
   
    
    // Activity Indicator
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake ([[UIScreen mainScreen] bounds].size.width/2 - 40, [[UIScreen mainScreen] bounds].size.height/2 - 40, 80, 80)];
    self.activityIndicatorView.color = [UIColor blackColor];
    [self.view addSubview:self.activityIndicatorView];
    
    [self initTableViewCell];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    array = [[NSArray alloc] init];
    [self getDataFromServer];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)startLoader{
    [self.activityIndicatorView startAnimating];
}
-(void)stopLoader{
    [self.activityIndicatorView stopAnimating];
}
- (void)initTableViewCell{
    // Table view implimentation

    [tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [tableView reloadData];
    
    
    // Pull to refresh
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getDataFromServer)
                  forControlEvents:UIControlEventValueChanged];
    [tableView addSubview:_refreshControl];
    tableView.rowHeight=UITableViewAutomaticDimension;
    
}

// Get data from server
- (void)getDataFromServer {
    
    [self startLoader];
    [NetworkUtility apiCallWithCompletion:^(NSDictionary *result, NSError *error) {
        [self stopLoader];
        if (error == nil) {
            jsonObject = result;
            [self.refreshControl endRefreshing];
            array = [jsonObject objectForKey:@"rows"];
            self.title = [NSString stringWithFormat:@"%@",[jsonObject objectForKey:@"title"]];
            [tableView reloadData];
            
        }
        else
        {
            [self stopLoader];
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                           message:@"Some error occurred!"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {}];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    
    
}

// Table view Delegate & Datasource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
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
    
    NSDictionary * dict = [array objectAtIndex:indexPath.row];
    
    cell.imgView.image = [UIImage imageNamed:@"placeholder.png"];
    if(![[dict objectForKey:@"imageHref"] isKindOfClass:[NSNull class]])
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"imageHref"]]
                        placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    cell.titleLabel.text = @"";
    if(![[dict objectForKey:@"title"] isKindOfClass:[NSNull class]]){
        [cell.titleLabel setText:[NSString stringWithFormat:@"%@", [dict objectForKey:@"title"]]];
    }
    
    cell.descLabel.text = @"";
    if(![[dict objectForKey:@"description"] isKindOfClass:[NSNull class]]){
        [cell.descLabel setText:[NSString stringWithFormat:@"%@", [dict objectForKey:@"description"]]];
    }
    
    
    cell.descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.descLabel.numberOfLines=0;
    [cell.descLabel sizeToFit];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
