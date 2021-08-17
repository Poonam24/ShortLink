# ShortLink
A single page app which allow user to short any valid link, see the link history. Along with provision of copying and deleting the particular record from link histrory page.

The application uses third party library RxSwift for reactive Programming, Alamofire for network communication. As per requirement, API integration is done using the documentation [shrtcode API](https://app.shrtco.de/docs).


# Technical Choices : 
1. MVVM Design pattern is used to segregate the business and UI layer.
2. Application Document Directory is used for storage mode.
3. Error handling is done and proper error messages is propagated on screen for user to understand the cause of failure. Validation error for empty field is handled.
4. Unit Testing has been done for ViewModel layer. 


# Testing done on below devices 
1. iPhone SE (2nd Generation)
2. iPhone 11 Pro Max
3. iPhone 11 Pro
4. iPod Touch (7th generation)

# Screenshot

Home

<img width="1440" alt="Screenshot 2021-08-17 at 6 10 05 PM" src="https://user-images.githubusercontent.com/4199763/129727517-2d6a907d-7fd7-42d7-9df2-d6da3662d3a6.png">

Error 

<img width="1440" alt="Screenshot 2021-08-17 at 6 14 01 PM" src="https://user-images.githubusercontent.com/4199763/129728436-b832ec1f-bae1-4a6f-bf0d-7e707c1063e4.png">

Loading and Link Copied

<img width="1437" alt="Screenshot 2021-08-17 at 6 18 50 PM" src="https://user-images.githubusercontent.com/4199763/129728515-bd19412b-ca21-4294-ac80-8145ec195aa9.png">


Link History 

<img width="1440" alt="Screenshot 2021-08-17 at 6 17 38 PM" src="https://user-images.githubusercontent.com/4199763/129728584-3b17cc18-19e6-4a5a-b3b7-62c1debbebc1.png">


With One More Record

![Uploading Screenshot 2021-08-17 at 6.22.06 PM.png…]()













