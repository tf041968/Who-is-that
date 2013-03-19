//
//  TableViewObject.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-12.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "TableViewObject.h"

@implementation TableViewObject

// TABLE VIEW //
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//    Category *currentCategory = [CategoryNameArray objectAtIndex:[indexPath row]];
//    
//    for (int i = 0; i < CategoryNameArray.count; i++) {
//        Category *cc = [CategoryNameArray objectAtIndex:i];
//        NSLog(@"%@", cc.CategoryName);
//    }
//    
//    cell.textLabel.text = currentCategory.CategoryName;
//    if (currentCategory.checked == TRUE) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    //cell.imageView.image = currentTweet.userImage;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0; //Returnernar arraylängden.
}

//Körs när ma väljer rad i tableviewn.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    Category *selectedCategory = [CategoryNameArray objectAtIndex:indexPath.row];
//    
//    if (selectedCategory.checked == TRUE) {
//        selectedCategory.checked = FALSE;
//    }
//    else{
//        selectedCategory.checked = TRUE;
//    }
//    [tableView reloadData];
//    
    //    [self.view addSubview:tweetDetailView]; //Lägger till vy för att presentera tweet
    //    detailTweet = [tweetArr objectAtIndex:indexPath.row]; //Hämtar tweet att presentera.
    //    [self setStartButtonText]; //Kör startknappsmetod.
    //    detailTweetName.text = detailTweet.name; //Sätter namn på tweet
    //    detailTweetTitle.text = [detailTweet title]; //Sätter title på tweet
    //    twitterImage.image = detailTweet.userImage;
}






@end
