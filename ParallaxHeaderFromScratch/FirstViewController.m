//
//  FirstViewController.m
//  ParallaxHeaderFromScratch
//
//  Created by Aditya Narayan on 11/4/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

#import "FirstViewController.h"
#define scrollDistanceUnit 3

@interface FirstViewController () {
    CGFloat imageViewYCoordinate;
    CGFloat tableViewYCoordinate;
    
    NSMutableArray* dataArray;
    CGFloat heightTableRow;
    
    CGFloat totalRowsHeight;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    heightTableRow = 54;
    
    //Fill an array with some data
    dataArray = [[NSMutableArray alloc]init];
    for (int i=0; i <= 100; i++) {
        [dataArray addObject:[NSString stringWithFormat:@"%d hi", i]];
    }
    
    self.scrollView.contentSize = self.myView.frame.size;
    self.scrollView.delegate = self;
    
    self.tableView.scrollEnabled = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    imageViewYCoordinate = self.imageView.frame.origin.y;
    tableViewYCoordinate = self.tableView.frame.origin.y;
    UIGraphicsBeginImageContext(self.view.bounds.size);
}



//- (void)viewDidLayoutSubviews {
//    
//    double dynamicHeight = (heightTableRow * dataArray.count);
//    self.tableView.frame = CGRectMake(0, 300, 600, 5000 + dynamicHeight);
//    self.myView.frame = CGRectMake(0,0,600, 5000 + dynamicHeight);
//    self.scrollView.contentSize = self.myView.frame.size;

//fixed height scenarios, it's a lot easier. What do you do when your row heights are variable?
//}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        float distMoved = scrollView.contentOffset.y;
        imageViewYCoordinate = distMoved/2;
        //imageview's y coordinate will be equal to 1/2 of the distance the scrollview traveled
    
        self.imageView.frame = CGRectMake(0, imageViewYCoordinate, 500, 300);
        self.imageView.alpha = 1 - imageViewYCoordinate/200.0f;
    
        NSLog(@"------------------------------");
        NSLog(@"scrollview offset = %@", NSStringFromCGPoint(scrollView.contentOffset));
        NSLog(@"Distance moved = %f",distMoved);
        NSLog(@"Current imageview frame = %@ \n\n\n", NSStringFromCGRect(self.imageView.frame));
        NSLog(@"Current tableview frame = %@ \n\n\n", NSStringFromCGRect(self.tableView.frame));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    int r = arc4random_uniform(200);
    
    if (r<72) {
        
        r = r + 25;
        
        
    }
    
    totalRowsHeight += r;
    
    return r;
    
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        self.tableView.frame = CGRectMake(0, 300, 600, totalRowsHeight/3);
        self.myView.frame = CGRectMake(0,0,600,  totalRowsHeight/3);
        self.scrollView.contentSize = self.myView.frame.size;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    int r = arc4random_uniform(500);
//    
//    if (r<300) {
//        
//        r = r + 25;
//        
//        
//    }

    
//    double dynamicHeight = (heightTableRow * dataArray.count) + r;
    //the 500 number is just padding. If we don't have this padding, some rows in the bottom will get hidden which sucks. We can adjust this value to determine how much whitespace we have after the very last row with data
    
//    self.tableView.frame = CGRectMake(0, 300, 600, dynamicHeight);
//    self.myView.frame = CGRectMake(0,0,600, 10000);
//    self.scrollView.contentSize = self.myView.frame.size;
    
}

@end
