//
//  FirstViewController.h
//  ParallaxHeaderFromScratch
//
//  Created by Aditya Narayan on 11/4/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
    
    BOOL dummyVar;
    
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *myView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
