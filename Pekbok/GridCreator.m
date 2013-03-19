//
//  GridCreator.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-18.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "GridCreator.h"
#import "Category.h"
#import "MyObject.h"
@implementation GridCreator
@synthesize categoryNameArray;

-(UIButton*)CreateImageButtons: (BOOL)isCategory arrayTofix:(NSMutableArray*)array isLandscape:(BOOL)isLandscape{

    if ((isCategory == TRUE)&&(isLandscape==TRUE)) {
        int imageWidth =225;
        int imageHeight =imageWidth*0.75;
        int xCoord = 25;// = previousButton.frame.origin.x + previousButton.frame.size.width ;
        int yCoord = 150;// = previousButton.frame.origin.y ;
        for (int i = 0; i < array.count; i++)
        {
            Category *cat = [[array objectAtIndex:i]objectAtIndex:0];


    UIButton *categoryImageButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [categoryImageButton setBackgroundImage:cat.categoryImage forState:UIControlStateNormal];
    categoryImageButton.tag = i;
    [categoryImageButton addTarget:self action:@selector(objectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //NSLog(@"dadadad %i", newX);
    
    categoryImageButton.frame = CGRectMake(xCoord,yCoord,imageWidth,imageHeight);
    [categoryImageButton setTitle:@"JOhna" forState:UIControlStateNormal];
    
    xCoord = xCoord + categoryImageButton.frame.size.width + 15;
    if (xCoord > (1024*.98)) {
        
        xCoord = 25;
        yCoord = yCoord + 250;
    }
            return categoryImageButton;
    }

}
    else{
        
    }
    return NULL;
    }








//-(void)CreateCategoryLabels{
//    //    UILabel *lblMyLable = [[UILabel alloc] initWithFrame:CGRectMake(50,118, 600, 40)];
//    //    lblMyLable.numberOfLines = 0;//Dynamic
//    //    lblMyLable.tag=1301;
//    //    lblMyLable.backgroundColor = [UIColor clearColor];
//    //    lblMyLable.text = @"One";
//    //    [self.view addSubview:lblMyLable];
//    //    for (int i = 0; i < CategoryNameArray.count; i++) {
//    //
//    //        UIButton *CategoryButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 400, 400)];
//    //    CategoryButton.tag = 1;
//    //    CategoryButton.titleLabel.text = [CategoryNameArray objectAtIndex:i];
//    //        [self.view addSubview:CategoryButton];
//    //    }
//    int width;
//    int height;
//    int imageWidth =225;
//    int imageHeight =imageWidth*0.75;
//    int xCoord = 25;// = previousButton.frame.origin.x + previousButton.frame.size.width ;
//    int yCoord = 150;// = previousButton.frame.origin.y ;
//    for (int i = 0; i < CategoryNameArray.count; i++)
//    {
//        Category *cat = [[CategoryNameArray objectAtIndex:i]objectAtIndex:0];
//        
//        
//        UILabel *CategoryLabels = [[UILabel alloc]initWithFrame:CGRectMake(width*(i+1), (width*2)*(i+1), width*3, height)];
//        CategoryLabels.tag = i;
//        CategoryLabels.text = cat.categoryName;
//        //NSLog(@"antal %i",CategoryNameArray.count);
//        
//        categoryImageButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [categoryImageButton setBackgroundImage:cat.categoryImage forState:UIControlStateNormal];
//        categoryImageButton.tag = i;
//        [categoryImageButton addTarget:self action:@selector(objectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//        //NSLog(@"dadadad %i", newX);
//        
//        categoryImageButton.frame = CGRectMake(xCoord,yCoord,imageWidth,imageHeight);
//        [categoryImageButton setTitle:@"JOhna" forState:UIControlStateNormal];
//        
//        xCoord = xCoord + categoryImageButton.frame.size.width + 15;
//        if (xCoord > (self.view.frame.size.width*.98)) {
//            
//            xCoord = 25;
//            yCoord = yCoord + 250;
//        }
//        
//        
//        [self.view addSubview:categoryImageButton];
//        [self.view addSubview:CategoryLabels];
//    }
//    
//    
//    //[image drawInRect:CGRectMake((self.frame.size.width/2) - (image.size.with/2), (self.frame.size.height / 2) - (image.size.height / 2), image.size.width, image.size.height)];
//    
//    
//}


//-(NSMutableArray*)CreateDefaultCategories{
//   categoryNameArray = [[NSMutableArray alloc]initWithObjects:@"Familj",@"Djur",@"Fordon",@"Mat", nil];
//  //  UIImage *btnImage = [UIImage imageNamed:@"user.jpg"];
//    
////    for (int i =0; i < defaultCategories.count; i++) {
////        Category *category = [[Category alloc]init];
////        category.categoryName = [defaultCategories objectAtIndex:i];
////        category.checked = true;
////        category.categoryImage = btnImage;
////        
////        // UIImage *btnImage = [UIImage imageNamed:@"user.jpg"];
////        //    UIImage *stretchableButtonImage = [btnImage stretchableImageWithLeftCapWidth:12 topCapHeight:0];
////        
////        
////        [[categoryNameArray objectAtIndex:i] addObject:category];
//        // get the value
//        
//    }
//    
//    return categoryNameArray;
//}

-(NSMutableArray*)CreateDefaultObjects: (NSMutableArray*)CategoryNameArray{
    NSMutableArray *defaultObjects = [[NSMutableArray alloc]initWithObjects:@"Mamma",@"Pappa", nil];
    for (int i = 0; i < defaultObjects.count; i++) {
        MyObject *categoryObjName = [[MyObject alloc]init];
        categoryObjName.name = [defaultObjects objectAtIndex:i];
        categoryObjName.checked = TRUE;
        [[CategoryNameArray objectAtIndex:0]addObject:categoryObjName];
    }
    return CategoryNameArray;
}

@end