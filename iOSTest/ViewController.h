//
//  ViewController.h
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 30/04/18.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * array;
}


@end

