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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array = [[NSArray alloc] init];
    [self plotUI];
    [self getData];
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
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getData)
                  forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
    _tableView.rowHeight=UITableViewAutomaticDimension;
    
}

// Get data from server
- (void)getData {
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSError *error;
        NSString *string = [NSString stringWithContentsOfURL: [NSURL URLWithString: @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"] encoding:NSISOLatin1StringEncoding error:&error];
        NSData * responseData = [string dataUsingEncoding:NSUTF8StringEncoding];
        jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [self.refreshControl endRefreshing];
            array = [jsonObject objectForKey:@"rows"];
            [_tableView reloadData];
        });
    });
    
    
}

// Table view Delegate & Datasource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"%@",[jsonObject objectForKey:@"title"]];
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
    
    NSDictionary * dict = [array objectAtIndex:indexPath.row];
    cell.imgView.image = [UIImage imageNamed:@"placeholder.png"];
    
    if(![[dict objectForKey:@"imageHref"] isKindOfClass:[NSNull class]])
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"imageHref"]]
                    placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    if(![[dict objectForKey:@"title"] isKindOfClass:[NSNull class]]){
        [cell.titleLabel setText:[NSString stringWithFormat:@"%@", [dict objectForKey:@"title"]]];
    } else {
        cell.titleLabel.text = @"";
    }
    
    if(![[dict objectForKey:@"description"] isKindOfClass:[NSNull class]])
    {
        [cell.descLabel setText:[NSString stringWithFormat:@"%@", [dict objectForKey:@"description"]]];
    }
    else {
        cell.descLabel.text = @"";
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
