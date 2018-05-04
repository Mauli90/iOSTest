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
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array = [[NSArray alloc] init];
    
    [self plotUI];
    
    // Activity Indicator
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake (UIScreen.mainScreen.bounds.size.width/2 - 40, UIScreen.mainScreen.bounds.size.height/2 - 40, 80, 80)];
    self.activityIndicatorView.color = [UIColor blackColor];
    [self.view addSubview:self.activityIndicatorView];
    
    [self getDataFromServer];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)startLoader{
    [self.activityIndicatorView startAnimating];
}
-(void)stopLoader{
    [self.activityIndicatorView stopAnimating];
}
// Programatically UI plot
- (void)plotUI{
    int width = [[UIScreen mainScreen] bounds].size.width;
    int height = [[UIScreen mainScreen] bounds].size.height;
    
    // Table view implimentation
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0,0,width,height);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"Cell"];
    [_tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [_tableView reloadData];
    [self.view addSubview:_tableView];
    
    
    // Pull to refresh
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getDataFromServer)
                  forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    _tableView.rowHeight=UITableViewAutomaticDimension;
    
}

// Get data from server
- (void)getDataFromServer {
    [self startLoader];
    [NetworkUtility apiCallWithCompletion:^(NSDictionary *result, NSError *error) {
        if (error == nil) {
            jsonObject = result;
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self stopLoader];
                
                [self.refreshControl endRefreshing];
                array = [jsonObject objectForKey:@"rows"];
                self.title = [NSString stringWithFormat:@"%@",[jsonObject objectForKey:@"title"]];
                [_tableView reloadData];
            });
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self stopLoader];
                
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                               message:@"Some error occurred!"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {}];
                
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            });
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
