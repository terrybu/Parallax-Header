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
    
    
    //Variable Row Height Version
//    totalRowsHeight += r;
//    return r;
    
    //Fixed Row Height Version
    return heightTableRow;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        //variable Row Height Version
//        self.tableView.frame = CGRectMake(0, 300, 600, totalRowsHeight/2.75);
//        self.myView.frame = CGRectMake(0,0,600,  totalRowsHeight/2.75);
//        self.scrollView.contentSize = self.myView.frame.size;
        
        
        //Fixed Row Height Version that adjusts to objects count in data array
        double dynamicHeight = (heightTableRow * dataArray.count) + 500; //500 padding
        self.tableView.frame = CGRectMake(0, 300, 600, dynamicHeight);
        self.myView.frame = CGRectMake(0,0,600, dynamicHeight);
        self.scrollView.contentSize = self.myView.frame.size;
    }
    
}



@end
