//
//  AlertHelper.m
//  Pekbok
//
//  Created by Johan Persson on 2013-01-20.
//  Copyright (c) 2013 Johan Persson. All rights reserved.
//

#import "AlertHelper.h"

@implementation AlertHelper

//1. deleteDefaultCategory
//2. deleteDefaultObject
//3. addedObject
//4. addedObjectError
//5. noAudioRecorded

+(UIAlertView *)getAlertMessagefor:(NSString *)forAlert{
    
    UIAlertView *alert;
    if ([forAlert isEqualToString:@"deleteDefaultCategory"])
    {
        alert = [[UIAlertView alloc]initWithTitle:@"Kategorin går ej att ta bort" message:@"Det går inte att ta bort kategorin då den är en del av standardutförandet av appen." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    }
    else if ([forAlert isEqualToString:@"deleteDefaultObject"])
    {
        alert = [[UIAlertView alloc]initWithTitle:@"Objektet går ej att ta bort" message:@"Det går inte att ta bort objektet då den är en del av standardutförandet av appen." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    }
    else if ([forAlert isEqualToString:@"addedObject"])
    {
        alert = [[UIAlertView alloc]initWithTitle:@"Objektet tillagt" message:@"Ditt nya objekt sparades" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Stäng!", nil];
    }
    
    else if ([forAlert isEqualToString:@"addedObjectError"])
    {
        alert = [[UIAlertView alloc]initWithTitle:@"Något gick fel!" message:@"Kontrollera att du valt bild, angett namn och spelat in ljud och försök igen." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Stäng!", nil];
    }
    else if ([forAlert isEqualToString:@"noAudioRecorded"])
    {
        alert = [[UIAlertView alloc]initWithTitle:@"Något gick fel!" message:@"Inget ljud är inspelat" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Stäng!", nil];
    }
    
    else if ([forAlert isEqualToString:@"deleteCategoryWithObjects"])
    {
        alert = [[UIAlertView alloc]initWithTitle:@"Varning" message:@"Kategorin du håller på att ta bort innehåller objekt. Är du säker på att du vill ta bort kategorin" delegate:self cancelButtonTitle:@"Avbryt" otherButtonTitles:@"Ta bort", nil];
        alert.tag = 0;
    }
    
    else if ([forAlert isEqualToString:@"categoryExist"])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Kategorin finns redan" message:@"Du har redan en kategori med detta namnet, välj ett nytt namn och försök igen" delegate:self cancelButtonTitle:@"OK!" otherButtonTitles:nil, nil];
        alert.tag= 1;
    }
    
    return alert;
}
@end
