//
//  ViewController.h
//  iOSTest
//
//  Created by Dnyaneshwar Balkrushna Wakchaure on 30/04/18.
//
//

#import <UIKit/UIKit.h>
#import "Response.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    Response * response;
}
@property (nonatomic, strong) UIRefreshControl *  refreshControl;


@end

