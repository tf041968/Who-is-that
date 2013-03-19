//
//  Obj+Create.m
//  Pekbok
//
//  Created by Johan Persson on 2012-10-23.
//  Copyright (c) 2012 Johan Persson. All rights reserved.
//

#import "Obj+Create.h"
#import "Cat.h"

@implementation Obj (Create)

+(Obj *)createObjects:(NSString*)name inCategory:(NSNumber *)categoryID withThumbURL:(NSString *)imageThumbURL withFullSizeURL:(NSString *)imageFullURL isDefault:(BOOL)isDefault inManagedObjectContext:(NSManagedObjectContext *)context soundForObject:(NSString *)soundURL{
    
    NSError *error = nil;
    NSFetchRequest *catrequest = [NSFetchRequest fetchRequestWithEntityName:@"Cat"]; //Hämtar entitet från databasen
    NSLog(@"vikken categori %@", categoryID);
    catrequest.predicate = [NSPredicate predicateWithFormat:@"categoryID == %@", categoryID]; //Sorterar ut så att rätt kategori laddas
    NSArray *catmatches = [context executeFetchRequest:catrequest error:&error]; //Hämtar fr. databasen.
    
    Cat *cat = [catmatches objectAtIndex:0];
    //if (!catmatches.count  == 0) {
    //  cat = [catmatches objectAtIndex:0]; //Tar första objektet. Ska bara finnas ett.
    //}
    Obj *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Obj" inManagedObjectContext:context]; //Skapar nytt obj
    obj.name = name; //Sätter namn
    obj.belongsTo = cat; //Sätter relation till vilken kategori det ska finnas i.
    obj.imageThumbUrl = imageThumbURL; //Sätter bild.
    obj.imageFullUrl = imageFullURL;
    obj.sound = soundURL; //Sätter ljud.
    obj.isDefault = [NSNumber numberWithBool:isDefault];
    [context save:&error];

    return obj; //Returnerar objektet
}








//+(Obj *)createObjects:(NSString*)name inCategory:(NSNumber *)categoryID withImage:(UIImage *)image inManagedObjectContext:(NSManagedObjectContext *)context soundForObject:(NSString *)soundURL{
//
//    NSError *error = nil;
//    NSFetchRequest *catrequest = [NSFetchRequest fetchRequestWithEntityName:@"Cat"]; //Hämtar entitet från databasen
//    NSLog(@"vikken categori %@", categoryID);
//    catrequest.predicate = [NSPredicate predicateWithFormat:@"categoryID == %@", categoryID]; //Sorterar ut så att rätt kategori laddas
//    NSArray *catmatches = [context executeFetchRequest:catrequest error:&error]; //Hämtar fr. databasen.
//    NSLog(@"fjalkfakdf %@", catmatches);
//    NSLog(@"caaaaaaat %i", catmatches.count);
//    Cat *cat = [catmatches objectAtIndex:0];
//    //if (!catmatches.count  == 0) {
//      //  cat = [catmatches objectAtIndex:0]; //Tar första objektet. Ska bara finnas ett.
//    //}
//    Obj *obj = [NSEntityDescription insertNewObjectForEntityForName:@"Obj" inManagedObjectContext:context]; //Skapar nytt obj
//    obj.name = name; //Sätter namn
//    obj.belongsTo = cat; //Sätter relation till vilken kategori det ska finnas i.
//    obj.image = image; //Sätter bild.
//    obj.sound = soundURL; //Sätter ljud.
//
//    return obj; //Returnerar objektet
//}

+(void)CreateObjectsFromArray:(NSMutableArray *)arrayOfAnimals fromContext:(NSManagedObjectContext *)context{
    
    for (int i = 0; i < arrayOfAnimals.count; i++) {
        NSLog(@"var skapas objekten%@", [[arrayOfAnimals objectAtIndex:i]objectAtIndex:1]);
//        [Obj createObjects:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:0] inCategory:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:1] withImage:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:2] inManagedObjectContext:context soundForObject:[[arrayOfAnimals objectAtIndex:i]objectAtIndex:3]];
    }
    
}


@end
